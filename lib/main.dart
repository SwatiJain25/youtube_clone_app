// main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/video_screen.dart';
import 'screens/profile_screen.dart';
import 'providers/user_provider.dart';
import 'services/profile_service.dart';
import 'services/video_service.dart';
import 'screens/signup_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => ProfileService()),
        ChangeNotifierProvider(create: (_) => VideoService()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'YouTube Clone',
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/home': (context) => HomeScreen(),
        '/video': (context) => VideoScreen(videoUrl: 'video_url'), // Ensure proper usage here
        '/profile': (context) => ProfileScreen(),
        '/signup': (context) => SignupScreen(),
      },
    );
  }
}
