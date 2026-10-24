import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'creator_setting_screen.dart';
import 'package:snaapii/widgets/creator_widget/creator_bottom_nav_bar.dart';
import 'package:snaapii/widgets/creator_widget/creator_profile_header.dart';
import 'package:snaapii/widgets/creator_widget/instagram_verify_card.dart';

class CreatorProfileScreen extends StatefulWidget {
  const CreatorProfileScreen({super.key});

  @override
  State<CreatorProfileScreen> createState() => _CreatorProfileScreenState();
}

class _CreatorProfileScreenState extends State<CreatorProfileScreen> {
  int _selectedSubTab = 0;

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
                                const CreatorProfileHeader(),
                                const SizedBox(height: 24),

                                Row(
                                  children: [
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () =>
                                            setState(() => _selectedSubTab = 0),
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 12,
                                          ),
                                          decoration: BoxDecoration(
                                            color: _selectedSubTab == 0
                                                ? const Color(0xFF9E8EFE)
                                                : Colors.white,
                                            borderRadius: BorderRadius.circular(
                                              24,
                                            ),
                                            border: _selectedSubTab == 0
                                                ? null
                                                : Border.all(
                                                    color: const Color(
                                                      0xFFE0E0E0,
                                                    ),
                                                    width: 1,
                                                  ),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                'assets/images/instagram_icon.png',
                                                width: 22,
                                                height: 22,
                                                color: _selectedSubTab == 0
                                                    ? Colors.white
                                                    : Colors.black87,
                                                errorBuilder:
                                                    (
                                                      context,
                                                      error,
                                                      stackTrace,
                                                    ) => Icon(
                                                      Icons.camera_alt,
                                                      color:
                                                          _selectedSubTab == 0
                                                          ? Colors.white
                                                          : Colors.black87,
                                                      size: 22,
                                                    ),
                                              ),
                                              const SizedBox(width: 8),
                                              Text(
                                                'Instagram',
                                                style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  color: _selectedSubTab == 0
                                                      ? Colors.white
                                                      : Colors.black87,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 16),

                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () =>
                                            setState(() => _selectedSubTab = 1),
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 12,
                                          ),
                                          decoration: BoxDecoration(
                                            color: _selectedSubTab == 1
                                                ? const Color(0xFF9E8EFE)
                                                : Colors.white,
                                            borderRadius: BorderRadius.circular(
                                              24,
                                            ),
                                            border: _selectedSubTab == 1
                                                ? null
                                                : Border.all(
                                                    color: const Color(
                                                      0xFFE0E0E0,
                                                    ),
                                                    width: 1,
                                                  ),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.star,
                                                color: _selectedSubTab == 1
                                                    ? Colors.white
                                                    : Colors.black87,
                                                size: 20,
                                              ),
                                              const SizedBox(width: 8),
                                              Text(
                                                'Reviews',
                                                style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  color: _selectedSubTab == 1
                                                      ? Colors.white
                                                      : Colors.black87,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),

                                _selectedSubTab == 0
                                    ? const InstagramVerifyCard()
                                    : _buildReviewsView(),
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

                  const CreatorBottomNavBar(selectedTabIndex: 4),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildReviewsView() {
    return Container(
      height: 200,
      alignment: Alignment.center,
      child: const Text(
        'No Review found',
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: Color(0xFF9E9E9E),
        ),
      ),
    );
  }


}


