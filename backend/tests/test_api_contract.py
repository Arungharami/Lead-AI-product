import unittest
from unittest.mock import MagicMock, patch

from fastapi.testclient import TestClient

from app.main import app
from app.services.deps import user_from_auth_header


class TestApiContract(unittest.TestCase):
    def setUp(self):
        self.client = TestClient(app)

    def tearDown(self):
        app.dependency_overrides.clear()

    def test_health_runs_without_provider_credentials(self):
        self.assertEqual(self.client.get("/health").json(), {"status": "ok"})

    def test_missing_auth_is_unauthorized(self):
        self.assertEqual(self.client.get("/leads").status_code, 401)
        self.assertEqual(self.client.get("/leads", headers={"Authorization": "Bearer "}).status_code, 401)

    @patch("app.services.deps.get_firebase_app")
    @patch("app.services.deps.auth.verify_id_token", side_effect=ValueError("invalid"))
    def test_invalid_auth_returns_401(self, verify, firebase_app):
        response = self.client.get("/leads", headers={"Authorization": "Bearer bad-token"})
        self.assertEqual(response.status_code, 401)
        verify.assert_called_once_with("bad-token", app=firebase_app.return_value)

    def test_completed_state_uses_mobile_contract_without_model_call(self):
        state = {"name": "Test", "phone": "555", "email": "test@example.com", "need": "demo"}
        response = self.client.post("/chat", json={"message": "thanks", "state": state})
        self.assertEqual(response.status_code, 200)
        self.assertTrue(response.json()["complete"])
        self.assertEqual(response.json()["state"], state)

    @patch("app.api.routes.get_openai_client")
    def test_malformed_model_output_is_reported_as_502(self, provider):
        completion = MagicMock()
        completion.choices[0].message.content = "[]"
        provider.return_value.chat.completions.create.return_value = completion
        response = self.client.post("/chat", json={"message": "hello"})
        self.assertEqual(response.status_code, 502)

    @patch("app.api.routes.get_db")
    def test_saved_lead_is_owned_by_authenticated_user(self, database):
        app.dependency_overrides[user_from_auth_header] = lambda: "test-user"
        reference = database.return_value.collection.return_value.document.return_value
        reference.id = "lead-1"
        response = self.client.post("/lead", json={
            "name": "Test", "phone": "555", "email": "test@example.com", "need": "demo"
        })
        self.assertEqual(response.status_code, 200)
        self.assertEqual(response.json()["user_id"], "test-user")
        self.assertEqual(reference.set.call_args.args[0]["user_id"], "test-user")
