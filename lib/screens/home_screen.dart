// screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/video_service.dart';
import '../widgets/video_tile.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Consumer<VideoService>(
        builder: (context, videoService, child) {
          if (videoService.isLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (videoService.videos.isEmpty) {
            return Center(child: Text('No videos available'));
          } else {
            return ListView.builder(
              itemCount: videoService.videos.length,
              itemBuilder: (context, index) {
                return VideoTile(video: videoService.videos[index]);
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/profile');
        },
        child: Icon(Icons.person),
      ),
    );
  }
}
