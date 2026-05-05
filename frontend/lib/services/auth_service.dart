import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? get user => _auth.currentUser;

  Future<void> login(String email, String pass) async {
    await _auth.signInWithEmailAndPassword(email: email, password: pass);
    notifyListeners();
  }

  Future<void> signup(String email, String pass) async {
    await _auth.createUserWithEmailAndPassword(email: email, password: pass);
    notifyListeners();
  }

  Future<String?> idToken() async {
    return _auth.currentUser?.getIdToken();
  }
}
