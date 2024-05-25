import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:photo_app/view/gallery_manager.dart';

void main() {
  testWidgets('GalleryManager widget builds', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: GalleryManager(assetPaths: [],),
    ));

    expect(find.byType(GalleryManager), findsOneWidget);
  });

  testWidgets('GalleryManager widget components test', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: GalleryManager(assetPaths: [],),
    ));

    expect(find.text('PhotoApp'), findsOneWidget);

    expect(find.byType(IconButton), findsOneWidget);

    expect(find.text('Gallery Manager'), findsOneWidget);

    expect(find.byType(TabBar), findsOneWidget);

    expect(find.text('Duplicate'), findsOneWidget);
    expect(find.text('Defected'), findsOneWidget);

    expect(find.byType(TabBarView), findsOneWidget);
  });
}
