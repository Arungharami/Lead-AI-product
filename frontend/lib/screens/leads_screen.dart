import 'package:flutter/material.dart';
import '../models/lead.dart';
import '../services/api_service.dart';
import '../services/app_config.dart';
import 'lead_detail_screen.dart';

class LeadsScreen extends StatelessWidget {
  const LeadsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final api = ApiService(AppConfig.apiBaseUrl);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Leads', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Expanded(
            child: FutureBuilder<List<Lead>>(
              future: api.getLeads(AppConfig.demoToken),
              builder: (context, s) {
                if (s.connectionState != ConnectionState.done) return const Center(child: CircularProgressIndicator());
                if (s.hasError) return Center(child: Text('Failed: ${s.error}'));
                final leads = s.data ?? [];
                if (leads.isEmpty) return const Center(child: Text('No leads yet'));
                return ListView.separated(
                  itemCount: leads.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 8),
                  itemBuilder: (_, i) => Card(
                    child: ListTile(
                      title: Text(leads[i].name),
                      subtitle: Text(leads[i].need),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => LeadDetailScreen(lead: leads[i]))),
                    ),
                  ),
                );
              },
            ),
          ),
        ]),
      ),
    );
  }
}
