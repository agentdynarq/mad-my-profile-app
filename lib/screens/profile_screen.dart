import 'package:flutter/material.dart';

import '../models/user_profile.dart';
import '../state/profile_controller.dart';
import '../widgets/profile_avatar.dart';
import '../widgets/profile_field.dart';

/// The single screen of the app: avatar, name, email and a points counter
/// that the floating action button increases.
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, required this.profile});

  final UserProfile profile;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late final ProfileController _controller = ProfileController(widget.profile);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onAwardPressed() {
    final bool added = _controller.award();
    if (added) return;

    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(
        const SnackBar(content: Text('Points are capped at 999')),
      );
  }

  void _onResetPressed() {
    _controller.reset();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            onPressed: _onResetPressed,
            icon: const Icon(Icons.refresh),
            tooltip: 'Reset points',
          ),
        ],
      ),
      body: SafeArea(
        child: ValueListenableBuilder<UserProfile>(
          valueListenable: _controller,
          builder: (BuildContext context, UserProfile profile, _) {
            return SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 96),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Center(
                    child: ProfileAvatar(
                      initial: profile.initial,
                      verified: profile.verified,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Divider(thickness: 1.4),
                  const SizedBox(height: 4),
                  ProfileField(label: 'Name', value: profile.name),
                  ProfileField(
                    label: 'Email',
                    value: profile.email,
                    icon: Icons.mail_outline,
                  ),
                  ProfileField(
                    label: 'Points',
                    value: '${profile.points}',
                    icon: Icons.star,
                  ),
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onAwardPressed,
        tooltip: 'Add a point',
        child: const Icon(Icons.add),
      ),
    );
  }
}
