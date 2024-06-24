// providers/user_provider.dart
import 'package:flutter/material.dart';
import 'package:supabase/supabase.dart';
import '../constants.dart';

class UserProvider with ChangeNotifier {
  final SupabaseClient _client = SupabaseClient(SUPABASE_URL, SUPABASE_ANNON_KEY);
  String? _userId;

  String? get userId => _userId;

  Future<void> login(String email, String password) async {
    final response = await _client.auth.signIn(email: email, password: password);
    if (response.error == null) {
      _userId = response.user?.id;
      notifyListeners();
    } else {
      throw response.error!;
    }
  }

  Future<void> signup(String email, String password, String name) async {
    final response = await _client.auth.signUp(email, password);
    if (response.error == null) {
      _userId = response.user?.id;
      await _client.from('profiles').insert({
        'id': _userId,
        'name': name,
        'avatar_url': '', // You can add a default avatar URL here
      }).execute();
      notifyListeners();
    } else {
      throw response.error!;
    }
  }
}
