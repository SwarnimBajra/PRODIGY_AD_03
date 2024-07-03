import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stopwatch/main.dart';

void main() {
  testWidgets('Stopwatch app smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('00:00:00'), findsOneWidget);

    // Start the stopwatch
    await tester.tap(find.byIcon(Icons.play_arrow));
    await tester.pump();

    await tester.pump(const Duration(milliseconds: 100));

    expect(find.text('00:00:10'), findsOneWidget);

    // Pause the stopwatch
    await tester.tap(find.byIcon(Icons.pause));
    await tester.pump();

    // Record a lap
    await tester.tap(find.byIcon(Icons.flag));
    await tester.pump();

    expect(find.text('Lap 1'), findsOneWidget);
    expect(find.text('00:00:10'),
        findsNWidgets(2)); // One in the main display and one in the lap list

    // Reset the stopwatch
    await tester.tap(find.byIcon(Icons.stop));
    await tester.pump();

    expect(find.text('00:00:00'), findsOneWidget);

    expect(find.text('Lap 1'), findsNothing);
  });
}
