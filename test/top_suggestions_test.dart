import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:photo_app/view/top_suggestions.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';

void main() {
  testWidgets('TopSuggestions widget builds', (WidgetTester tester) async {
    // Build our widget 
    await tester.pumpWidget(const MaterialApp(
      home: TopSuggestions(),
    ));

    await tester.pumpAndSettle();

    expect(find.byType(TopSuggestions), findsOneWidget);
  });

  testWidgets('TopSuggestions widget components test', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: TopSuggestions(),
    ));

    await tester.pumpAndSettle();

    expect(find.text('PhotoApp'), findsOneWidget);

    expect(find.byType(IconButton), findsOneWidget);

    expect(find.text('Top Suggestions'), findsOneWidget);

    expect(find.byType(ScrollSnapList), findsOneWidget);

    expect(find.text('Select'), findsOneWidget);

    expect(find.textContaining('Taken On: '), findsOneWidget);
    expect(find.textContaining('File Info: '), findsOneWidget);
  });
}
