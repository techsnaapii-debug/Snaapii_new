import 'package:flutter/material.dart';

class PerformanceMetricCard extends StatelessWidget {
  final Color bgColor;
  final Color borderColor;
  final Color iconBgColor;
  final Color iconColor;
  final IconData? icon;
  final String? imagePath;
  final String label;
  final String value;

  const PerformanceMetricCard({
    super.key,
    required this.bgColor,
    required this.borderColor,
    required this.iconBgColor,
    required this.iconColor,
    this.icon,
    this.imagePath,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor, width: 1.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: iconBgColor,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: imagePath != null
                  ? Image.asset(
                      imagePath!,
                      width: 16,
                      height: 16,
                      color: iconColor,
                    )
                  : Icon(icon, color: iconColor, size: 17),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            label,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 12.5,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
