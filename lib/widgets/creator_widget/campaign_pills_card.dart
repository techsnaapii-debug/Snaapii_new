import 'package:flutter/material.dart';

class PillItem {
  final IconData? icon;
  final Widget? image;
  final String label;
  const PillItem({this.icon, this.image, required this.label});
}

class CampaignPillsCard extends StatelessWidget {
  final List<PillItem> items;

  const CampaignPillsCard({
    super.key,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFEDE8FF),
        borderRadius: BorderRadius.circular(14),
      ),
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: IntrinsicHeight(
        child: Row(
          children: List.generate(items.length * 2 - 1, (i) {
            if (i.isOdd) {
              return const VerticalDivider(
                color: Color(0xFFB8A8FF),
                thickness: 1,
                width: 1,
              );
            }
            final item = items[i ~/ 2];
            return Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  item.image != null
                      ? SizedBox(width: 22, height: 22, child: item.image)
                      : Icon(
                          item.icon,
                          size: 24,
                          color: const Color(0xFF6B4EFF),
                        ),
                  const SizedBox(height: 4),
                  Text(
                    item.label,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF2D007C),
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
