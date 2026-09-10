import 'package:flutter/foundation.dart';

import '../models/user_profile.dart';

/// Holds the profile in memory and notifies listeners when the points change.
///
/// A [ValueNotifier] keeps the screen free of setState calls and makes the
/// award rules easy to test without pumping any widgets.
class ProfileController extends ValueNotifier<UserProfile> {
  ProfileController(super.profile);

  /// Points handed out per tap of the floating action button.
  static const int pointsPerAward = 1;

  /// Upper bound so a long press session cannot run the counter away.
  static const int maxPoints = 999;

  bool get canAward => value.points < maxPoints;

  /// Adds one point. Returns false when the cap has already been reached.
  bool award() {
    if (!canAward) return false;
    value = value.copyWith(points: value.points + pointsPerAward);
    return true;
  }

  /// Sends the counter back to zero.
  void reset() {
    if (value.points == 0) return;
    value = value.copyWith(points: 0);
  }
}
