import 'package:flutter/material.dart';
import '../models/lead.dart';

class LeadDetailScreen extends StatelessWidget {
  final Lead lead;
  const LeadDetailScreen({super.key, required this.lead});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(lead.name)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Phone: ${lead.phone}'),
          Text('Email: ${lead.email}'),
          Text('Need: ${lead.need}'),
          Text('Captured: ${lead.createdAt}'),
        ]),
      ),
    );
  }
}
