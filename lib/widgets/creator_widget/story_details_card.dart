import 'package:flutter/material.dart';

class StoryDetailsCard extends StatelessWidget {
  final String? automationName;
  final String? keyword;
  final String? storyImage;
  final VoidCallback? onTap;

  const StoryDetailsCard({
    super.key,
    this.automationName,
    this.keyword,
    this.storyImage,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final String displayAutomationName =
        (automationName != null && automationName!.isNotEmpty)
        ? automationName!
        : 'Shoe Collection';
    final String displayKeyword = (keyword != null && keyword!.isNotEmpty)
        ? keyword!
        : 'Any Keywords';
    final String displayStoryImage =
        (storyImage != null && storyImage!.isNotEmpty)
        ? storyImage!
        : 'assets/images/girl_image.png';

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E7EB), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              displayStoryImage,
              width: 62,
              height: 70,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      decoration: const BoxDecoration(
                        color: Color(0xFFEDE9FE),
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.add_circle_outline_rounded,
                          color: Color(0xFF7C3AED),
                          size: 15,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'Story Details',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14.5,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFEDE9FE),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 9,
                        vertical: 4.5,
                      ),
                      child: Text(
                        displayAutomationName,
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 10.5,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFEDE9FE),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 9,
                        vertical: 4.5,
                      ),
                      child: Text(
                        displayKeyword,
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 10.5,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
}
