import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:photo_app/view/gallery_manager.dart';

void main() {
  testWidgets('GalleryManager widget builds', (WidgetTester tester) async {
    // Build our widget and trigger a frame.
    await tester.pumpWidget(const MaterialApp(
      home: GalleryManager(),
    ));

    // Verify that the widget is built without exceptions.
    expect(find.byType(GalleryManager), findsOneWidget);
  });

  testWidgets('GalleryManager widget components test', (WidgetTester tester) async {
    // Build our widget and trigger a frame.
    await tester.pumpWidget(const MaterialApp(
      home: GalleryManager(),
    ));

    // Verify that the app bar exists.
    expect(find.text('PhotoApp'), findsOneWidget);

    // Verify that the end drawer exists.
    expect(find.byType(IconButton), findsOneWidget);

    // Verify that the heading exists.
    expect(find.text('Gallery Manager'), findsOneWidget);

    // Verify that the tab bar exists.
    expect(find.byType(TabBar), findsOneWidget);

    // Verify that the tab bar has two tabs.
    expect(find.text('Duplicate'), findsOneWidget);
    expect(find.text('Defected'), findsOneWidget);

    // Verify that the tab bar view exists.
    expect(find.byType(TabBarView), findsOneWidget);
  });
}
