import 'package:supabase/supabase.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
class Profile {
  final String id;
  final String name;
  final String avatarUrl;

  Profile({
    required this.id,
    required this.name,
    required this.avatarUrl,
  });
}

class ProfileService with ChangeNotifier {
  final SupabaseClient _client = SupabaseClient(SUPABASE_URL, SUPABASE_ANNON_KEY);
  Profile? _profile;

  Profile? get profile => _profile;

  Future<void> loadProfile(String userId) async {
    final response = await _client.from('profiles').select().eq('id', userId).single().execute();
    final data = response.data;

    if (data != null) {
      _profile = Profile(
        id: data['id'],
        name: data['name'],
        avatarUrl: data['avatar_url'],
      );
      notifyListeners();
    }
  }
}
