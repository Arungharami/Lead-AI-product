import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/api_service.dart';
import '../services/auth_service.dart';
import '../services/app_config.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final api = ApiService(AppConfig.apiBaseUrl);
  final ctrl = TextEditingController();
  final messages = <String>['AI: What is your full name?'];
  Map<String, dynamic> state = {};
  bool complete = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AI Lead Chat')),
      body: Column(children: [
        Expanded(child: ListView(children: messages.map((m) => ListTile(title: Text(m))).toList())),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Row(children: [Expanded(child: TextField(controller: ctrl)), IconButton(onPressed: _send, icon: const Icon(Icons.send))]),
        ),
        if (complete)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(onPressed: () async {
              final token = await context.read<AuthService>().idToken();
              await api.saveLead(state, token);
              if (!mounted) return;
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Lead saved')));
            }, child: const Text('Save Lead')),
          )
      ]),
    );
  }

  Future<void> _send() async {
    final text = ctrl.text;
    ctrl.clear();
    setState(() => messages.add('You: $text'));
    final res = await api.chat(text, state);
    setState(() {
      state = Map<String, dynamic>.from(res['state']);
      complete = res['complete'];
      messages.add('AI: ${res['reply']}');
    });
  }
}
