import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:masteringlayoutwidtree53custompaint_interactivestarrating/main.dart';

// This is the main function where the test starts.
void main() {
  // testWidgets is a function provided by the flutter_test package.
  // It creates a new test case with a 'description' and a 'callback' function.
  testWidgets('Interactive Star Rating Test', (WidgetTester tester) async {
    // pumpWidget makes the tester pump a widget tree into the Flutter widget tree.
    // MyApp() is the root widget of the application.
    await tester.pumpWidget(MyApp());

    // This is a custom finder that finds CustomPaint widgets with a specific painter.
    // find is an object provided by the flutter_test package that provides common finder methods.
    final filledStarFinder = find.byWidgetPredicate(
      // byWidgetPredicate is a method that finds widgets by a specific predicate.
      // Here, the predicate is a function that returns true if the widget is a CustomPaint,
      // its painter is not null, and the painter's isFilled property is true.
      (widget) =>
          widget is CustomPaint &&
          widget.painter != null &&
          (widget.painter as StarPainted).isFilled,
    );

    // expect is a function provided by the flutter_test package that asserts if the actual value matches the expected value.
    // findsNothing is a matcher provided by the flutter_test package that matches if no widgets are found.
    // Here, it's used to verify that no stars are filled initially.
    expect(filledStarFinder, findsNothing);

    // tester.tap simulates a tap on a widget.
    // find.byType finds widgets by type.
    // GestureDetector is the type of the widget.
    // at(2) specifies that the third widget of this type should be found.
    await tester.tap(find.byType(GestureDetector).at(2));
    // pumpAndSettle simulates a frame-by-frame rendering of the widget tree.
    await tester.pumpAndSettle();

    // findsNWidgets is a matcher that matches if a specific number of widgets are found.
    // Here, it's used to verify that the first three stars are now filled.
    expect(filledStarFinder, findsNWidgets(3));

    // This simulates a tap on the fifth star.
    await tester.tap(find.byType(GestureDetector).at(4));
    await tester.pumpAndSettle();

    // This verifies that all five stars are now filled.
    expect(filledStarFinder, findsNWidgets(5));

    // This simulates a tap on the first star.
    await tester.tap(find.byType(GestureDetector).at(0));
    await tester.pumpAndSettle();

    // findsOneWidget is a matcher that matches if exactly one widget is found.
    // Here, it's used to verify that only the first star is now filled.
    expect(filledStarFinder, findsOneWidget);
  });
}
