import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../services/app_config.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final api = ApiService(AppConfig.apiBaseUrl);
  final text = TextEditingController();
  final msgs = <String>['AI: What is your full name?'];
  Map<String, dynamic> state = {};
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          const Align(alignment: Alignment.centerLeft, child: Text('AI Chat', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold))),
          const SizedBox(height: 12),
          Expanded(
            child: Card(
              child: ListView.builder(
                itemCount: msgs.length,
                itemBuilder: (_, i) => ListTile(title: Text(msgs[i])),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Row(children: [
            Expanded(child: TextField(controller: text, decoration: const InputDecoration(hintText: 'Type reply...'))),
            IconButton(onPressed: loading ? null : _send, icon: const Icon(Icons.send))
          ])
        ]),
      ),
    );
  }

  Future<void> _send() async {
    final input = text.text.trim();
    if (input.isEmpty) return;
    text.clear();
    setState(() { msgs.add('You: $input'); loading = true; });
    try {
      final r = await api.chat(input, state);
      setState(() { state = Map<String, dynamic>.from(r['state']); msgs.add('AI: ${r['reply']}'); });
    } catch (e) {
      setState(() => msgs.add('Error: $e'));
    } finally {
      setState(() => loading = false);
    }
  }
}
