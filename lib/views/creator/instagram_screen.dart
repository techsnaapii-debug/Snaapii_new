import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'creator_setting_screen.dart';
import 'package:snaapii/widgets/creator_widget/creator_bottom_nav_bar.dart';
import 'package:snaapii/widgets/creator_widget/profile_metric_column.dart';

class InstagramScreen extends StatefulWidget {
  const InstagramScreen({super.key});

  @override
  State<InstagramScreen> createState() => _InstagramScreenState();
}

class _InstagramScreenState extends State<InstagramScreen> {
  int _selectedSubTab = 0;

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
                            const Text(
                              'Profile',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
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
                                    children: const [
                                      ProfileMetricColumn(
                                        value: '100K',
                                        label: 'Followers',
                                      ),
                                      ProfileMetricColumn(
                                        value: '500K',
                                        label: 'Average\nViews',
                                      ),
                                      ProfileMetricColumn(
                                        value: '1.9%',
                                        label: 'Weekly\nGrowth',
                                      ),
                                      ProfileMetricColumn(
                                        value: '200K',
                                        label: 'Average\nReach',
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
                                        children: const [
                                          ProfileMetricColumn(
                                            value: '2333',
                                            label: 'Average\nLikes',
                                          ),
                                          ProfileMetricColumn(
                                            value: '233',
                                            label: 'Average\nComments',
                                          ),
                                          ProfileMetricColumn(
                                            value: '23%',
                                            label: 'Engagement\nRate',
                                          ),
                                          ProfileMetricColumn(
                                            value: '2003',
                                            label: 'Average Story\nviews',
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
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
                                    ? GridView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
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
                                          final imgPath =
                                              _postThumbnails[index];
                                          return ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                            child: Stack(
                                              fit: StackFit.expand,
                                              children: [
                                                Image.asset(
                                                  imgPath,
                                                  fit: BoxFit.cover,
                                                  errorBuilder:
                                                      (
                                                        context,
                                                        error,
                                                        stackTrace,
                                                      ) => Container(
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
                                                    padding:
                                                        const EdgeInsets.all(3),
                                                    decoration: BoxDecoration(
                                                      color: Colors.black
                                                          .withValues(
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
                                                          Colors.black
                                                              .withValues(
                                                                alpha: 0.8,
                                                              ),
                                                          Colors.transparent,
                                                        ],
                                                        begin: Alignment
                                                            .bottomCenter,
                                                        end:
                                                            Alignment.topCenter,
                                                      ),
                                                    ),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
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
                                                            fontFamily:
                                                                'Poppins',
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
                                      )
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
