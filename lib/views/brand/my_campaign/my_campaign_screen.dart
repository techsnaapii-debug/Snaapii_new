import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../widgets/custom_button.dart';
import 'home_screen.dart';
import 'basic_details_screen.dart';
import '../ai/ai_screen.dart';
import '../chat/chat_screen.dart';
import '../profile/profile_screen_1.dart';
import '../../creator/explore_screen.dart';

class MyCampaignScreen extends StatefulWidget {
  const MyCampaignScreen({super.key});

  @override
  State<MyCampaignScreen> createState() => _MyCampaignScreenState();
}

class _MyCampaignScreenState extends State<MyCampaignScreen> {
  int _selectedTabIndex = 1;
  String _activeCampaignTab = 'Active';

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.transparent,
      ),
      child: Scaffold(
        backgroundColor: const Color(0xFF5600CA),
        resizeToAvoidBottomInset: false,
        body: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: SizedBox.expand(
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 37),

                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 8.0,
                        ),
                        child: Row(
                          children: [
                            const Text(
                              'My Campaign',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      Expanded(
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(30),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const SizedBox(height: 24),

                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0,
                                ),
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(30),
                                    border: Border.all(
                                      color: const Color(0xFFEBE8FC),
                                      width: 1.5,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      _buildSegmentTab('Active'),
                                      _buildSegmentTab('Pending'),
                                      _buildSegmentTab('Complete'),
                                      _buildSegmentTab('Draft'),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 200),

                              const Text(
                                'No Campaign Available',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF8E8E93),
                                ),
                              ),
                              const SizedBox(height: 220),

                              Center(
                                child: CustomButton(
                                  text: 'Create Campaign',
                                  width: 263.0,
                                  isGradient: true,
                                  onTap: () {
                                    Get.to(() => const BasicDetailsScreen());
                                  },
                                ),
                              ),
                              const SizedBox(height: 50),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  _buildBottomNavigationBar(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSegmentTab(String title) {
    final bool isSelected = _activeCampaignTab == title;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _activeCampaignTab = title;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF6B4EFF) : Colors.transparent,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              color: isSelected ? Colors.white : const Color(0xFFB18CFF),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Positioned(
      left: 16,
      right: 16,
      bottom: 24,
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color: const Color(0xFF9E8EFE),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF9E8EFE).withValues(alpha: 0.4),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () => Get.offAll(() => const HomeScreen()),
              child: _buildNavIcon(
                'assets/images/home_icon.png',
                isActive: _selectedTabIndex == 0,
                width: 20,
                height: 20,
              ),
            ),
            GestureDetector(
              onTap: () {
                if (HomeScreen.isCreatorRole) {
                  Get.to(() => const ExploreScreen());
                } else {
                  setState(() => _selectedTabIndex = 1);
                }
              },
              child: _buildNavIcon(
                HomeScreen.isCreatorRole
                    ? 'assets/images/explore_icon.png'
                    : 'assets/images/create_compaign_icon.png',
                isActive: _selectedTabIndex == 1,
                width: HomeScreen.isCreatorRole ? 22 : 26,
                height: 20,
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.to(() => const AiScreen());
              },
              child: _buildNavIcon(
                'assets/images/ai_icon.png',
                isActive: _selectedTabIndex == 2,
                width: 24,
                height: 20,
              ),
            ),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => Get.to(() => const ChatScreen()),
              child: _buildNavIcon(
                'assets/images/message_icon.png',
                isActive: _selectedTabIndex == 3,
                width: 21,
                height: 20,
              ),
            ),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => Get.to(() => const ProfileScreen1()),
              child: _buildNavIcon(
                'assets/images/person_icon.png',
                isActive: _selectedTabIndex == 4,
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
