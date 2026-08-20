import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'video_player_screen.dart';
import 'my_campaign_screen.dart';
import '../ai/ai_screen.dart';
import '../chat/chat_screen.dart';
import '../profile/profile_screen_1.dart';
import '../../creator/explore_screen.dart';
import '../../creator/creator_home_screen.dart';
import '../../creator/creator_chat_screen.dart';
import '../../creator/smart_auto_dm_screen.dart';

class HomeScreen extends StatefulWidget {
  final bool? isCreator;
  static bool isCreatorRole = false;

  const HomeScreen({super.key, this.isCreator});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedTabIndex = 0;
  int _currentBannerIndex = 0;
  late final PageController _bannerPageController;
  Timer? _bannerTimer;

  @override
  void initState() {
    super.initState();
    if (widget.isCreator != null) {
      HomeScreen.isCreatorRole = widget.isCreator!;
    }

    _bannerPageController = PageController(initialPage: 300);
    _currentBannerIndex = 0;
    _startBannerAutoScroll();
  }

  void _startBannerAutoScroll() {
    _bannerTimer = Timer.periodic(const Duration(seconds: 2), (timer) {
      if (_bannerPageController.hasClients) {
        int nextPage = _bannerPageController.page!.round() + 1;
        _bannerPageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _bannerTimer?.cancel();
    _bannerPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (HomeScreen.isCreatorRole) {
      return const CreatorHomeScreen();
    }

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: Colors.transparent,
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: SizedBox.expand(
              child: Stack(
                children: [
                  SafeArea(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 16),

                          _buildTopBar(),

                          const SizedBox(height: 16),

                          _buildSearchBar(),

                          const SizedBox(height: 16),

                          _buildBannerSlider(),

                          const SizedBox(height: 6),

                          _buildDotIndicators(),

                          const SizedBox(height: 12),

                          _buildActionCategories(),

                          const SizedBox(height: 10),

                          _buildBrandInsights(),

                          const SizedBox(height: 36),

                          _buildFooterBlock(),

                          const SizedBox(height: 100),
                        ],
                      ),
                    ),
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

  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 120,
            height: 32,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xD99E8EFE),
              borderRadius: BorderRadius.circular(20),
            ),
            child: ClipRect(
              child: Center(
                child: MarqueeText(
                  text: '@Kumar joined',
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),

          Row(
            children: [
              _buildTopIconCircle(Icons.play_circle_outline),
              const SizedBox(width: 8),
              _buildTopIconCircle(Icons.notifications_none_outlined),
              const SizedBox(width: 8),
              _buildTopIconCircle(Icons.account_balance_wallet_outlined),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTopIconCircle(IconData icon) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(color: const Color(0xFFEBE8FC), width: 1.5),
      ),
      child: Icon(icon, color: Colors.black, size: 20),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFD6C8FF), width: 1.5),
        ),
        child: Row(
          children: [
            const SizedBox(width: 12),
            const Icon(Icons.search, color: Color(0xFFCCCCCC), size: 20),
            const SizedBox(width: 8),
            Expanded(
              child: TextField(
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 15,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 15,
                    color: Color(0xFFCCCCCC),
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                  isDense: true,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBannerSlider() {
    final List<String> banners = [
      'assets/images/login_banner.png',
      'assets/images/banner_2.jpg',
      'assets/images/banner_3.jpg',
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        height: 180,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: PageView.builder(
            controller: _bannerPageController,
            itemCount: 9999,
            allowImplicitScrolling: true,
            onPageChanged: (index) {
              setState(() {
                _currentBannerIndex = index % banners.length;
              });
            },
            itemBuilder: (context, index) {
              final imageIndex = index % banners.length;
              return Image.asset(
                banners[imageIndex],
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: const Color(0xFFFFEBE3),
                    child: Center(
                      child: const Text(
                        'Age of Sage Skincare Brand',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildDotIndicators() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        3,
        (index) => Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _currentBannerIndex == index
                ? const Color(0xFF9E8EFE)
                : const Color(0xFFEBE8FC),
          ),
        ),
      ),
    );
  }

  Widget _buildActionCategories() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildActionItem(
            'assets/images/ai_icon.png',
            'AI',
            onTap: () {
              Get.to(() => const AiScreen());
            },
          ),
          _buildActionItem(
            HomeScreen.isCreatorRole
                ? 'assets/images/smart_dm_icon.png'
                : 'assets/images/create_compaign_icon.png',
            HomeScreen.isCreatorRole ? 'Smart Auto DM' : 'Create Campaign',
            onTap: () {
              if (!HomeScreen.isCreatorRole) {
                Get.to(() => const MyCampaignScreen());
              } else {
                Get.to(() => const SmartAutoDmScreen());
              }
            },
          ),
          _buildActionItem(
            HomeScreen.isCreatorRole
                ? 'assets/images/invite_earn_icon.png'
                : 'assets/images/smart_dm_icon.png',
            HomeScreen.isCreatorRole ? 'Invite & Earn' : 'Smart Auto DM',
            customPadding: HomeScreen.isCreatorRole
                ? const EdgeInsets.all(24)
                : null,
            onTap: () {
              if (!HomeScreen.isCreatorRole) {
                Get.to(() => const SmartAutoDmScreen());
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildActionItem(
    String iconPath,
    String label, {
    VoidCallback? onTap,
    EdgeInsetsGeometry? customPadding,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        children: [
          Container(
            width: 95,
            height: 95,
            padding: customPadding ?? const EdgeInsets.all(36),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage('assets/images/ai_bg.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              child: Transform.translate(
                offset: const Offset(0, -5),
                child: Image.asset(iconPath, fit: BoxFit.contain),
              ),
            ),
          ),
          Transform.translate(
            offset: const Offset(0, -16),
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.black,
                height: 1.0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBrandInsights() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'Brand Insights',
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16.0),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFFF9F8FF),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFEBE8FC), width: 1.5),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: const Text(
                      'Smart strategies to grow faster with creators',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const Icon(
                    Icons.chevron_right,
                    color: Color(0xFF9E8EFE),
                    size: 20,
                  ),
                ],
              ),
              const SizedBox(height: 16),

              SizedBox(
                height: 180,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  children: [
                    _buildInsightCard(
                      title:
                          'Smart strategy: Creative Sound design in video campaigns',
                      videoAssetPath: 'assets/images/dvideo_1.mp4',
                      child: Container(
                        color: const Color(0xFFECE6D9),
                        child: Center(
                          child: Icon(
                            Icons.music_note,
                            color: Colors.black.withValues(alpha: 0.3),
                            size: 40,
                          ),
                        ),
                      ),
                      duration: '1:03',
                    ),
                    const SizedBox(width: 12),
                    _buildInsightCard(
                      title:
                          'Brand Growth: Jazz Festival Live Concert Marketing',
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xFF565EFA), Color(0xFF26C6DA)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'jazz',
                                style: GoogleFonts.playfairDisplay(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const Text(
                                'FESTIVAL',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                  letterSpacing: 2,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      duration: '0:20',
                    ),
                    const SizedBox(width: 12),
                    _buildInsightCard(
                      title:
                          'Live Streaming Sessions: Organic reach strategies',
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xFFB18CFF), Color(0xFFE040FB)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: Center(
                          child: const Text(
                            'MUSIC',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                      ),
                      duration: '0:15',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInsightCard({
    required String title,
    required Widget child,
    required String duration,
    String? videoAssetPath,
  }) {
    return GestureDetector(
      onTap: () {
        Get.to(
          () => VideoPlayerScreen(
            title: title,
            duration: duration,
            previewWidget: child,
            videoAssetPath: videoAssetPath,
          ),
        );
      },
      child: Container(
        width: 120,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            children: [
              Positioned.fill(child: child),

              Positioned(
                left: 8,
                bottom: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.6),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.play_arrow,
                        color: Colors.white,
                        size: 10,
                      ),
                      const SizedBox(width: 2),
                      Text(
                        duration,
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 9,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
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

  Widget _buildFooterBlock() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              'Discover.\nCollaborate. Grow. 🚀',
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 34,
                fontWeight: FontWeight.bold,
                color: Color(0xFFC5C5C5),
                height: 1.3,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text(
                'Protected with Official ',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  color: Color(0xFF666666),
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 13),
              Image.asset(
                'assets/images/meta.png',
                width: 30,
                height: 30,
                fit: BoxFit.contain,
              ),
              const SizedBox(width: 13),
              const Text(
                'Meta APIs',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  color: Color(0xFF666666),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const Text(
            'Security',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 16,
              color: Color(0xFF666666),
              fontWeight: FontWeight.w500,
            ),
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
              onTap: () => setState(() => _selectedTabIndex = 0),
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
                  Get.to(() => const MyCampaignScreen());
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
              onTap: () {
                if (HomeScreen.isCreatorRole) {
                  Get.to(() => const CreatorChatScreen());
                } else {
                  Get.to(() => const ChatScreen());
                }
              },
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

class MarqueeText extends StatefulWidget {
  final String text;
  final TextStyle style;

  const MarqueeText({super.key, required this.text, required this.style});

  @override
  State<MarqueeText> createState() => _MarqueeTextState();
}

class _MarqueeTextState extends State<MarqueeText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2500),
      vsync: this,
    );

    _offsetAnimation = TweenSequence<Offset>([
      TweenSequenceItem(
        tween: Tween<Offset>(
          begin: const Offset(1.5, 0.0),
          end: Offset.zero,
        ).chain(CurveTween(curve: Curves.fastOutSlowIn)),
        weight: 20,
      ),

      TweenSequenceItem(tween: ConstantTween<Offset>(Offset.zero), weight: 50),

      TweenSequenceItem(
        tween: Tween<Offset>(
          begin: Offset.zero,
          end: const Offset(-1.5, 0.0),
        ).chain(CurveTween(curve: Curves.fastOutSlowIn)),
        weight: 20,
      ),

      TweenSequenceItem(
        tween: ConstantTween<Offset>(const Offset(1.5, 0.0)),
        weight: 10,
      ),
    ]).animate(_controller);

    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offsetAnimation,
      child: Text(
        widget.text,
        style: widget.style,
        maxLines: 1,
        overflow: TextOverflow.visible,
      ),
    );
  }
}
