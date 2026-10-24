import 'package:flutter/material.dart';

class CampaignInfoChip extends StatelessWidget {
  final IconData? icon;
  final Widget? image;
  final String prefixText;
  final String label;
  final FontWeight fontWeight;

  const CampaignInfoChip({
    super.key,
    this.icon,
    this.image,
    this.prefixText = '',
    required this.label,
    this.fontWeight = FontWeight.w600,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: const Color(0xFFEBE8FC),
            borderRadius: BorderRadius.circular(8),
          ),
          child: image != null
              ? SizedBox(width: 22, height: 22, child: image)
              : Icon(icon, size: 22, color: const Color(0xFF9E8EFE)),
        ),
        const SizedBox(width: 10),
        Text.rich(
          TextSpan(
            children: [
              if (prefixText.isNotEmpty)
                TextSpan(
                  text: prefixText,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14.5,
                    fontWeight: FontWeight.w400,
                    color: Colors.black87,
                  ),
                ),
              TextSpan(
                text: label,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 15,
                  fontWeight: fontWeight,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
