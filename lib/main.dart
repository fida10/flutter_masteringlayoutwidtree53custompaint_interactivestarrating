/*
Practice Question 2: Interactive Star Rating with CustomPaint

Task Description:
Develop a Flutter app that displays a row of stars for rating purposes, using CustomPaint. The stars should change color when tapped, indicating a rating selection. Implement a custom painter for the star shape and ensure it responds to user taps.
 */

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<bool> isFilledList = List.filled(5, false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: List.generate(5, (index) => starDrawn(index)),
          ),
        ),
      ),
    );
  }

  Widget starDrawn(int index) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: 100,
          width: 100,
          child: GestureDetector(
            onTap: () {
              setState(() {
                for (var i = 0; i < isFilledList.length; i++) {
                  isFilledList[i] = i <= index;
                }
              });
            },
            child: CustomPaint(
              painter: StarPainted(isFilled: isFilledList[index]),
            ),
          ),
        ),
      ),
    );
  }
}

class StarPainted extends CustomPainter {
  bool isFilled;

  StarPainted({this.isFilled = false});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    paint.color = Colors.yellow;
    paint.strokeWidth = 2;

    isFilled
        ? paint.style = PaintingStyle.fill
        : paint.style = PaintingStyle.stroke;

    final path = Path();
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
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
