import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/profile_service.dart'; // Adjust path based on your project structure
 // Adjust path based on your project structure
import '../providers/user_provider.dart'; // Add this import

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    // Load profile data when the screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userId = Provider.of<UserProvider>(context, listen: false).userId;
      if (userId != null) {
        Provider.of<ProfileService>(context, listen: false).loadProfile(userId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    ProfileService profileService = Provider.of<ProfileService>(context);
    Profile? profile = profileService.profile;

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: profile != null
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: profile.avatarUrl.isNotEmpty
                        ? NetworkImage(profile.avatarUrl)
                        : AssetImage('assets/default_avatar.jpg') as ImageProvider,
                    backgroundColor: Colors.transparent,
                  ),
                  SizedBox(height: 20),
                  Text(
                    profile.name,
                    style: TextStyle(fontSize: 24),
                  ),
                ],
              ),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
