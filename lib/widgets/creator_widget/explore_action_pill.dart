import 'package:flutter/material.dart';

class ExploreActionPill extends StatelessWidget {
  final int activeIndex;
  final bool isBookmarked;
  final bool isLiked;
  final VoidCallback onBookmarkTap;
  final VoidCallback onLikeTap;
  final VoidCallback onShareTap;

  const ExploreActionPill({
    super.key,
    required this.activeIndex,
    required this.isBookmarked,
    required this.isLiked,
    required this.onBookmarkTap,
    required this.onLikeTap,
    required this.onShareTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 230,
      height: 56,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: const Color(0xFFEBE8FC), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildPillItem(
            index: 0,
            icon: Icon(
              isBookmarked ? Icons.bookmark : Icons.bookmark_border,
              color: const Color(0xFF9E8EFE),
              size: 24,
            ),
            onTap: onBookmarkTap,
          ),
          _buildPillItem(
            index: 1,
            icon: Icon(
              isLiked ? Icons.favorite : Icons.favorite_border,
              color: const Color(0xFF9E8EFE),
              size: 22,
            ),
            onTap: onLikeTap,
          ),
          _buildPillItem(
            index: 2,
            icon: Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(3.14159),
              child: const Icon(
                Icons.reply_rounded,
                color: Color(0xFF9E8EFE),
                size: 24,
              ),
            ),
            onTap: onShareTap,
          ),
        ],
      ),
    );
  }

  Widget _buildPillItem({
    required int index,
    required Widget icon,
    required VoidCallback onTap,
  }) {
    final bool isActive = activeIndex == index;
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFFF0EAFF) : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Center(child: icon),
      ),
    );
  }
}
