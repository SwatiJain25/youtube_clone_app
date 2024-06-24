import 'package:flutter/material.dart';
import 'package:supabase/supabase.dart';
import '../constants.dart';

class AuthService with ChangeNotifier {
  final SupabaseClient _client = SupabaseClient(SUPABASE_URL, SUPABASE_ANNON_KEY);
  User? _user;

  User? get user => _user;

  Future<void> signIn(String email, String password) async {
  try {
    final response = await _client.auth.signIn(email: email, password: password);
    if (response.error != null) {
      throw response.error!.message;
    }
    _user = response.user;
    notifyListeners();
  } catch (error) {
    print('Sign-in error: $error');
    throw error; // Rethrow the error to handle it in the UI
  }
}


  Future<void> signUp(String email, String password) async {
    try {
      final response = await _client.auth.signUp(email, password);
      if (response.error != null) {
        throw response.error!.message!;
      }
      _user = response.user;
      notifyListeners();
    } catch (error) {
      // Handle sign-up error
      print('Sign-up error: $error');
      rethrow; // Ensure the error is propagated for proper error handling
    }
  }

  Future<void> signOut() async {
    try {
      await _client.auth.signOut();
      _user = null;
      notifyListeners();
    } catch (error) {
      // Handle sign-out error
      print('Sign-out error: $error');
      rethrow; // Ensure the error is propagated for proper error handling
    }
  }

  Future<void> loadUser() async {
    try {
      _user = _client.auth.currentUser;
      notifyListeners();
    } catch (error) {
      // Handle loading user error
      print('Load user error: $error');
      rethrow; // Ensure the error is propagated for proper error handling
    }
  }
}
