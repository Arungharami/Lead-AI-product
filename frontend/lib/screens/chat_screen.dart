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
  final input = TextEditingController();
  final messages = <_Msg>[];
  bool isLoading = false;
  bool leadDetected = false;
  Map<String, dynamic> lead = {'name': '', 'phone': '', 'email': '', 'need': ''};

  @override
  void initState() {
    super.initState();
    messages.add(const _Msg(text: 'Hi! I am your AI lead-capture assistant. How can I help?', isUser: false));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Align(alignment: Alignment.centerLeft, child: Text('AI Chat', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold))),
            const SizedBox(height: 12),
            Expanded(
              child: Card(
                child: ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: messages.length,
                  itemBuilder: (_, i) => Align(
                    alignment: messages[i].isUser ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: messages[i].isUser ? const Color(0xFF2563EB) : const Color(0xFF1F2937),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(messages[i].text),
                    ),
                  ),
                ),
              ),
            ),
            if (isLoading) const Padding(padding: EdgeInsets.all(8), child: CircularProgressIndicator()),
            if (leadDetected)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _saveLead,
                  child: const Text('Save Lead'),
                ),
              ),
            Row(
              children: [
                Expanded(child: TextField(controller: input, decoration: const InputDecoration(hintText: 'Type your message'))),
                IconButton(onPressed: isLoading ? null : _send, icon: const Icon(Icons.send)),
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<void> _send() async {
    final text = input.text.trim();
    if (text.isEmpty) return;
    input.clear();
    setState(() {
      messages.add(_Msg(text: text, isUser: true));
      isLoading = true;
    });

    try {
      final res = await api.chat(text);
      setState(() {
        messages.add(_Msg(text: (res['reply'] ?? '').toString(), isUser: false));
        leadDetected = res['lead_detected'] == true;
        lead = Map<String, dynamic>.from(res['lead'] ?? lead);
      });
    } catch (e) {
      setState(() => messages.add(_Msg(text: 'Error: $e', isUser: false)));
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> _saveLead() async {
    try {
      await api.saveLead(lead, AppConfig.demoToken);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Lead saved successfully')));
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Save failed: $e')));
    }
  }
}

class _Msg {
  final String text;
  final bool isUser;
  const _Msg({required this.text, required this.isUser});
}
