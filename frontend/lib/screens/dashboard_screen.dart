import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/lead.dart';
import '../services/auth_service.dart';
import '../services/lead_service.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userId = context.watch<AuthService>().user?.uid;
    final leadService = LeadService();

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

    if (userId == null) return const Center(child: Text('Please login'));

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Dashboard', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Expanded(
            child: StreamBuilder<List<Lead>>(
              stream: leadService.watchLeads(userId),
              builder: (context, s) {
                if (s.connectionState != ConnectionState.active) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (s.hasError) return Center(child: Text('Failed: ${s.error}'));

                final leads = s.data ?? [];
                final now = DateTime.now();
                final todayCount = leads.where((l) {
                  final d = l.createdAt.toLocal();
                  return d.year == now.year && d.month == now.month && d.day == now.day;
                }).length;

                final newCount = leads.where((l) => l.status == 'new').length;
                final contactedCount = leads.where((l) => l.status == 'contacted').length;
                final convertedCount = leads.where((l) => l.status == 'converted').length;

                return Column(
                  children: [
                    Row(
                      children: [
                        metric('Total Leads', '${leads.length}'),
                        const SizedBox(width: 12),
                        metric("Today's Leads", '$todayCount'),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        metric('New Leads', '$newCount'),
                        const SizedBox(width: 12),
                        metric('Contacted', '$contactedCount'),
                        const SizedBox(width: 12),
                        metric('Converted', '$convertedCount'),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Card(
                      child: ListTile(
                        title: const Text('Lead Funnel'),
                        subtitle: Text('New: $newCount • Contacted: $contactedCount • Converted: $convertedCount'),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ]),
      ),
    );
  }
}
