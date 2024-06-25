import 'package:flutter/material.dart';
import '../services/video_service.dart';
import '../screens/video_screen.dart';

class VideoTile extends StatelessWidget {
  final Video video;

  VideoTile({required this.video});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => VideoScreen(videoUrl: video.videoUrl)),
        );
      },
      child: Card(
        color: Colors.grey[800], // Background color for the card
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Container(
          padding: EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 120,
                height: 90,
                color: Colors.white,
                child: Image.network(video.thumbnailUrl, fit: BoxFit.cover),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      video.title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // Title text color
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      video.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.white), // Description text color
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Uploaded on ${video.createdAt.toLocal().toString().split(' ')[0]}',
                      style: TextStyle(color: Colors.white), // Uploaded date text color
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
