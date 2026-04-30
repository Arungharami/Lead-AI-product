import 'package:flutter/material.dart';
import '../main.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              const Text('Lead.AI', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              const Text('Login placeholder'),
              const SizedBox(height: 16),
              SizedBox(
                width: 260,
                child: ElevatedButton(
                  onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const AppShell())),
                  child: const Text('Continue'),
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
