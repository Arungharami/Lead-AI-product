import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final email = TextEditingController();
  final password = TextEditingController();
  bool isSignup = false;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final auth = context.read<AuthService>();
    return Scaffold(
      body: Center(
        child: Card(
          child: SizedBox(
            width: 340,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                const Text('Lead.AI', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                const SizedBox(height: 6),
                Text(isSignup ? 'Create account' : 'Login'),
                TextField(controller: email, decoration: const InputDecoration(labelText: 'Email')),
                TextField(controller: password, decoration: const InputDecoration(labelText: 'Password'), obscureText: true),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: loading
                      ? null
                      : () async {
                          setState(() => loading = true);
                          try {
                            if (isSignup) {
                              await auth.signup(email.text, password.text);
                            } else {
                              await auth.login(email.text, password.text);
                            }
                          } catch (e) {
                            if (!mounted) return;
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
                          } finally {
                            if (mounted) setState(() => loading = false);
                          }
                        },
                  child: Text(isSignup ? 'Sign up' : 'Login'),
                ),
                TextButton(
                  onPressed: () => setState(() => isSignup = !isSignup),
                  child: Text(isSignup ? 'Have account? Login' : 'New user? Sign up'),
                )
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
