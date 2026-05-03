import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/lead.dart';

class ApiService {
  final String baseUrl;
  ApiService(this.baseUrl);

  Future<Map<String, dynamic>> chat(String message) async {
    final res = await http.post(
      Uri.parse('$baseUrl/chat'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'message': message}),
    );
    if (res.statusCode >= 400) throw Exception('Chat failed: ${res.body}');
    return jsonDecode(res.body);
  }

  Future<Lead> saveLead(Map<String, dynamic> lead, String token) async {
    final res = await http.post(
      Uri.parse('$baseUrl/lead'),
      headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'},
      body: jsonEncode(lead),
    );
    if (res.statusCode >= 400) throw Exception('Save lead failed: ${res.body}');
    return Lead.fromJson(jsonDecode(res.body));
  }

  Future<List<Lead>> getLeads(String token) async {
    final res = await http.get(Uri.parse('$baseUrl/leads'), headers: {'Authorization': 'Bearer $token'});
    if (res.statusCode >= 400) throw Exception(res.body);
    return (jsonDecode(res.body) as List).map((e) => Lead.fromJson(e)).toList();
  }
}
