import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Timer timer;
  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD7D8DE),
      body: SafeArea(
        child: Center(
          child: SizedBox(
            height: 300,
            width: 300,
            child: Transform.rotate(
              angle: -pi / 2,
              child: CustomPaint(
                painter: ClockPainter(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ClockPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final center = Offset(centerX, centerY);
    final radius = min(centerX, centerY);
    final bigRadius = radius - 40;

    final fillBrush = Paint()..color = const Color(0xFF858D9A);

    final dateTime = DateTime.now();

    final outlineBrush = Paint()
      ..color = const Color(0xFFA5ABB0)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 65;

    final knobBrush = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final minBrush = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill
      ..strokeWidth = 5;

    final hourBrush = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill
      ..strokeWidth = 5;

    final secBrush = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill
      ..strokeWidth = 2;

    final dash1Brush = Paint()
      ..shader = const RadialGradient(colors: [Colors.lightBlue, Colors.pink])
          .createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.fill
      ..strokeWidth = 2;

    final dash2Brush = Paint()
      ..color = Colors.orange
      ..style = PaintingStyle.fill
      ..strokeWidth = 2;

    canvas.drawCircle(center, bigRadius, fillBrush);
    canvas.drawCircle(center, bigRadius, outlineBrush);

    var hourX = centerX + 120 * cos(dateTime.hour * 6 * pi / 180);
    var hourY = centerX + 120 * sin(dateTime.hour * 6 * pi / 180);
    canvas.drawLine(center, Offset(hourX, hourY), hourBrush);

    var minX = centerX + 100 * cos(dateTime.minute * 6 * pi / 180);
    var minY = centerX + 100 * sin(dateTime.minute * 6 * pi / 180);
    canvas.drawLine(center, Offset(minX, minY), minBrush);

    final circleRadius = radius - 65;
    for (double i = 0; i < 360; i += 30) {
      var x1 = centerX + radius * cos(i * pi / 180);
      var y1 = centerX + radius * sin(i * pi / 180);

      var x2 = centerX + circleRadius * cos(i * pi / 180);
      var y2 = centerX + circleRadius * sin(i * pi / 180);

      if (i / 2 % 2 == 1) {
        canvas.drawLine(Offset(x1, y1), Offset(x2, y2), dash1Brush);
      } else {
        canvas.drawLine(Offset(x1, y1), Offset(x2, y2), dash2Brush);
      }
    }

    var secX = centerX + 140 * cos(dateTime.second * 6 * pi / 180);
    var secY = centerX + 140 * sin(dateTime.second * 6 * pi / 180);
    canvas.drawLine(center, Offset(secX, secY), secBrush);

    //be the last so it can be on top
    canvas.drawCircle(center, 10, knobBrush);
  }

  @override
  bool shouldRepaint(ClockPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(ClockPainter oldDelegate) => false;
}
