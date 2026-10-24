import 'package:flutter/material.dart';

class VerticalDottedLine extends StatelessWidget {
  final int count;
  final double dotWidth;
  final double dotHeight;
  final Color color;

  const VerticalDottedLine({
    super.key,
    this.count = 4,
    this.dotWidth = 2.0,
    this.dotHeight = 3.0,
    this.color = const Color(0xFFD8C4FF),
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        count,
        (index) => Container(
          width: dotWidth,
          height: dotHeight,
          margin: const EdgeInsets.symmetric(vertical: 1.5),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(1),
          ),
        ),
      ),
    );
  }
}
