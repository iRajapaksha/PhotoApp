import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:photo_app/view/welcome_view.dart';

void main() {
  testWidgets('WelcomeView UI Test', (WidgetTester tester) async {
    // Build the WelcomeView widget
    await tester.pumpWidget(const MaterialApp(
      home: WelcomeView(),
    ));

    expect(find.text('PhotoApp'), findsOneWidget);

    expect(find.text('Get Started'), findsOneWidget);
  });


  testWidgets('WelcomeView SharedPreferences Test', (WidgetTester tester) async {
    // Build the WelcomeView widget
    await tester.pumpWidget(const MaterialApp(
      home: WelcomeView(),
    ));

    // Tap the 'Get Started' button
    await tester.tap(find.text('Get Started'));
    await tester.pumpAndSettle();

  });
}
