import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/lead.dart';

class LeadService {
  final _db = FirebaseFirestore.instance;

  Future<void> saveLead({
    required String userId,
    required String name,
    required String phone,
    required String email,
    required String need,
  }) async {
    await _db.collection('leads').add({
      'name': name,
      'phone': phone,
      'email': email,
      'need': need,
      'status': 'new',
      'createdAt': DateTime.now().toUtc().toIso8601String(),
      'userId': userId,
    });
  }

  Stream<List<Lead>> watchLeads(String userId) {
    return _db
        .collection('leads')
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snap) => snap.docs.map((d) => Lead.fromMap(d.id, d.data())).toList());
  }
}
