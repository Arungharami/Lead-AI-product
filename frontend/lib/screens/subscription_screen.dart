import 'package:flutter/material.dart';

class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [
          Text('Subscription', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          SizedBox(height: 12),
          Card(child: ListTile(title: Text('Free'), subtitle: Text('20 leads / month'))),
          Card(child: ListTile(title: Text('Pro'), subtitle: Text('Unlimited leads (placeholder)'))),
        ]),
      ),
    );
  }
}
