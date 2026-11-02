import 'package:flutter/material.dart';

class KycSheetTopClipper extends CustomClipper<Path> {
  const KycSheetTopClipper();

  @override
  Path getClip(Size size) {
    final path = Path();
    double curveHeight = 45.0;
    double centerWidth = 180.0;
    double leftX = (size.width - centerWidth) / 2;
    double rightX = (size.width + centerWidth) / 2;

    path.moveTo(0, curveHeight);
    path.lineTo(leftX - 15, curveHeight);

    path.cubicTo(leftX + 35, curveHeight, leftX + 35, 0, size.width / 2, 0);

    path.cubicTo(
      rightX - 35,
      0,
      rightX - 35,
      curveHeight,
      rightX + 15,
      curveHeight,
    );

    path.lineTo(size.width, curveHeight);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
