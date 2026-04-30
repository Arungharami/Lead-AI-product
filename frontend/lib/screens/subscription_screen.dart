import 'package:flutter/material.dart';

class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Subscription')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(children: const [
          Card(child: ListTile(title: Text('Free Plan'), subtitle: Text('20 leads / month'))),
          Card(child: ListTile(title: Text('Pro Plan'), subtitle: Text('Unlimited leads (UI placeholder)'))),
        ]),
      ),
    );
  }
}
