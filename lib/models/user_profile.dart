/// Immutable snapshot of the person shown on the profile screen.
class UserProfile {
  const UserProfile({
    required this.name,
    required this.email,
    this.points = 0,
    this.verified = true,
  });

  final String name;
  final String email;
  final int points;
  final bool verified;

  /// First letter of the name, used when no avatar picture is available.
  String get initial => name.isEmpty ? '?' : name.trim()[0].toUpperCase();

  UserProfile copyWith({String? name, String? email, int? points, bool? verified}) {
    return UserProfile(
      name: name ?? this.name,
      email: email ?? this.email,
      points: points ?? this.points,
      verified: verified ?? this.verified,
    );
  }

  @override
  bool operator ==(Object other) =>
      other is UserProfile &&
      other.name == name &&
      other.email == email &&
      other.points == points &&
      other.verified == verified;

  @override
  int get hashCode => Object.hash(name, email, points, verified);

  @override
  String toString() => 'UserProfile($name, $email, $points pts)';
}
