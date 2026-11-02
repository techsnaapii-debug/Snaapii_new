import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreatorChatTopBar extends StatelessWidget {
  final String brandName;
  final String brandInitial;
  final Color brandBgColor;
  final String? avatarImage;

  const CreatorChatTopBar({
    super.key,
    required this.brandName,
    required this.brandInitial,
    required this.brandBgColor,
    this.avatarImage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Color(0xFFF3F4F6), width: 1.0),
        ),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            behavior: HitTestBehavior.opaque,
            child: const Padding(
              padding: EdgeInsets.all(4.0),
              child: Icon(
                Icons.arrow_back_ios_new,
                color: Color(0xFF8655FE),
                size: 20,
              ),
            ),
          ),
          const SizedBox(width: 8),
          if (avatarImage != null)
            Container(
              width: 38,
              height: 38,
              decoration: const BoxDecoration(shape: BoxShape.circle),
              child: ClipOval(
                child: Image.asset(
                  avatarImage!,
                  width: 38,
                  height: 38,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: const Color(0xFF8655FE),
                    alignment: Alignment.center,
                    child: Text(
                      brandName.isNotEmpty ? brandName[0] : 'U',
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            )
          else
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: brandBgColor,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Text(
                brandInitial,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 8.5,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  letterSpacing: 1.0,
                ),
              ),
            ),
          const SizedBox(width: 12),
          Text(
            brandName,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1E1A34),
            ),
          ),
        ],
      ),
    );
  }
}
