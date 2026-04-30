import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Widget metric(String title, String value) => Expanded(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(title, style: const TextStyle(color: Colors.white70)),
                const SizedBox(height: 8),
                Text(value, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              ]),
            ),
          ),
        );

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Dashboard', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Row(children: [metric('Total Leads', '--'), const SizedBox(width: 12), metric("Today's Leads", '--')]),
          const SizedBox(height: 16),
          const Card(child: ListTile(title: Text('Lead Funnel'), subtitle: Text('Simple analytics placeholder'))),
        ]),
      ),
    );
  }
}
