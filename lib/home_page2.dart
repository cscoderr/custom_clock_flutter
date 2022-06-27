import 'dart:math';

import 'package:flutter/material.dart';

class HomePage2 extends StatelessWidget {
  const HomePage2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2D2F41),
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
    final bigCircleRadius = radius - 40;
    final smallCircleRadius = radius - 60;

    final mainFacePaint = Paint()..color = const Color(0xFF444971);
    final secondFacePaint = Paint()
      // ..shader = const RadialGradient(colors: [Colors.lightBlue, Colors.pink])
      //     .createShader(Rect.fromCircle(center: center, radius: radius))
      ..color = const Color(0xFFEAECFF)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 16;

    final knobPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, bigCircleRadius, mainFacePaint);
    canvas.drawCircle(center, bigCircleRadius, secondFacePaint);

    final center2 = Offset(centerX + 70, centerY + 10);

    final s360Paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    for (double i = 0; i < 360; i += 12) {
      final x1 = centerX + bigCircleRadius * cos(i * pi / 180);
      final y1 = centerX + bigCircleRadius * sin(i * pi / 180);

      final x2 = centerX + smallCircleRadius * cos(i * pi / 180);
      final y2 = centerX + smallCircleRadius * sin(i * pi / 180);
      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), s360Paint);
    }

    final minutePaint = Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    canvas.drawLine(center, center2, minutePaint);

    final hourPaint = Paint()
      ..color = Colors.orange
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    final center3 = Offset(centerX, centerY - 80);

    canvas.drawLine(center, center3, hourPaint);

    final secondsPaint = Paint()
      ..color = Colors.indigo
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final center4 = Offset(centerX - 80, centerY - 50);

    canvas.drawLine(center, center4, secondsPaint);

    canvas.drawCircle(center, 12, knobPaint);
  }

  @override
  bool shouldRepaint(ClockPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(ClockPainter oldDelegate) => false;
}
