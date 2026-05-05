import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/lead.dart';
import '../services/api_service.dart';
import '../services/auth_service.dart';
import '../services/app_config.dart';
import 'lead_detail_screen.dart';

class LeadsScreen extends StatelessWidget {
  const LeadsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final api = ApiService(AppConfig.apiBaseUrl);
    return Scaffold(
      appBar: AppBar(title: const Text('Leads')),
      body: FutureBuilder<List<Lead>>(
        future: context.read<AuthService>().idToken().then((token) {
          if (token == null) {
            throw Exception('Session expired. Please sign in again.');
          }
          return api.getLeads(token);
        }),
        builder: (context, snapshot) {
          if (snapshot.hasError) return Center(child: Text('Could not load leads: ${snapshot.error}'));
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          final leads = snapshot.data!;
          if (leads.isEmpty) return const Center(child: Text('No leads yet'));
          return ListView.builder(itemCount: leads.length, itemBuilder: (_, i) {
            final lead = leads[i];
            return ListTile(
              title: Text(lead.name),
              subtitle: Text(lead.need),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => LeadDetailScreen(lead: lead))),
            );
          });
        },
      ),
    );
  }
}
