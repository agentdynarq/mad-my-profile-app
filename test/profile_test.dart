import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:profile_app/models/user_profile.dart';
import 'package:profile_app/screens/profile_screen.dart';
import 'package:profile_app/state/profile_controller.dart';

const UserProfile testProfile = UserProfile(
  name: 'RMS Hasitha Bandara',
  email: 'hasitha@dynarq.com',
);

void main() {
  group('ProfileController', () {
    test('award adds one point', () {
      final ProfileController controller = ProfileController(testProfile);
      expect(controller.award(), isTrue);
      expect(controller.value.points, 1);
    });

    test('award stops at the cap', () {
      final ProfileController controller = ProfileController(
        testProfile.copyWith(points: ProfileController.maxPoints),
      );
      expect(controller.award(), isFalse);
      expect(controller.value.points, ProfileController.maxPoints);
    });

    test('reset sends the counter back to zero', () {
      final ProfileController controller = ProfileController(
        testProfile.copyWith(points: 7),
      );
      controller.reset();
      expect(controller.value.points, 0);
    });
  });

  group('ProfileScreen', () {
    testWidgets('shows the profile details', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: ProfileScreen(profile: testProfile)),
      );

      expect(find.text('My Profile'), findsOneWidget);
      expect(find.text('RMS Hasitha Bandara'), findsOneWidget);
      expect(find.text('hasitha@dynarq.com'), findsOneWidget);
      expect(find.text('0'), findsOneWidget);
    });

    testWidgets('tapping the button raises the points', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: ProfileScreen(profile: testProfile)),
      );

      await tester.tap(find.byType(FloatingActionButton));
      await tester.pump();
      expect(find.text('1'), findsOneWidget);

      await tester.tap(find.byType(FloatingActionButton));
      await tester.pump();
      expect(find.text('2'), findsOneWidget);
    });

    testWidgets('refresh action clears the points', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: ProfileScreen(profile: testProfile)),
      );

      await tester.tap(find.byType(FloatingActionButton));
      await tester.pump();
      await tester.tap(find.byIcon(Icons.refresh));
      await tester.pump();

      expect(find.text('0'), findsOneWidget);
    });
  });
}
