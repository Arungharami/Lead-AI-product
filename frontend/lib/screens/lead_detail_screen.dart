import 'package:flutter/material.dart';

import '../models/lead.dart';

class LeadDetailScreen extends StatelessWidget {
  final Lead lead;
  const LeadDetailScreen({super.key, required this.lead});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lead Detail')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Name: ${lead.name}'),
              Text('Phone: ${lead.phone}'),
              Text('Email: ${lead.email}'),
              Text('Need: ${lead.need}'),
              Text('Status: ${lead.status}'),
              Text('Created: ${lead.createdAt.toLocal()}'),
              Text('UserId: ${lead.userId}'),
            ]),
          ),
        ),
      ),
    );
  }
}
