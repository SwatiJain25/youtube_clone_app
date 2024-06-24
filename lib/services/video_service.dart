// services/video_service.dart
import 'package:flutter/material.dart';
import 'package:supabase/supabase.dart';
import '../constants.dart';

class Video {
  final String id;
  final String userId;
  final String title;
  final String description;
  final String videoUrl;
  final String thumbnailUrl;
  final DateTime createdAt;

  Video({
    required this.id,
    required this.userId,
    required this.title,
    required this.description,
    required this.videoUrl,
    required this.thumbnailUrl,
    required this.createdAt,
  });
}

class VideoService with ChangeNotifier {
  final SupabaseClient _client = SupabaseClient(SUPABASE_URL, SUPABASE_ANNON_KEY);
  List<Video> _videos = [];
  bool _isLoading = false;

  List<Video> get videos => _videos;
  bool get isLoading => _isLoading;

  VideoService() {
    loadVideos();
  }

  Future<void> loadVideos() async {
    _isLoading = true;
    notifyListeners();

    final response = await _client.from('videos').select().execute();
    final data = response.data as List;

    _videos = data.map((json) => Video(
      id: json['id'],
      userId: json['user_id'],
      title: json['title'],
      description: json['description'],
      videoUrl: json['video_url'],
      thumbnailUrl: json['thumbnail_url'],
      createdAt: DateTime.parse(json['created_at']),
    )).toList();

    _isLoading = false;
    notifyListeners();
  }

  Future<void> addVideo(Video video) async {
    await _client.from('videos').insert(video).execute();
    loadVideos();
  }
}
