import 'dart:convert';

import 'package:http/http.dart' as http;
import '../models/lead.dart';

class ApiException implements Exception {
  final String message;
  final int? statusCode;

  ApiException(this.message, [this.statusCode]);

  @override
  String toString() => 'ApiException(${statusCode ?? 'unknown'}): $message';
}

class ApiService {
  final String baseUrl;
  ApiService(this.baseUrl);

  Future<Map<String, dynamic>> chat(String message, Map<String, dynamic> state) async {
    final res = await http.post(
      Uri.parse('$baseUrl/chat'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'message': message, 'state': state}),
    );

    if (res.statusCode >= 400) {
      throw ApiException('Chat failed: ${res.body}', res.statusCode);
    }

    final body = jsonDecode(res.body);
    if (body is! Map<String, dynamic>) {
      throw ApiException('Unexpected chat response format');
    }

    return body;
  }

  Future<void> saveLead(Map<String, dynamic> lead, String token) async {
    final res = await http.post(
      Uri.parse('$baseUrl/lead'),
      headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'},
      body: jsonEncode(lead),
    );

    if (res.statusCode == 401) {
      throw ApiException('Unauthorized access. Please sign in again.', res.statusCode);
    }
    if (res.statusCode >= 400) {
      throw ApiException('Save lead failed: ${res.body}', res.statusCode);
    }
  }

  Future<List<Lead>> getLeads(String token) async {
    final res = await http.get(
      Uri.parse('$baseUrl/leads'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (res.statusCode == 401) {
      throw ApiException('Unauthorized access. Please sign in again.', res.statusCode);
    }
    if (res.statusCode >= 400) {
      throw ApiException('Get leads failed: ${res.body}', res.statusCode);
    }

    final body = jsonDecode(res.body);
    if (body is! List) {
      throw ApiException('Unexpected leads response format');
    }

    return body.map((e) => Lead.fromJson(e as Map<String, dynamic>)).toList();
  }
}
