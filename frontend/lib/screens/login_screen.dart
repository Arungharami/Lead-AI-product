import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';
import 'dashboard_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final email = TextEditingController();
  final pass = TextEditingController();
  bool signup = false;

  @override
  Widget build(BuildContext context) {
    final auth = context.read<AuthService>();
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 320,
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            const Text('Lead.AI', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
            TextField(controller: email, decoration: const InputDecoration(labelText: 'Email')),
            TextField(controller: pass, obscureText: true, decoration: const InputDecoration(labelText: 'Password')),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                if (signup) { await auth.signup(email.text, pass.text); } else { await auth.login(email.text, pass.text); }
                if (!mounted) return;
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const DashboardScreen()));
              },
              child: Text(signup ? 'Sign Up' : 'Login'),
            ),
            TextButton(onPressed: () => setState(() => signup = !signup), child: Text(signup ? 'Have account? Login' : 'New user? Sign Up'))
          ]),
        ),
      ),
    );
  }
}
