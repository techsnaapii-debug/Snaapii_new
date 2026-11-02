import 'package:flutter/material.dart';

class KycSuccessView extends StatelessWidget {
  const KycSuccessView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 140),
        Container(
          width: 240,
          height: 240,
          decoration: const BoxDecoration(
            color: Color(0xFFEFF9F2),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Container(
              width: 180,
              height: 180,
              decoration: const BoxDecoration(
                color: Color(0xFFC7F0D3),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Container(
                  width: 130,
                  height: 130,
                  decoration: const BoxDecoration(
                    color: Color(0xFF28C752),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check_rounded,
                    size: 76,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 40),
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Text('🎉 ', style: TextStyle(fontSize: 22)),
            Text(
              'KYC Verified Successfully',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF28C752),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        const Text(
          'You can now withdraw your earning.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Color(0xFF666666),
          ),
        ),
      ],
    );
  }
}
