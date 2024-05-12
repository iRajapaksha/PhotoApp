import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:photo_app/view/gallery_manager.dart';
import 'package:photo_app/view/home.dart';
import 'package:photo_app/view/top_suggestions.dart';

void main() {
  testWidgets('Home UI Test', (WidgetTester tester) async {
    // Build the Home widget
    await tester.pumpWidget(MaterialApp(home: Home()));

    expect(find.text('Top Suggestions'), findsOneWidget);
    expect(find.text('Gallery Manager'), findsOneWidget);
    expect(find.text('Gallery'), findsOneWidget);


  });
  testWidgets(
    "Test Gallery Manager Button",
    (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: Home()));
      await tester.tap(find.text('Top Suggestions'));
      await tester.pumpAndSettle();
      expect(find.byType(TopSuggestions), findsOneWidget);
    },
  );

  testWidgets(
    "Test Top Suggestions Button",
    (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: Home()));
    await tester.tap(find.text('Gallery Manager'));
    await tester.pumpAndSettle();
    expect(find.byType(GalleryManager), findsOneWidget);
    },
  );
}

void changeNotify() {}
