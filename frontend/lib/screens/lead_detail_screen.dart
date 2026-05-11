import 'package:flutter/material.dart';

import '../models/lead.dart';
import '../services/lead_service.dart';

class LeadDetailScreen extends StatefulWidget {
  final Lead lead;
  const LeadDetailScreen({super.key, required this.lead});

  @override
  State<LeadDetailScreen> createState() => _LeadDetailScreenState();
}

class _LeadDetailScreenState extends State<LeadDetailScreen> {
  final _leadService = LeadService();
  bool _saving = false;

  String? _nextStatus(String current) {
    if (current == 'new') return 'contacted';
    if (current == 'contacted') return 'converted';
    return null;
  }

  Future<void> _updateStatus() async {
    final next = _nextStatus(widget.lead.status);
    if (next == null) return;

    setState(() => _saving = true);
    try {
      await _leadService.updateLeadStatus(leadId: widget.lead.id, status: next);
      if (!mounted) return;
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Status updated to $next')));
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to update status: $e')));
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final next = _nextStatus(widget.lead.status);

    return Scaffold(
      appBar: AppBar(title: const Text('Lead Detail')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Name: ${widget.lead.name}'),
              Text('Phone: ${widget.lead.phone}'),
              Text('Email: ${widget.lead.email}'),
              Text('Need: ${widget.lead.need}'),
              Text('Status: ${widget.lead.status}'),
              Text('Created: ${widget.lead.createdAt.toLocal()}'),
              Text('UserId: ${widget.lead.userId}'),
              const SizedBox(height: 20),
              if (next != null)
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _saving ? null : _updateStatus,
                    child: _saving ? const CircularProgressIndicator() : Text('Move to ${next[0].toUpperCase()}${next.substring(1)}'),
                  ),
                )
              else
                const Text('Lead is already converted.'),
            ]),
          ),
        ),
      ),
    );
  }
}
