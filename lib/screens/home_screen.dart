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
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              Navigator.pushNamed(context, '/profile');
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.black, Colors.grey[900]!],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 16.0), // Adjust the top padding as needed
          child: Consumer<VideoService>(
            builder: (context, videoService, child) {
              if (videoService.isLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (videoService.videos.isEmpty) {
                return Center(child: Text('No videos available', style: TextStyle(color: Colors.white)));
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
        ),
      ),
    );
  }
}
