import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:photo_app/components/nav_bar.dart';

void main() {
  testWidgets('Test AppBar Widget', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Scaffold(appBar: appBar())));

    expect(find.text('PhotoApp'), findsOneWidget);
  });


}
