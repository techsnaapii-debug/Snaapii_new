import 'package:flutter/material.dart';

class AutomationActiveCard extends StatelessWidget {
  final bool isPaused;

  const AutomationActiveCard({
    super.key,
    this.isPaused = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: isPaused ? const Color(0xFFF9FAFB) : const Color(0xFFECFDF5),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isPaused ? const Color(0xFFE5E7EB) : const Color(0xFFA7F3D0),
          width: 1.2,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: isPaused
                  ? const Color(0xFF6B7280)
                  : const Color(0xFF047857),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isPaused ? Icons.pause : Icons.check,
              color: Colors.white,
              size: 20,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isPaused ? 'Automation Paused' : 'Automation Active',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: isPaused
                        ? const Color(0xFF374151)
                        : const Color(0xFF047857),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  isPaused
                      ? 'Your DM automation is currently paused.'
                      : 'Your DM automation is live and responding automatically.',
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12,
                    color: Color(0xFF374151),
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
