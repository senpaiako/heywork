import 'package:flutter/material.dart';

class WavyBottomPainter extends CustomPainter {
  final Color color;

  WavyBottomPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;

    final path = Path()
      ..lineTo(0, size.height - 20) // Move to bottom left
      ..quadraticBezierTo(size.width / 2, size.height, size.width,
          size.height - 20) // Create a curve
      ..lineTo(size.width, 0) // Move to top right
      ..close(); // Close the path

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
