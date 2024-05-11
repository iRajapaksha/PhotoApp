import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:photo_app/view/top_suggestions.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';

void main() {
  testWidgets('TopSuggestions widget builds', (WidgetTester tester) async {
    // Build our widget and trigger a frame.
    await tester.pumpWidget(const MaterialApp(
      home: TopSuggestions(),
    ));

    // Wait for all animations and async operations to complete.
    await tester.pumpAndSettle();

    // Verify that the widget is built without exceptions.
    expect(find.byType(TopSuggestions), findsOneWidget);
  });

  testWidgets('TopSuggestions widget components test', (WidgetTester tester) async {
    // Build our widget and trigger a frame.
    await tester.pumpWidget(const MaterialApp(
      home: TopSuggestions(),
    ));

    // Wait for all animations and async operations to complete.
    await tester.pumpAndSettle();

    // Verify that the app bar exists.
    expect(find.text('PhotoApp'), findsOneWidget);

    // Verify that the end drawer exists.
    expect(find.byType(IconButton), findsOneWidget);

    // Verify that the heading exists.
    expect(find.text('Top Suggestions'), findsOneWidget);

    // Verify that the scroll snap list exists.
    expect(find.byType(ScrollSnapList), findsOneWidget);

    // Verify that the button exists.
    expect(find.text('Select'), findsOneWidget);

    // Verify that the image description exists.
    expect(find.textContaining('Taken On: '), findsOneWidget);
    expect(find.textContaining('File Info: '), findsOneWidget);
  });
}
