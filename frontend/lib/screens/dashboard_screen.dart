import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/lead.dart';
import '../services/api_service.dart';
import '../services/app_config.dart';
import '../services/auth_service.dart';
import 'chat_screen.dart';
import 'leads_screen.dart';
import 'subscription_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final api = ApiService(AppConfig.apiBaseUrl);
    final today = DateTime.now();

    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: FutureBuilder<List<Lead>>(
        future: context.read<AuthService>().idToken().then((token) {
          if (token == null) {
            throw Exception('Session expired. Please sign in again.');
          }
          return api.getLeads(token);
        }),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Could not load analytics: ${snapshot.error}', style: const TextStyle(color: Colors.redAccent)));
          }
          final leads = snapshot.data ?? [];
          final todaysLeads = leads.where((l) {
            final d = DateTime.tryParse(l.createdAt)?.toLocal();
            return d != null && d.year == today.year && d.month == today.month && d.day == today.day;
          }).length;

          Widget card(String t, String v) => Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(children: [Text(t), Text(v, style: const TextStyle(fontSize: 24))]),
                ),
              );

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(children: [
              Row(children: [
                Expanded(child: card('Total Leads', '${leads.length}')),
                const SizedBox(width: 12),
                Expanded(child: card("Today's Leads", '$todaysLeads')),
              ]),
              const SizedBox(height: 20),
              ElevatedButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ChatScreen())), child: const Text('Open AI Chat')),
              ElevatedButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LeadsScreen())), child: const Text('View Leads')),
              OutlinedButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SubscriptionScreen())), child: const Text('Subscription')),
            ]),
          );
        },
      ),
    );
  }
}
