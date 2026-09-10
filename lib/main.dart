import 'package:flutter/material.dart';

import 'models/user_profile.dart';
import 'screens/profile_screen.dart';

void main() {
  runApp(const ProfileApp());
}

/// Profile of the signed in student. Kept in one place so the screen stays
/// free of hard coded strings.
const UserProfile kCurrentUser = UserProfile(
  name: 'RMS Hasitha Bandara',
  email: 'hasitha@dynarq.com',
  points: 0,
);

class ProfileApp extends StatelessWidget {
  const ProfileApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Profile',
      debugShowCheckedModeBanner: true,
      theme: _buildTheme(Brightness.light),
      darkTheme: _buildTheme(Brightness.dark),
      home: const ProfileScreen(profile: kCurrentUser),
    );
  }

  ThemeData _buildTheme(Brightness brightness) {
    final ColorScheme scheme = ColorScheme.fromSeed(
      seedColor: const Color(0xFF1B1B1B),
      brightness: brightness,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      appBarTheme: AppBarTheme(
        centerTitle: true,
        elevation: 0,
        scrolledUnderElevation: 1,
        backgroundColor: scheme.surface,
        foregroundColor: scheme.onSurface,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: scheme.onSurface,
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: scheme.onSurface,
        foregroundColor: scheme.surface,
        shape: const CircleBorder(),
      ),
    );
  }
}
