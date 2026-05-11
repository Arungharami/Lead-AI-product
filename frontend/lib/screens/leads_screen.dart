import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/lead.dart';
import '../services/api_service.dart';
import '../services/auth_service.dart';
import '../services/app_config.dart';
import 'lead_detail_screen.dart';

class LeadsScreen extends StatefulWidget {
  const LeadsScreen({super.key});

  @override
  State<LeadsScreen> createState() => _LeadsScreenState();
}

class _LeadsScreenState extends State<LeadsScreen> {
  late Future<List<Lead>> _futureLeads;

  @override
  void initState() {
    super.initState();
    _futureLeads = _loadLeads();
  }

  Future<List<Lead>> _loadLeads() async {
    final api = ApiService(AppConfig.apiBaseUrl);
    final token = await context.read<AuthService>().idToken();
    if (token == null) {
      throw Exception('Session expired. Please sign in again.');
    }
    return api.getLeads(token);
  }

  void _reload() {
    setState(() {
      _futureLeads = _loadLeads();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Leads')),
      body: FutureBuilder<List<Lead>>(
        future: _futureLeads,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Could not load leads: ${snapshot.error}', textAlign: TextAlign.center),
                  const SizedBox(height: 16),
                  ElevatedButton(onPressed: _reload, child: const Text('Retry')),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () async {
                      await context.read<AuthService>().logout();
                      if (!context.mounted) return;
                      Navigator.pop(context);
                    },
                    child: const Text('Sign out'),
                  ),
                ],
              ),
            );
          }

          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final leads = snapshot.data!;
          if (leads.isEmpty) {
            return const Center(child: Text('No leads yet'));
          }

          return ListView.builder(
            itemCount: leads.length,
            itemBuilder: (_, i) {
              final lead = leads[i];
              return ListTile(
                title: Text(lead.name),
                subtitle: Text(lead.need),
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => LeadDetailScreen(lead: lead))),
              );
            },
          );
        },
      ),
    );
  }
}
