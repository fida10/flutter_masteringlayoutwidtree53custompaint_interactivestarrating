/*
Practice Question 2: Interactive Star Rating with CustomPaint

Task Description:
Develop a Flutter app that displays a row of stars for rating purposes, using CustomPaint. The stars should change color when tapped, indicating a rating selection. Implement a custom painter for the star shape and ensure it responds to user taps.
 */

// Importing the Flutter Material Design library
// This library includes a wealth of pre-defined UI components such as buttons, cards, and layout structures.
import 'package:flutter/material.dart';

// The main function is the entry point of the application.
// When you run a Dart program, it starts by executing the main function.
void main() {
  // runApp is a built-in Flutter function that takes the given Widget and makes it the root of the widget tree.
  // In this case, MyApp() is the root widget of the application.
  runApp(const MyApp());
}

// MyApp is a StatelessWidget, which is a widget that describes part of the user interface which can't change over time.
// StatelessWidget is immutable, meaning that you can't change its state once it's built.
class MyApp extends StatelessWidget {
  // This is a constructor for this class. 'Key' is an optional parameter that you can pass to your widgets.
  // Keys can be useful if you want to preserve the state of a widget when it moves around in the tree.
  const MyApp({super.key});

  // The build method describes the widgets that make up the user interface.
  // The framework calls this method when this widget is inserted into the tree and when the dependencies of this widget change.
  @override
  Widget build(BuildContext context) {
    // MaterialApp is a predefined class in flutter which works as the root of your application,
    // It provides many functionalities like theme, navigation, title, home, etc.
    return const MaterialApp(
      // HomePage is the default landing widget for the app.
      // It's the first screen users will see when they open the app.
      home: HomePage(),
    );
  }
}

// HomePage is a StatefulWidget, which is a widget that can change over time (it's mutable).
// StatefulWidget can be used when you want the UI to dynamically change in response to events (like user interaction or receiving data).
class HomePage extends StatefulWidget {
  // This is a constructor for this class. 'Key' is an optional parameter that you can pass to your widgets.
  // Keys can be useful if you want to preserve the state of a widget when it moves around in the tree.
  const HomePage({super.key});

  // createState is a factory method which creates the mutable state for this widget.
  // When you want to change the UI, you'll need to work with the widget's state.
  @override
  State<HomePage> createState() => _HomePageState();
}

// This class represents the state of the HomePage widget.
// It extends the generic State class with HomePage as the type.
class _HomePageState extends State<HomePage> {
  // This is a list of booleans that represents whether each star is filled or not.
  // It's initially filled with 5 false values, meaning all stars are unfilled.
  List<bool> isFilledList = List.filled(5, false);

  // This method builds the widget tree for this widget.
  // It's called when Flutter needs to render this widget on the screen.
  @override
  Widget build(BuildContext context) {
    // Scaffold is a layout structure where you can place other widgets.
    // It provides several slots for placing widgets like appBar, body, floatingActionButton, etc.
    return Scaffold(
      // SafeArea is a widget that adjusts its child widget based on the device's "safe" area.
      // For example, it pushes the child below the status bar on iOS and Android.
      body: SafeArea(
        // SizedBox is a widget that forces its child to have a specific width and/or height.
        // Here, it's used to give a specific height to the Row widget.
        child: SizedBox(
          height: 100,
          // Row is a widget that displays its children in a horizontal array.
          child: Row(
            // MainAxisAlignment.start positions the children at the start of the main axis.
            mainAxisAlignment: MainAxisAlignment.start,
            // List.generate creates a list of stars.
            // It generates a list of 5 widgets that are created by the function starDrawn.
            children: List.generate(5, (index) => starDrawn(index)),
          ),
        ),
      ),
    );
  }

  // This method returns a widget representing a star.
  // It takes an index as a parameter to identify the star.
  Widget starDrawn(int index) {
    // Expanded takes up the remaining space in the row.
    // It makes sure that the star widgets are evenly distributed across the row.
    return Expanded(
      // Padding inserts padding around its child.
      // Here, it's used to create space around each star.
      child: Padding(
        // EdgeInsets.all creates insets from offsets from the left, top, right, and bottom.
        // Here, it's used to create a padding of 8 logical pixels on all sides.
        padding: const EdgeInsets.all(8.0),
        // SizedBox is a box with a specified size.
        // Here, it's used to give a specific height and width to the GestureDetector widget.
        child: SizedBox(
          // The height and width of the box are 100 logical pixels.
          height: 100,
          width: 100,
          // GestureDetector is a non-visual widget which provides gesture recognition.
          // Here, it's used to recognize the tap gesture on the star.
          child: GestureDetector(
            // onTap specifies the callback that is called when the gesture recognized by this recognizer is accepted.
            // Here, it's used to change the state of the stars when a star is tapped.
            onTap: () {
              // setState notifies the framework that the internal state of this object has changed.
              // Here, it's used to fill or unfill the stars based on the tapped star.
              setState(() {
                // Loop through the list of stars and fill them up to the tapped index.
                for (var i = 0; i < isFilledList.length; i++) {
                  isFilledList[i] = i <= index;
                }
                /*
                This loop iterates over the isFilledList array, which represents the filled state of each star. The isFilledList array contains boolean values, where true means the star at that index is filled, and false means it's not filled.

                The loop starts at i = 0 and continues until i is less than the length of the isFilledList array. This ensures that every element in the isFilledList array is visited.

                For each iteration, the loop sets the value of isFilledList[i] to the result of the comparison i <= index. This comparison checks if the current index i is less than or equal to the index of the star that was tapped.

                If i is less than or equal to index, the comparison returns true, and the star at index i is marked as filled (isFilledList[i] = true). If i is greater than index, the comparison returns false, and the star at index i is marked as not filled (isFilledList[i] = false).

                So, in effect, this loop fills all the stars up to and including the star that was tapped, and empties all the stars after the tapped star.
                 */
              });
            },
            // CustomPaint is a widget that provides a canvas on which to draw during the paint phase.
            // Here, it's used to draw the star.
            child: CustomPaint(
              // StarPainted is the painter used to paint on the canvas.
              // It takes a boolean to determine whether the star should be filled or not.
              painter: StarPainted(isFilled: isFilledList[index]),
            ),
          ),
        ),
      ),
    );
  }
}

// This class is a custom painter that draws a star.
// It extends the CustomPainter class which provides a protocol to paint onto a canvas.
class StarPainted extends CustomPainter {
  // This boolean determines whether the star should be filled or not.
  bool isFilled;

  // This is the constructor for the StarPainted class.
  // It initializes isFilled to false if it's not provided during object creation.
  StarPainted({this.isFilled = false});

  // This method is called whenever the custom painter is ready to paint.
  // It provides a canvas to draw onto and the size of the area to be painted.
  @override
  void paint(Canvas canvas, Size size) {
    // This creates a new instance of the Paint class.
    // Paint class holds the style and color information about how to draw geometries, text and images onto a canvas.
    final paint = Paint();
    // This sets the color of the paint to yellow.
    paint.color = Colors.yellow;
    // This sets the width of the stroke to be 2 logical pixels.
    paint.strokeWidth = 2;

    // This ternary operation checks if isFilled is true or false.
    // If it's true, it sets the paint style to fill (draws a filled star), otherwise it sets it to stroke (draws a star frame).
    isFilled
        ? paint.style = PaintingStyle.fill
        : paint.style = PaintingStyle.stroke;

    // This creates a new instance of the Path class.
    // Path class is used to create a path for drawing.
    final path = Path();
    // These lines add lines to the path to form a star.
    path.moveTo(size.width * 0.5, size.height * 0.2);
    path.lineTo(size.width * 0.63, size.height * 0.38);
    path.lineTo(size.width * 0.85, size.height * 0.38);
    path.lineTo(size.width * 0.70, size.height * 0.52);
    path.lineTo(size.width * 0.78, size.height * 0.75);
    path.lineTo(size.width * 0.5, size.height * 0.6);
    path.lineTo(size.width * 0.22, size.height * 0.75);
    path.lineTo(size.width * 0.30, size.height * 0.52);
    path.lineTo(size.width * 0.15, size.height * 0.38);
    path.lineTo(size.width * 0.37, size.height * 0.38);
    // This closes the path to form a complete star.
    path.close();

    // This draws the path onto the canvas using the paint.
    canvas.drawPath(path, paint);
  }

  // This method is called when the custom painter is rebuilt.
  // It returns true to indicate that the painting should be repainted.
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}