import 'package:flutter/material.dart';

class CreatorFooterBlock extends StatelessWidget {
  const CreatorFooterBlock({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: const Text(
              'Everything a Creator\nNeeds. 🚀',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 34,
                fontWeight: FontWeight.bold,
                color: Color(0xFFC5C5C5),
                height: 1.3,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text(
                'Protected with Official ',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  color: Color(0xFF666666),
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 13),
              Image.asset(
                'assets/images/meta.png',
                width: 30,
                height: 30,
                fit: BoxFit.contain,
              ),
              const SizedBox(width: 13),
              const Text(
                'Meta APIs',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  color: Color(0xFF666666),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const Text(
            'Security',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 16,
              color: Color(0xFF666666),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
