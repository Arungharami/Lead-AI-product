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
  final formKey = GlobalKey<FormState>();
  bool signup = false;
  bool loading = false;
  String? errorMessage;

  @override
  void dispose() {
    email.dispose();
    pass.dispose();
    super.dispose();
  }

  Future<void> _authenticate(AuthService auth) async {
    if (!formKey.currentState!.validate()) return;

    setState(() {
      loading = true;
      errorMessage = null;
    });

    try {
      if (signup) {
        await auth.signup(email.text.trim(), pass.text.trim());
      } else {
        await auth.login(email.text.trim(), pass.text.trim());
      }
      if (!mounted) return;
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const DashboardScreen()));
    } catch (error) {
      if (!mounted) return;
      setState(() => errorMessage = error.toString());
    } finally {
      if (!mounted) return;
      setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.read<AuthService>();

    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 360,
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Lead.AI', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                TextFormField(
                  controller: email,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(labelText: 'Email'),
                  validator: (value) => value == null || value.isEmpty ? 'Email is required' : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: pass,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: 'Password'),
                  validator: (value) => value == null || value.isEmpty ? 'Password is required' : null,
                ),
                const SizedBox(height: 16),
                if (errorMessage != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Text(errorMessage!, style: const TextStyle(color: Colors.redAccent)),
                  ),
                ElevatedButton(
                  onPressed: loading ? null : () => _authenticate(auth),
                  child: loading
                      ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                      : Text(signup ? 'Sign Up' : 'Login'),
                ),
                TextButton(
                  onPressed: loading ? null : () => setState(() => signup = !signup),
                  child: Text(signup ? 'Have account? Login' : 'New user? Sign Up'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
