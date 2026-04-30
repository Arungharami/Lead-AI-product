import 'package:flutter/material.dart';
import 'chat_screen.dart';
import 'leads_screen.dart';
import 'subscription_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Widget card(String t, String v) => Card(child: Padding(padding: const EdgeInsets.all(16), child: Column(children: [Text(t), Text(v, style: const TextStyle(fontSize: 24))])));
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          Row(children: [Expanded(child: card('Total Leads', '--')), const SizedBox(width: 12), Expanded(child: card("Today's Leads", '--'))]),
          const SizedBox(height: 20),
          ElevatedButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ChatScreen())), child: const Text('Open AI Chat')),
          ElevatedButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LeadsScreen())), child: const Text('View Leads')),
          OutlinedButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SubscriptionScreen())), child: const Text('Subscription')),
        ]),
      ),
    );
  }
}
