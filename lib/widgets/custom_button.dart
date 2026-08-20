import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final bool isGradient;
  final Color backgroundColor;
  final Color textColor;
  final Color borderColor;
  final List<Color> gradientColors;
  final double height;
  final double borderRadius;
  final double? width;
  final double fontSize;
  final IconData? icon;
  final String? imagePath;

  const CustomButton({
    super.key,
    required this.text,
    required this.onTap,
    this.isGradient = false,
    this.backgroundColor = Colors.white,
    this.textColor = const Color(0xFF5600CA),
    this.borderColor = const Color(0xFF9E8EFE),
    this.gradientColors = const [Color(0xFFB18CFF), Color(0xFF565EFA)],
    this.height = 49.0,
    this.borderRadius = 43.0,
    this.width,
    this.fontSize = 19.0,
    this.icon,
    this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    BoxDecoration decoration;
    if (isGradient) {
      decoration = BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        boxShadow: [
          BoxShadow(
            color: gradientColors.last.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      );
    } else {
      decoration = BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(color: borderColor, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: borderColor.withOpacity(0.15),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      );
    }

    return Container(
      width: width,
      height: height,
      decoration: decoration,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(borderRadius),
          onTap: onTap,
          child: Center(
            child: (imagePath != null || icon != null)
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (imagePath != null)
                        Image.asset(
                          imagePath!,
                          width: fontSize - 6,
                          height: fontSize - 6,
                          color: isGradient ? Colors.white : textColor,
                        )
                      else
                        Icon(
                          icon,
                          size: fontSize + 2,
                          color: isGradient ? Colors.white : textColor,
                        ),
                      const SizedBox(width: 8),
                      Text(
                        text,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: fontSize,
                          fontWeight: FontWeight.w600,
                          color: isGradient ? Colors.white : textColor,
                        ),
                      ),
                    ],
                  )
                : Text(
                    text,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: fontSize,
                      fontWeight: FontWeight.w600,
                      color: isGradient ? Colors.white : textColor,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
