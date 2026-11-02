import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snaapii/views/brand/ai/ai_screen.dart';
import 'package:snaapii/views/creator/creator_chat_screen.dart';
import 'package:snaapii/views/creator/creator_home_screen.dart';
import 'package:snaapii/views/creator/creator_profile_screen.dart';
import 'package:snaapii/views/creator/explore_screen.dart';

class CreatorBottomNavBar extends StatelessWidget {
  final int selectedTabIndex;

  const CreatorBottomNavBar({
    super.key,
    required this.selectedTabIndex,
  });

  void _onTabSelected(int index) {
    if (index == selectedTabIndex) return;
    switch (index) {
      case 0:
        Get.offAll(() => const CreatorHomeScreen());
        break;
      case 1:
        Get.to(() => const ExploreScreen());
        break;
      case 2:
        Get.to(() => const AiScreen());
        break;
      case 3:
        Get.to(() => const CreatorChatScreen());
        break;
      case 4:
        Get.to(() => const CreatorProfileScreen());
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 16,
      right: 16,
      bottom: 24,
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color: const Color(0xFF9E8EFE),
          borderRadius: BorderRadius.circular(30),
          boxShadow: const [
            BoxShadow(
              color: Color(0x669E8EFE),
              blurRadius: 15,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () => _onTabSelected(0),
              behavior: HitTestBehavior.opaque,
              child: _buildNavIcon(
                'assets/images/home_icon.png',
                isActive: selectedTabIndex == 0,
                width: 20,
                height: 20,
              ),
            ),
            GestureDetector(
              onTap: () => _onTabSelected(1),
              behavior: HitTestBehavior.opaque,
              child: _buildNavIcon(
                'assets/images/explore_icon.png',
                isActive: selectedTabIndex == 1,
                width: 22,
                height: 20,
              ),
            ),
            GestureDetector(
              onTap: () => _onTabSelected(2),
              behavior: HitTestBehavior.opaque,
              child: _buildNavIcon(
                'assets/images/ai_icon.png',
                isActive: selectedTabIndex == 2,
                width: 24,
                height: 20,
              ),
            ),
            GestureDetector(
              onTap: () => _onTabSelected(3),
              behavior: HitTestBehavior.opaque,
              child: _buildNavIcon(
                'assets/images/message_icon.png',
                isActive: selectedTabIndex == 3,
                width: 21,
                height: 20,
              ),
            ),
            GestureDetector(
              onTap: () => _onTabSelected(4),
              behavior: HitTestBehavior.opaque,
              child: _buildNavIcon(
                'assets/images/person_icon.png',
                isActive: selectedTabIndex == 4,
                width: 20,
                height: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavIcon(
    dynamic icon, {
    bool isActive = false,
    double width = 24,
    double height = 24,
  }) {
    return Container(
      color: Colors.transparent,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedScale(
            scale: isActive ? 1.25 : 1.0,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOutBack,
            child: icon is IconData
                ? Icon(icon, color: Colors.white, size: height)
                : Image.asset(
                    icon,
                    width: width,
                    height: height,
                    color: Colors.white,
                    fit: BoxFit.contain,
                  ),
          ),
          if (isActive) ...[
            const SizedBox(height: 8),
            Container(
              width: 30,
              height: 2.5,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
