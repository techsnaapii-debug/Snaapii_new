import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'creator_chat_screen.dart';
import 'creator_home_screen.dart';
import 'creator_profile_screen.dart';
import 'creator_setting_screen.dart';
import 'explore_screen.dart';
import '../brand/ai/ai_screen.dart';

class InstagramScreen extends StatefulWidget {
  const InstagramScreen({super.key});

  @override
  State<InstagramScreen> createState() => _InstagramScreenState();
}

class _InstagramScreenState extends State<InstagramScreen> {
  int _selectedTabIndex = 4;

  final List<String> _postThumbnails = [
    'assets/images/user_avatar.png',
    'assets/images/bancy.png',
    'assets/images/animate_girl.png',
    'assets/images/user_avatar.png',
    'assets/images/animate_girl.png',
    'assets/images/bancy.png',
  ];

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
        backgroundColor: const Color(0xFF9E8EFE),
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () => Get.back(),
                                  behavior: HitTestBehavior.opaque,
                                  child: const Icon(
                                    Icons.arrow_back_ios_new,
                                    color: Colors.white,
                                    size: 22,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                const Text(
                                  'Profile',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 24,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            GestureDetector(
                              onTap: () =>
                                  Get.to(() => const CreatorSettingScreen()),
                              behavior: HitTestBehavior.opaque,
                              child: const Icon(
                                Icons.menu_rounded,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),

                      Expanded(
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(30),
                            ),
                          ),
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.fromLTRB(16, 24, 16, 100),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    ClipOval(
                                      child: Image.asset(
                                        'assets/images/user_avatar.png',
                                        width: 92,
                                        height: 92,
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) =>
                                                Container(
                                                  width: 92,
                                                  height: 92,
                                                  color: const Color(
                                                    0xFF9E8EFE,
                                                  ),
                                                  child: const Icon(
                                                    Icons.person,
                                                    size: 50,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: const [
                                              Text(
                                                'Richa ',
                                                style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              Text(
                                                '(Beauty)',
                                                style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize: 14.5,
                                                  fontWeight: FontWeight.w500,
                                                  color: Color(0xFF616161),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 6),
                                          Row(
                                            children: const [
                                              Icon(
                                                Icons.location_on,
                                                color: Color(0xFF9E8EFE),
                                                size: 18,
                                              ),
                                              SizedBox(width: 4),
                                              Text(
                                                'New Delhi, Delhi',
                                                style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  color: Color(0xFF6B4EFF),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),

                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16,
                                    horizontal: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                      color: const Color(0xFFE5E0FF),
                                      width: 1.5,
                                    ),
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      _buildMetricColumn('100K', 'Followers'),
                                      _buildMetricColumn(
                                        '500K',
                                        'Average\nViews',
                                      ),
                                      _buildMetricColumn(
                                        '1.9%',
                                        'Weekly\nGrowth',
                                      ),
                                      _buildMetricColumn(
                                        '200K',
                                        'Average\nReach',
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 16),

                                Container(
                                  padding: const EdgeInsets.fromLTRB(
                                    4,
                                    16,
                                    4,
                                    16,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                      color: const Color(0xFFE5E0FF),
                                      width: 1.5,
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      const Center(
                                        child: Text(
                                          'Engagement Analytics',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xFF222222),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 14),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          _buildMetricColumn(
                                            '2333',
                                            'Average\nLikes',
                                          ),
                                          _buildMetricColumn(
                                            '233',
                                            'Average\nComments',
                                          ),
                                          _buildMetricColumn(
                                            '23%',
                                            'Engagement\nRate',
                                          ),
                                          _buildMetricColumn(
                                            '2003',
                                            'Average Story\nviews',
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 24),

                                Row(
                                  children: [
                                    Image.asset(
                                      'assets/images/instagram_icon.png',
                                      width: 24,
                                      height: 24,
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                              const Icon(
                                                Icons.camera_alt,
                                                size: 24,
                                                color: Colors.black,
                                              ),
                                    ),
                                    const SizedBox(width: 10),
                                    const Text(
                                      'Instagram',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 14),

                                GridView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  padding: EdgeInsets.zero,
                                  itemCount: _postThumbnails.length,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                        crossAxisSpacing: 10,
                                        mainAxisSpacing: 10,
                                        childAspectRatio: 0.72,
                                      ),
                                  itemBuilder: (context, index) {
                                    final imgPath = _postThumbnails[index];
                                    return ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Stack(
                                        fit: StackFit.expand,
                                        children: [
                                          Image.asset(
                                            imgPath,
                                            fit: BoxFit.cover,
                                            errorBuilder:
                                                (context, error, stackTrace) =>
                                                    Container(
                                                      color: const Color(
                                                        0xFFE5E0FF,
                                                      ),
                                                      child: const Icon(
                                                        Icons.image,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                          ),

                                          Positioned(
                                            top: 6,
                                            right: 6,
                                            child: Container(
                                              padding: const EdgeInsets.all(3),
                                              decoration: BoxDecoration(
                                                color: Colors.black.withValues(
                                                  alpha: 0.35,
                                                ),
                                                shape: BoxShape.circle,
                                              ),
                                              child: const Icon(
                                                Icons.play_arrow_rounded,
                                                color: Colors.white,
                                                size: 16,
                                              ),
                                            ),
                                          ),

                                          Positioned(
                                            left: 0,
                                            right: 0,
                                            bottom: 0,
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 6,
                                                    vertical: 4,
                                                  ),
                                              decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                  colors: [
                                                    Colors.black.withValues(
                                                      alpha: 0.8,
                                                    ),
                                                    Colors.transparent,
                                                  ],
                                                  begin: Alignment.bottomCenter,
                                                  end: Alignment.topCenter,
                                                ),
                                              ),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: const [
                                                  Icon(
                                                    Icons.show_chart,
                                                    color: Colors.white,
                                                    size: 14,
                                                  ),
                                                  SizedBox(width: 3),
                                                  Text(
                                                    '2.3k',
                                                    style: TextStyle(
                                                      fontFamily: 'Poppins',
                                                      fontSize: 11,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
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

  Widget _buildMetricColumn(String value, String label) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            value,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E1A34),
            ),
          ),
          const SizedBox(height: 4),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 11.5,
                fontWeight: FontWeight.w500,
                color: Color(0xFF666666),
                height: 1.2,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Positioned(
      bottom: 24,
      left: 16,
      right: 16,
      child: Center(
        child: Container(
          width: 350,
          height: 64,
          decoration: BoxDecoration(
            color: const Color(0xFF9E8EFE),
            borderRadius: BorderRadius.circular(32),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF9E8EFE).withValues(alpha: 0.3),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildNavItem(iconPath: 'assets/images/home_icon.png', index: 0),
              _buildNavItem(
                iconPath: 'assets/images/explore_icon.png',
                index: 1,
              ),
              _buildNavItem(iconPath: 'assets/images/ai_icon.png', index: 2),
              _buildNavItem(
                iconPath: 'assets/images/message_icon.png',
                index: 3,
              ),
              _buildNavItem(
                iconPath: 'assets/images/person_icon.png',
                index: 4,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({required String iconPath, required int index}) {
    final bool isSelected = _selectedTabIndex == index;
    return GestureDetector(
      onTap: () {
        if (isSelected) return;
        setState(() {
          _selectedTabIndex = index;
        });

        if (index == 0) {
          Get.offAll(() => const CreatorHomeScreen());
        } else if (index == 1) {
          Get.offAll(() => const ExploreScreen());
        } else if (index == 2) {
          Get.offAll(() => const AiScreen());
        } else if (index == 3) {
          Get.offAll(() => const CreatorChatScreen());
        } else if (index == 4) {
          Get.offAll(() => const CreatorProfileScreen());
        }
      },
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            iconPath,
            width: 24,
            height: 24,
            color: Colors.white,
            errorBuilder: (context, error, stackTrace) =>
                const Icon(Icons.star, color: Colors.white, size: 24),
          ),
          const SizedBox(height: 4),
          if (isSelected)
            Container(
              width: 24,
              height: 2.5,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
        ],
      ),
    );
  }
}
