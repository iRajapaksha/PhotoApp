import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:photo_app/models/photo.dart';
import 'package:photo_app/view/caption_selection.dart';

void main() {
  testWidgets('TopSuggestionSelected widget builds',
      (WidgetTester tester) async {
    // Build our widget
    await tester.pumpWidget(MaterialApp(
      home: TopSuggestionSelected(
        selectedPhoto: Photo(
          info: "info1",
          dateTime: DateTime.now(),
          fileName: 'fileName1',
          filePath: 'assets/images/1.png',
        ),
      ),
    ));

    // Verify that the widget is built without exceptions.
    expect(find.byType(TopSuggestionSelected), findsOneWidget);
  });

  testWidgets('TopSuggestionSelected widget components test',
      (WidgetTester tester) async {
    // Build our widget
    await tester.pumpWidget(MaterialApp(
      home: TopSuggestionSelected(
        selectedPhoto: Photo(
          info: "info2",
          dateTime: DateTime.now(),
          fileName: 'fileName2',
          filePath: 'assets/images/2.png',
        ),
      ),
    ));

    // Verify that the app bar exists.
    expect(find.text('PhotoApp'), findsOneWidget);

    // Verify that the end drawer exists.
    expect(find.byType(IconButton), findsOneWidget);

    // Verify that the editing container exists.
    expect(
        find.byType(Container),
        findsNWidgets(
            2)); // One for editing container and one for the scroll snap list

    // Verify that the scroll snap list exists.
    expect(find.byType(SizedBox), findsOneWidget);

  });

}
