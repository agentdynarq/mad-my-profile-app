import 'package:flutter/material.dart';

/// Round avatar with a thin ring and a verified badge sitting on the corner.
class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({
    super.key,
    required this.initial,
    this.radius = 62,
    this.verified = true,
  });

  final String initial;
  final double radius;
  final bool verified;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return SizedBox(
      width: radius * 2,
      height: radius * 2,
      child: Stack(
        children: <Widget>[
          Container(
            width: radius * 2,
            height: radius * 2,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: theme.colorScheme.surfaceContainerHighest,
              border: Border.all(color: theme.dividerColor, width: 2),
            ),
            alignment: Alignment.center,
            child: Text(
              initial,
              style: theme.textTheme.displaySmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: theme.colorScheme.onSurface,
              ),
            ),
          ),
          if (verified)
            Positioned(
              right: 4,
              bottom: 6,
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: theme.scaffoldBackgroundColor,
                ),
                child: const Icon(
                  Icons.check_circle,
                  size: 30,
                  color: Color(0xFF2ECC40),
                  semanticLabel: 'Verified account',
                ),
              ),
            ),
        ],
      ),
    );
  }
}
