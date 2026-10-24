import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../ai/ai_screen.dart';
import '../my_campaign/home_screen.dart';
import '../my_campaign/my_campaign_screen.dart';
import '../profile/profile_screen_1.dart';

class ChatScreen3 extends StatefulWidget {
  const ChatScreen3({super.key});

  @override
  State<ChatScreen3> createState() => _ChatScreen3State();
}

class _ChatScreen3State extends State<ChatScreen3> {
  int _selectedFilterIndex = 2;
  int _selectedTabIndex = 3;

  final List<Map<String, dynamic>> _completedCampaigns = [
    {
      'title': 'Campaign Complete',
      'subtitle': 'Your Campaign has been successfully Compe...',
      'time': '10:00 PM',
      'unread': 1,
      'brand': 'GUCCI',
      'color': const Color(0xFF4A0010),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: Colors.transparent,
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        body: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: SizedBox.expand(
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 37),

                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 8.0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              'Chat',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF6B4EFF),
                              ),
                            ),
                            Container(
                              width: 26,
                              height: 26,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.black,
                                  width: 2,
                                ),
                              ),
                              child: const Center(
                                child: Padding(
                                  padding: EdgeInsets.only(left: 2),
                                  child: Icon(
                                    Icons.play_arrow_rounded,
                                    size: 16,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),

                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          children: [
                            _buildFilterChip('Active', 0),
                            const SizedBox(width: 8),
                            _buildFilterChip('Unread', 1),
                            const SizedBox(width: 8),
                            _buildFilterChip('Complete', 2),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      Expanded(
                        child: ListView.separated(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          itemCount: _completedCampaigns.length,
                          separatorBuilder: (context, index) => const Divider(
                            color: Color(0xFFE9DDFE),
                            height: 1,
                            thickness: 1,
                          ),
                          itemBuilder: (context, index) {
                            final item = _completedCampaigns[index];
                            return _buildCompletedCampaignItem(
                              title: item['title'],
                              subtitle: item['subtitle'],
                              time: item['time'],
                              unreadCount: item['unread'],
                              brandText: item['brand'],
                              brandBgColor: item['color'],
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 100),
                    ],
                  ),

                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    height: 90,
                    child: Container(color: Colors.white),
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

  Widget _buildFilterChip(String label, int index) {
    final bool isSelected = _selectedFilterIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedFilterIndex = index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8.5),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF8655FE) : Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: isSelected
              ? null
              : Border.all(color: const Color(0xFFD6C8FF), width: 1.5),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: isSelected ? Colors.white : Colors.black87,
          ),
        ),
      ),
    );
  }

  Widget _buildCompletedCampaignItem({
    required String title,
    required String subtitle,
    required String time,
    required int unreadCount,
    required String brandText,
    required Color brandBgColor,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14.0),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: brandBgColor,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              brandText,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 9.5,
                fontWeight: FontWeight.w700,
                color: Colors.white,
                letterSpacing: 1.2,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12.5,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF616161),
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                time,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF757575),
                ),
              ),
              const SizedBox(height: 6),
              if (unreadCount > 0)
                Container(
                  width: 22,
                  height: 22,
                  decoration: const BoxDecoration(
                    color: Color(0xFFB18CFF),
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '$unreadCount',
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
            ],
          ),
        ],
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
              onTap: () => Get.to(() => const MyCampaignScreen()),
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
              onTap: () => Get.offAll(() => const AiScreen()),
              child: _buildNavIcon(
                'assets/images/ai_icon.png',
                isActive: _selectedTabIndex == 2,
                width: 24,
                height: 20,
              ),
            ),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => setState(() => _selectedTabIndex = 3),
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
