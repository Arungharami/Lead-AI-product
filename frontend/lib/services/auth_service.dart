import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late final StreamSubscription<User?> _authSubscription;

  AuthService() {
    _authSubscription = _auth.authStateChanges().listen((_) => notifyListeners());
  }

  User? get user => _auth.currentUser;
  bool get signedIn => user != null;

  Future<void> login(String email, String pass) async {
    await _auth.signInWithEmailAndPassword(email: email, password: pass);
  }

  Future<void> signup(String email, String pass) async {
    await _auth.createUserWithEmailAndPassword(email: email, password: pass);
  }

  Future<void> logout() async {
    await _auth.signOut();
  }

  Future<String?> idToken({bool forceRefresh = false}) async {
    return _auth.currentUser?.getIdToken(forceRefresh);
  }

  @override
  void dispose() {
    _authSubscription.cancel();
    super.dispose();
  }
}
