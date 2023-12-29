import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:masteringlayoutwidtree53custompaint_interactivestarrating/main.dart';

void main() {
  testWidgets('Interactive Star Rating Test', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    // Custom finder that finds CustomPaint widgets with a specific painter
    final filledStarFinder = find.byWidgetPredicate(
      (widget) =>
          widget is CustomPaint &&
          widget.painter != null &&
          (widget.painter as StarPainted).isFilled,
    );

    // Verify no stars are filled initially
    expect(filledStarFinder, findsNothing);

    // Test tapping on the third star
    await tester.tap(find.byType(GestureDetector).at(2)); // Tap the third star
    await tester.pumpAndSettle();

    // Verify that the first three stars are now filled
    expect(filledStarFinder, findsNWidgets(3));

    // Test tapping on the fifth star
    await tester.tap(find.byType(GestureDetector).at(4)); // Tap the fifth star
    await tester.pumpAndSettle();

    // Verify that all five stars are now filled
    expect(filledStarFinder, findsNWidgets(5));

    // Test tapping on the first star
    await tester.tap(find.byType(GestureDetector).at(0)); // Tap the first star
    await tester.pumpAndSettle();

    // Verify that only the first star is now filled
    expect(filledStarFinder, findsOneWidget);
  });
}
