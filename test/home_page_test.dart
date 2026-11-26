// Widget tests adapted from the Lab L1 starter.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:lab01_profile/main.dart' as app;

/// Starts the app like `flutter run` does and draws the first frame.
Future<void> startApp(WidgetTester tester) async {
  app.main();
  await tester.pump();
}

/// Finds the app bar title (it may read 'Lab L1' or 'Lab L1 done' after Step 7).
Finder appBarTitle() => find.descendant(
  of: find.byType(AppBar),
  matching: find.textContaining('Lab L1'),
);

void main() {
  // Normal: Launch the app -> Title, icon, name, "Likes: 0"
  testWidgets('Normal: launch shows title, icon, name and Likes: 0', (
    tester,
  ) async {
    await startApp(tester);

    expect(appBarTitle(), findsOneWidget);
    expect(find.byIcon(Icons.person), findsOneWidget);
    expect(find.textContaining(' - '), findsOneWidget); // '[Your name] - [ID]'
    expect(find.text('Likes: 0'), findsOneWidget);
    expect(find.widgetWithText(FilledButton, 'Like'), findsOneWidget);
  });

  // Normal: Tap Like once -> "Likes: 1"
  testWidgets('Normal: tapping Like once shows Likes: 1', (tester) async {
    await startApp(tester);

    await tester.tap(find.widgetWithText(FilledButton, 'Like'));
    await tester.pump();

    expect(find.text('Likes: 1'), findsOneWidget);
    expect(find.text('Likes: 0'), findsNothing);
  });

  // Boundary: Tap Like 20 times fast -> "Likes: 20", no error
  testWidgets('Boundary: 20 fast taps show Likes: 20 with no error', (
    tester,
  ) async {
    await startApp(tester);

    final like = find.widgetWithText(FilledButton, 'Like');
    for (var i = 0; i < 20; i++) {
      await tester.tap(like); // no pump in between: taps arrive "fast"
    }
    await tester.pump();

    expect(find.text('Likes: 20'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  // Boundary: Rotate to landscape -> Still centred, no overflow
  testWidgets('Boundary: landscape layout is centred with no overflow', (
    tester,
  ) async {
    // A phone in landscape: 800 x 360 logical pixels.
    tester.view.physicalSize = const Size(800, 360);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    await startApp(tester);

    // An overflow (yellow and black stripes) would be reported here.
    expect(tester.takeException(), isNull);

    final column = find
        .ancestor(of: find.byIcon(Icons.person), matching: find.byType(Column))
        .first;
    final rect = tester.getRect(column);
    expect(rect.center.dx, closeTo(400, 1)); // centred horizontally
    expect(rect.top, greaterThanOrEqualTo(0));
    expect(rect.bottom, lessThanOrEqualTo(360));
  });

  // Reload: 3 taps, then r -> still 3.
  // A host test cannot press r, so we rebuild the same widget tree, which is
  // what hot reload does: build() runs again but the State object is kept.
  testWidgets('Reload: after 3 taps a rebuild (like r) keeps Likes: 3', (
    tester,
  ) async {
    await startApp(tester);
    for (var i = 0; i < 3; i++) {
      await tester.tap(find.widgetWithText(FilledButton, 'Like'));
      await tester.pump();
    }
    expect(find.text('Likes: 3'), findsOneWidget);

    app.main(); // same widget tree again -> existing State is reused
    await tester.pump();

    expect(find.text('Likes: 3'), findsOneWidget);
  });

  // Reload: then R -> back to 0.
  // Hot restart throws the old widget tree (and its State) away and runs
  // main() again. We do the same: replace the tree, then start the app again.
  testWidgets('Reload: a restart (like R) resets Likes to 0', (tester) async {
    await startApp(tester);
    for (var i = 0; i < 3; i++) {
      await tester.tap(find.widgetWithText(FilledButton, 'Like'));
      await tester.pump();
    }
    expect(find.text('Likes: 3'), findsOneWidget);

    await tester.pumpWidget(const SizedBox()); // old State is disposed
    await startApp(tester); // main() runs again -> new State

    expect(find.text('Likes: 0'), findsOneWidget);
  });

  // Failure: Close emulator, flutter run -> "No device found" message.
  // This case is about the flutter tool, not the app, so it cannot be a
  // widget test. Run it by hand and write the exact message in answers.md.
}
