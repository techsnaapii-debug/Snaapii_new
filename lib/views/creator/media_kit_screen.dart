import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'media_kit_analysis_screen.dart';

class MediaKitScreen extends StatelessWidget {
  const MediaKitScreen({super.key});

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
        body: SafeArea(
          child: Column(
            children: [
              // Top Bar
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 12.0,
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Get.back(),
                      behavior: HitTestBehavior.opaque,
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 4.0,
                          horizontal: 2.0,
                        ),
                        child: Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: Color(0xFF6B4EFF),
                          size: 20,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      'Media Kit',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF6B4EFF),
                      ),
                    ),
                  ],
                ),
              ),

              // Scrollable Body
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 12),

                      // Header Section: Left text + Right Media Kit preview card
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Left text
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                SizedBox(height: 10),
                                Text(
                                  'Create Your\nMedia Kit',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 24,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.black,
                                    height: 1.22,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Showcase your instagram Profile,\ninsight and pricing to attract\nbrand and collabrations.',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                    height: 1.35,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),

                          // Right Preview Card
                          _buildPreviewCard(),
                        ],
                      ),

                      const SizedBox(height: 36),

                      // Features List
                      _buildFeatureItem(
                        icon: Icons.bar_chart_rounded,
                        title: 'Professional Media Kit',
                        subtitle: 'Show your profile stats and pricing',
                      ),
                      const SizedBox(height: 22),

                      _buildFeatureItem(
                        icon: Icons.grid_view_rounded,
                        title: 'Beautiful Template',
                        subtitle: 'Choose for clean and modern template',
                      ),
                      const SizedBox(height: 22),

                      _buildFeatureItem(
                        icon: Icons.sell_outlined,
                        title: 'Attract Brand',
                        subtitle:
                            'Show case your value to get more collaboration',
                      ),
                      const SizedBox(height: 22),

                      _buildFeatureItem(
                        imagePath: 'assets/images/download_icon.png',
                        title: 'Download or share',
                        subtitle:
                            'Get a high quality media kit to share anywhere',
                      ),

                      const SizedBox(height: 40),

                      // Bottom Create Now Button
                      GestureDetector(
                        onTap: () =>
                            Get.to(() => const MediaKitAnalysisScreen()),
                        child: Container(
                          width: double.infinity,
                          height: 52,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(26),
                            gradient: const LinearGradient(
                              colors: [Color(0xFFB575FF), Color(0xFF5667FF)],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(
                                  0xFF5667FF,
                                ).withValues(alpha: 0.35),
                                blurRadius: 16,
                                offset: const Offset(0, 6),
                              ),
                            ],
                          ),
                          child: const Center(
                            child: Text(
                              'Create Now',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPreviewCard() {
    return Container(
      width: 145,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(36),
          topRight: Radius.circular(10),
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(36),
        ),
        border: Border.all(
          color: const Color(0xFF222222).withValues(alpha: 0.25),
          width: 1.1,
        ),
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.white,
            Colors.white,
            Color(0xFFEDE9FE),
            Color(0xFFC084FC),
          ],
          stops: [0.0, 0.45, 0.72, 1.0],
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Avatar
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 1.5),
            ),
            child: ClipOval(
              child: Image.asset(
                'assets/images/user_avatar.png',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: const Color(0xFF10B981),
                    child: const Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 24,
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 6),

          // Name
          const Text(
            'aldrina badss',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 11,
              fontWeight: FontWeight.w800,
              color: Colors.black,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 2),

          // Handle
          const Text(
            '@aldrina badss',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 8.5,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 2),

          // Tag
          const Text(
            'Lifestyle | fashion',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 7.5,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 10),

          // Stats: Followers & Engagement
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: const [
                  Text(
                    '33K',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 1),
                  Text(
                    'Fallowers',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 7,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              Column(
                children: const [
                  Text(
                    '3.9%',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 1),
                  Text(
                    'Engagement',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 7,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Pricing: Per Reel & Per Story
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: const [
                  Text(
                    'Per Reel',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 7.5,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 1),
                  Text(
                    '₹70K',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 10.5,
                      fontWeight: FontWeight.w800,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              Column(
                children: const [
                  Text(
                    'Per Story',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 7.5,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 1),
                  Text(
                    '₹70K',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 10.5,
                      fontWeight: FontWeight.w800,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 4),
        ],
      ),
    );
  }

  Widget _buildFeatureItem({
    IconData? icon,
    String? imagePath,
    required String title,
    required String subtitle,
  }) {
    return Row(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: const Color(0xFFF3E8FF),
            borderRadius: BorderRadius.circular(14),
          ),
          child: imagePath != null
              ? Center(
                  child: Image.asset(
                    imagePath,
                    width: 24,
                    height: 24,
                    fit: BoxFit.contain,
                  ),
                )
              : Icon(icon, color: const Color(0xFF8B5CF6), size: 26),
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
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                subtitle,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
