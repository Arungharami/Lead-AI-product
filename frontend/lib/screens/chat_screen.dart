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
  final scrollController = ScrollController();
  final messages = <String>['AI: What is your full name?'];
  Map<String, dynamic> state = {};
  bool complete = false;
  bool sending = false;

  @override
  void dispose() {
    ctrl.dispose();
    scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AI Lead Chat')),
      body: Column(children: [
        Expanded(
          child: ListView.builder(
            controller: scrollController,
            itemCount: messages.length,
            itemBuilder: (_, index) => ListTile(title: Text(messages[index])),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Row(children: [
            Expanded(
              child: TextField(
                controller: ctrl,
                onSubmitted: (_) => _send(),
                decoration: const InputDecoration(hintText: 'Type your message...'),
              ),
            ),
            IconButton(
              onPressed: sending ? null : _send,
              icon: sending ? const CircularProgressIndicator() : const Icon(Icons.send),
            ),
          ]),
        ),
        if (complete)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () async {
                final token = await context.read<AuthService>().idToken();
                if (token == null) {
                  if (!mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Sign in required to save lead')));
                  return;
                }
                try {
                  await api.saveLead(state, token);
                  if (!mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Lead saved')));
                } catch (error) {
                  if (!mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Save failed: $error')));
                }
              },
              child: const Text('Save Lead'),
            ),
          ),
      ]),
    );
  }

  Future<void> _send() async {
    final text = ctrl.text.trim();
    if (text.isEmpty || sending) {
      return;
    }

    setState(() {
      sending = true;
      messages.add('You: $text');
      ctrl.clear();
    });

    try {
      final res = await api.chat(text, state);
      setState(() {
        state = Map<String, dynamic>.from(res['state']);
        complete = res['complete'];
        messages.add('AI: ${res['reply']}');
      });
      _scrollToBottom();
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Chat failed: $error')));
    } finally {
      if (!mounted) return;
      setState(() => sending = false);
    }
  }
}
