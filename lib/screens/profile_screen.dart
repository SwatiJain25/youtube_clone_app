import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/profile_service.dart';
import '../providers/user_provider.dart';
import 'login_screen.dart'; // Assuming this is your login screen

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    // Load profile data when the screen initializes
    WidgetsBinding.instance!.addPostFrameCallback((_) {
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
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.black, Colors.grey[900]!],
              ),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 20),
                    CircleAvatar(
                      radius: 80,
                      backgroundImage: profile?.avatarUrl.isNotEmpty == true
                          ? NetworkImage(profile!.avatarUrl)
                          : AssetImage('assets/default_avatar.jpg') as ImageProvider,
                      backgroundColor: Colors.grey[300],
                    ),
                    SizedBox(height: 20),
                    Text(
                      profile?.name ?? 'Loading...',
                      style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        _logout(context); // Implement logout functionality
                      },
                      child: Text('Logout'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _logout(BuildContext context) {
    // Implement logout functionality
    // Example: Clear user session, navigate to login screen
    Provider.of<UserProvider>(context, listen: false).logout(); // Example logout method in UserProvider
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }
}
