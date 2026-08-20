import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'comment_viewdetails_screen.dart';
import 'dm_shoecollection_screen.dart';
import 'smart_auto_dm_screen.dart';
import 'story_shoecollection_screen.dart';

class AutomationDashboardScreen extends StatelessWidget {
  final String automationType;
  final bool isDm;

  const AutomationDashboardScreen({
    super.key,
    this.automationType = 'comment',
    this.isDm = false,
  });

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
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 480),
              child: Column(
                children: [
                  const SizedBox(height: 8),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () => Get.back(),
                          behavior: HitTestBehavior.opaque,
                          child: const Icon(
                            Icons.arrow_back_ios_new,
                            color: Color(0xFF6B4EFF),
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Text(
                          'Smart Auto DM',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF6B4EFF),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),

                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 8.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildSectionTitle('Comment on post or reel'),
                          const SizedBox(height: 8),
                          _buildCommentCard(),
                          const SizedBox(height: 18),

                          _buildSectionTitle('DM Keywords'),
                          const SizedBox(height: 8),
                          _buildDmKeywordsCard(),
                          const SizedBox(height: 18),

                          _buildSectionTitle('Story reply'),
                          const SizedBox(height: 8),
                          _buildStoryReplyCard(),
                          const SizedBox(height: 18),

                          _buildSectionTitle('Auto reply'),
                          const SizedBox(height: 8),
                          _buildAutoReplyCard(),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
                    child: GestureDetector(
                      onTap: () {
                        Get.to(() => const SmartAutoDmScreen());
                      },
                      behavior: HitTestBehavior.opaque,
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          gradient: const LinearGradient(
                            colors: [Color(0xFF8B5CF6), Color(0xFF6366F1)],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(
                                0xFF6B4EFF,
                              ).withValues(alpha: 0.3),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: const Center(
                          child: Text(
                            'Create Automation',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontFamily: 'Poppins',
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Colors.black87,
      ),
    );
  }

  Widget _buildCommentCard() {
    return _buildContainerCard(
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  'assets/images/girl_image.png',
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Shoe Collection',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 4),
                    _buildPillTag('Any Comments'),
                  ],
                ),
              ),
              _buildLiveBadge(),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(height: 1, color: Color(0xFFF1F5F9)),
          const SizedBox(height: 12),

          Row(
            children: [
              Expanded(
                child: _buildMetricItem(
                  icon: Icons.people_alt_rounded,
                  iconBgColor: const Color(0xFFD1FAE5),
                  iconColor: const Color(0xFF059669),
                  value: '215',
                  label: 'followers',
                ),
              ),
              _buildVerticalDivider(),
              Expanded(
                child: _buildMetricItem(
                  icon: Icons.chat_bubble_rounded,
                  iconBgColor: const Color(0xFFEDE9FE),
                  iconColor: const Color(0xFF7C3AED),
                  value: '1200',
                  label: 'Comments',
                ),
              ),
              _buildVerticalDivider(),
              Expanded(
                child: _buildMetricItem(
                  imagePath: 'assets/images/up_arrow_icon.png',
                  iconBgColor: const Color(0xFFFCE7F3),
                  iconColor: const Color(0xFFDB2777),
                  value: '392',
                  label: 'Clicks',
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          _buildViewDetailsButton(
            onTap: () => Get.to(() => const CommentShoeCollectionScreen()),
          ),
        ],
      ),
    );
  }

  Widget _buildDmKeywordsCard() {
    return _buildContainerCard(
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: const Color(0xFFEDE9FE),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Icon(
                    Icons.send_rounded,
                    color: Color(0xFF7C3AED),
                    size: 24,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Shoe Collection',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 4),
                    _buildPillTag('LINK'),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(height: 1, color: Color(0xFFF1F5F9)),
          const SizedBox(height: 12),

          Row(
            children: [
              Expanded(
                child: _buildMetricItem(
                  icon: Icons.people_alt_rounded,
                  iconBgColor: const Color(0xFFD1FAE5),
                  iconColor: const Color(0xFF059669),
                  value: '215',
                  label: 'followers',
                ),
              ),
              _buildVerticalDivider(),
              Expanded(
                child: _buildMetricItem(
                  icon: Icons.send_rounded,
                  iconBgColor: const Color(0xFFEDE9FE),
                  iconColor: const Color(0xFF7C3AED),
                  value: '1200',
                  label: 'DMs Sent',
                ),
              ),
              _buildVerticalDivider(),
              Expanded(
                child: _buildMetricItem(
                  imagePath: 'assets/images/up_arrow_icon.png',
                  iconBgColor: const Color(0xFFFCE7F3),
                  iconColor: const Color(0xFFDB2777),
                  value: '392',
                  label: 'Clicks',
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          _buildViewDetailsButton(
            onTap: () => Get.to(() => const DmShoeCollectionScreen()),
          ),
        ],
      ),
    );
  }

  Widget _buildStoryReplyCard() {
    return _buildContainerCard(
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  'assets/images/girl_image.png',
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Shoe Collection',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 2),
                    const Text(
                      'When user replies story',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 10,
                        color: Color(0xFF757575),
                      ),
                    ),
                    const SizedBox(height: 3),
                    Row(
                      children: [
                        const Text(
                          'Trigger : ',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 10,
                            color: Color(0xFF757575),
                          ),
                        ),
                        _buildPillTag('LINK'),
                      ],
                    ),
                  ],
                ),
              ),
              _buildLiveBadge(),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(height: 1, color: Color(0xFFF1F5F9)),
          const SizedBox(height: 12),

          Row(
            children: [
              Expanded(
                child: _buildMetricItem(
                  icon: Icons.people_alt_rounded,
                  iconBgColor: const Color(0xFFD1FAE5),
                  iconColor: const Color(0xFF059669),
                  value: '215',
                  label: 'followers',
                ),
              ),
              _buildVerticalDivider(),
              Expanded(
                child: _buildMetricItem(
                  icon: Icons.chat_bubble_rounded,
                  iconBgColor: const Color(0xFFEDE9FE),
                  iconColor: const Color(0xFF7C3AED),
                  value: '1200',
                  label: 'Replied',
                ),
              ),
              _buildVerticalDivider(),
              Expanded(
                child: _buildMetricItem(
                  imagePath: 'assets/images/up_arrow_icon.png',
                  iconBgColor: const Color(0xFFFCE7F3),
                  iconColor: const Color(0xFFDB2777),
                  value: '392',
                  label: 'Clicks',
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          _buildViewDetailsButton(
            onTap: () => Get.to(() => const StoryShoeCollectionScreen()),
          ),
        ],
      ),
    );
  }

  Widget _buildAutoReplyCard() {
    return _buildContainerCard(
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  'assets/images/girl_image.png',
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Shoe Collection',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 2),
                    const Text(
                      'AI Replies the comments',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 10,
                        color: Color(0xFF757575),
                      ),
                    ),
                    const SizedBox(height: 4),
                    _buildPillTag('AI Replies'),
                  ],
                ),
              ),
              _buildLiveBadge(),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(height: 1, color: Color(0xFFF1F5F9)),
          const SizedBox(height: 10),

          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Container(
                      width: 28,
                      height: 28,
                      decoration: const BoxDecoration(
                        color: Color(0xFFEDE9FE),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.history_rounded,
                        color: Color(0xFF7C3AED),
                        size: 16,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Replies Delays',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 9.5,
                            color: Color(0xFF757575),
                          ),
                        ),
                        Text(
                          '15 sec',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              _buildVerticalDivider(),

              Expanded(
                child: Row(
                  children: [
                    const SizedBox(width: 8),
                    Container(
                      width: 28,
                      height: 28,
                      decoration: const BoxDecoration(
                        color: Color(0xFFFCE7F3),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.favorite_rounded,
                        color: Color(0xFFDB2777),
                        size: 16,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Auto Like',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 9.5,
                            color: Color(0xFF757575),
                          ),
                        ),
                        Text(
                          'ON',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF059669),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Divider(height: 1, color: Color(0xFFF1F5F9)),
          const SizedBox(height: 10),

          Row(
            children: [
              Expanded(
                child: _buildMetricItem(
                  icon: Icons.people_alt_rounded,
                  iconBgColor: const Color(0xFFD1FAE5),
                  iconColor: const Color(0xFF059669),
                  value: '215',
                  label: 'followers',
                ),
              ),
              _buildVerticalDivider(),
              Expanded(
                child: _buildMetricItem(
                  icon: Icons.chat_bubble_rounded,
                  iconBgColor: const Color(0xFFEDE9FE),
                  iconColor: const Color(0xFF7C3AED),
                  value: '400',
                  label: 'Replies',
                ),
              ),
              _buildVerticalDivider(),
              Expanded(
                child: _buildMetricItem(
                  icon: Icons.favorite_rounded,
                  iconBgColor: const Color(0xFFFCE7F3),
                  iconColor: const Color(0xFFDB2777),
                  value: '392',
                  label: 'Likes',
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          _buildViewDetailsButton(onTap: () {}),
        ],
      ),
    );
  }

  Widget _buildContainerCard({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFC4B5FD), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6B4EFF).withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _buildPillTag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2.5),
      decoration: BoxDecoration(
        color: const Color(0xFFEDE9FE),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontFamily: 'Poppins',
          fontSize: 9.5,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildLiveBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFD1FAE5),
        borderRadius: BorderRadius.circular(14),
      ),
      child: const Text(
        'Live',
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: Color(0xFF059669),
        ),
      ),
    );
  }

  Widget _buildMetricItem({
    IconData? icon,
    String? imagePath,
    required Color iconBgColor,
    required Color iconColor,
    required String value,
    required String label,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: iconBgColor,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Center(
            child: imagePath != null
                ? Image.asset(
                    imagePath,
                    width: 12,
                    height: 12,
                    color: iconColor,
                  )
                : Icon(icon, color: iconColor, size: 13),
          ),
        ),
        const SizedBox(width: 6),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              value,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 12.5,
                fontWeight: FontWeight.w700,
                color: Colors.black87,
                height: 1.1,
              ),
            ),
            Text(
              label,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 8.5,
                color: Color(0xFF757575),
                height: 1.1,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildVerticalDivider() {
    return Container(width: 1, height: 24, color: const Color(0xFFE2E8F0));
  }

  Widget _buildViewDetailsButton({VoidCallback? onTap}) {
    return GestureDetector(
      onTap:
          onTap ??
          () {
            if (automationType == 'story') {
              Get.to(() => const StoryShoeCollectionScreen());
            } else if (automationType == 'dm' || isDm) {
              Get.to(() => const DmShoeCollectionScreen());
            } else {
              Get.to(() => const CommentShoeCollectionScreen());
            }
          },
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: double.infinity,
        height: 38,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xFFC4B5FD), width: 1.0),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: const [
            Center(
              child: Text(
                'View details',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF8B5CF6),
                ),
              ),
            ),
            Positioned(
              right: 0,
              child: Icon(
                Icons.chevron_right_rounded,
                color: Color(0xFF8B5CF6),
                size: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
