import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/lead.dart';

class ApiService {
  final String baseUrl;
  ApiService(this.baseUrl);

  Future<Map<String, dynamic>> chat(String message, Map<String, dynamic> state) async {
    final res = await http.post(Uri.parse('$baseUrl/chat'), headers: {'Content-Type': 'application/json'}, body: jsonEncode({'message': message, 'state': state}));
    return jsonDecode(res.body);
  }

  Future<void> saveLead(Map<String, dynamic> lead, String token) async {
    await http.post(Uri.parse('$baseUrl/lead'), headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'}, body: jsonEncode(lead));
  }

  Future<List<Lead>> getLeads(String token) async {
    final res = await http.get(Uri.parse('$baseUrl/leads'), headers: {'Authorization': 'Bearer $token'});
    final arr = jsonDecode(res.body) as List;
    return arr.map((e) => Lead.fromJson(e)).toList();
  }
}
