import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../brand/ai/ai_screen.dart';
import '../brand/my_campaign/video_player_screen.dart';
import '../brand/articles/article_screen.dart';
import '../brand/account_recovery/account_recovery_screen.dart';
import 'audio_screen.dart';
import 'smart_auto_dm_screen.dart';
import 'wallet_screen.dart';
import 'campaign_details_screen.dart';
import 'creator_search_screen.dart';
import 'collab_charges_screen.dart';
import 'media_kit_screen.dart';
import 'refer_earn_screen.dart';
import 'growth_tips_reel_screen.dart';
import 'explore_screen.dart';
import 'notification_screen.dart';
import 'package:snaapii/widgets/creator_widget/marquee_text.dart';
import 'package:snaapii/widgets/creator_widget/creator_bottom_nav_bar.dart';
import 'package:snaapii/widgets/creator_widget/suggest_campaign_card.dart';
import 'package:snaapii/widgets/creator_widget/creator_footer_block.dart';

class CreatorHomeScreen extends StatefulWidget {
  const CreatorHomeScreen({super.key});

  @override
  State<CreatorHomeScreen> createState() => _CreatorHomeScreenState();
}

class _CreatorHomeScreenState extends State<CreatorHomeScreen> {
  int _currentBannerIndex = 0;
  late final PageController _bannerPageController;
  Timer? _bannerTimer;

  @override
  void initState() {
    super.initState();
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
                      physics: const BouncingScrollPhysics(),
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

                          const SizedBox(height: 16),

                          _buildActionCategories(),

                          const SizedBox(height: 24),

                          SuggestCampaignCard(
                            onReadMore: () {
                              Get.to(
                                () => const CampaignDetailsScreen(
                                  brandName: 'Gucci',
                                  category: 'Lifestyle',
                                  imagePath: 'assets/images/bancy.png',
                                  followers: '10K',
                                  reel: 'Reel 2',
                                  story: 'Story 1',
                                  post: 'Post 1',
                                ),
                              );
                            },
                          ),

                          const SizedBox(height: 24),

                          _buildTrendingAudioSection(),

                          const SizedBox(height: 24),

                          _buildBrandInsights(),

                          const SizedBox(height: 36),

                          const CreatorFooterBlock(),

                          const SizedBox(height: 100),
                        ],
                      ),
                    ),
                  ),

                  const CreatorBottomNavBar(selectedTabIndex: 0),
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
              _buildTopIconCircle(
                icon: Icons.play_circle_outline,
                onTap: () {
                  Get.to(
                    () => const VideoPlayerScreen(
                      title: 'Trending Video',
                      duration: '1:03',
                      previewWidget: SizedBox(),
                      videoAssetPath: 'assets/images/dvideo_1.mp4',
                    ),
                  );
                },
              ),
              const SizedBox(width: 8),
              _buildTopIconCircle(
                icon: Icons.notifications_none_outlined,
                onTap: () {
                  Get.to(() => const NotificationScreen());
                },
              ),
              const SizedBox(width: 8),
              _buildTopIconCircle(
                imagePath: 'assets/images/wallet_icon.png',
                onTap: () {
                  Get.to(() => const WalletScreen());
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTopIconCircle({
    IconData? icon,
    String? imagePath,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          border: Border.all(color: const Color(0xFFEBE8FC), width: 1.5),
        ),
        child: Center(
          child: imagePath != null
              ? Image.asset(
                  imagePath,
                  width: 16,
                  height: 16,
                  fit: BoxFit.contain,
                )
              : Icon(icon, color: Colors.black, size: 20),
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: GestureDetector(
        onTap: () {
          Get.to(() => const CreatorSearchScreen());
        },
        behavior: HitTestBehavior.opaque,
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
                  enabled: false,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 15,
                    color: Colors.black,
                  ),
                  decoration: const InputDecoration(
                    hintText: 'Search',
                    hintStyle: TextStyle(
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
                    child: const Center(
                      child: Text(
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
    final List<Map<String, dynamic>> items = [
      {
        'icon': 'assets/images/ai_icon.png',
        'label': 'AI',
        'onTap': () => Get.to(() => const AiScreen()),
      },
      {
        'icon': 'assets/images/smart_dm_icon.png',
        'label': 'Smart Auto DM',
        'onTap': () => Get.to(() => const SmartAutoDmScreen()),
      },
      {
        'icon': 'assets/images/invite_earn_icon.png',
        'label': 'Invite & Earn',
        'onTap': () => Get.to(() => const ReferEarnScreen()),
      },
      {
        'icon': 'assets/images/article_icon.png',
        'label': 'Articles',
        'onTap': () => Get.to(() => const ArticleScreen()),
      },
      {
        'icon': 'assets/images/collab_charges_icon.png',
        'label': 'Collab charges',
        'onTap': () => Get.to(() => const CollabChargesScreen()),
      },
      {
        'icon': 'assets/images/account_recovery_icon.png',
        'label': 'Account Recovery',
        'onTap': () => Get.to(() => const AccountRecoveryScreen()),
      },
      {
        'icon': 'assets/images/invoice_generate_icon.png',
        'label': 'Invoice Generator',
        'onTap': () {},
      },
      {
        'icon': 'assets/images/creator_cam_icon.png',
        'label': 'Creator Cam',
        'onTap': () {},
      },
      {
        'label': 'Instagram Health',
        'customPadding': EdgeInsets.zero,
        'customIconWidget': SizedBox(
          width: 46,
          height: 30,
          child: Stack(
            alignment: Alignment.center,
            children: [
              _buildThickenedIcon(
                Image.asset(
                  'assets/images/circle_icon.png',
                  width: 25,
                  height: 25,
                  fit: BoxFit.contain,
                ),
                spread: 0.6,
              ),
              Transform.translate(
                offset: const Offset(-3.5, 0),
                child: _buildThickenedIcon(
                  Image.asset(
                    'assets/images/instagram_health_icon.png',
                    width: 30,
                    fit: BoxFit.contain,
                  ),
                  spread: 0.6,
                ),
              ),
            ],
          ),
        ),
        'onTap': () {},
      },
      {
        'icon': 'assets/images/brand_insight_icon.png',
        'label': 'Growth tips',
        'onTap': () => Get.to(() => const GrowthTipsReelScreen()),
      },
      {
        'icon': 'assets/images/brand_insight_icon.png',
        'label': 'IG Trending Audio',
        'onTap': () => Get.to(() => const AudioScreen()),
      },
      {
        'icon': 'assets/images/create_compaign_icon.png',
        'label': 'Exploer Campaign',
        'onTap': () => Get.to(() => const ExploreScreen()),
      },
      {
        'icon': 'assets/images/media_kit_icon.png',
        'label': 'Media kit',
        'onTap': () => Get.to(() => const MediaKitScreen()),
      },
    ];

    return SizedBox(
      height: 120,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        itemCount: items.length,
        separatorBuilder: (context, index) => const SizedBox(width: 14),
        itemBuilder: (context, index) {
          final item = items[index];
          return _buildActionItem(
            item['icon'] as String?,
            item['label'] as String,
            onTap: item['onTap'] as VoidCallback?,
            customPadding: item['customPadding'] as EdgeInsetsGeometry?,
            customIconWidget: item['customIconWidget'] as Widget?,
          );
        },
      ),
    );
  }

  Widget _buildActionItem(
    String? iconPath,
    String label, {
    VoidCallback? onTap,
    EdgeInsetsGeometry? customPadding,
    Widget? customIconWidget,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 85,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 85,
              height: 85,
              padding: customPadding ?? const EdgeInsets.all(30),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage('assets/images/ai_bg.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Center(
                child: Transform.translate(
                  offset: const Offset(0, -4),
                  child:
                      customIconWidget ??
                      Image.asset(iconPath!, fit: BoxFit.contain),
                ),
              ),
            ),
            Transform.translate(
              offset: const Offset(0, -14),
              child: Text(
                label,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                  height: 1.1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildThickenedIcon(Widget icon, {double spread = 0.6}) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Transform.translate(offset: Offset(-spread, 0), child: icon),
        Transform.translate(offset: Offset(spread, 0), child: icon),
        Transform.translate(offset: Offset(0, -spread), child: icon),
        Transform.translate(offset: Offset(0, spread), child: icon),
        Transform.translate(
          offset: Offset(-spread * 0.7, -spread * 0.7),
          child: icon,
        ),
        Transform.translate(
          offset: Offset(spread * 0.7, spread * 0.7),
          child: icon,
        ),
        Transform.translate(
          offset: Offset(-spread * 0.7, spread * 0.7),
          child: icon,
        ),
        Transform.translate(
          offset: Offset(spread * 0.7, -spread * 0.7),
          child: icon,
        ),
        icon,
      ],
    );
  }

  Widget _buildTrendingAudioSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'Instagram Trending Audio',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1E1A34),
            ),
          ),
        ),
        const SizedBox(height: 10),

        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: 3,
            itemBuilder: (context, index) {
              return Container(
                width: 250,
                margin: const EdgeInsets.only(right: 14),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFFF7F7FD),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () => Get.to(() => const AudioScreen()),
                      behavior: HitTestBehavior.opaque,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Expanded(
                            child: Text(
                              'Choose Trending Music to Boost Your Reels',
                              maxLines: 2,
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 11.3,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF555555),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 2),
                            child: Icon(
                              Icons.arrow_forward_ios,
                              size: 18,
                              color: Color(0xFF9E8EFE),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildAudioItem('Gleech Music', '(Shreya Ghoshal)'),
                    const SizedBox(height: 8),
                    _buildAudioItem('Music', '(Arijit Singh)'),
                    const SizedBox(height: 8),
                    _buildAudioItem('Gleech Music', '(Shreya Ghoshal)'),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildAudioItem(String title, String artist) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: Image.asset(
            'assets/images/user_avatar.png',
            width: 36,
            height: 36,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.music_note, size: 12, color: Colors.black),
                const SizedBox(width: 2),
                Text(
                  title,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            Text(
              artist,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 10,
                fontWeight: FontWeight.w500,
                color: Color(0xFF7A58FF),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBrandInsights() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'Growth Tips',
            style: TextStyle(
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
              GestureDetector(
                onTap: () => Get.to(() => const GrowthTipsReelScreen()),
                behavior: HitTestBehavior.opaque,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Expanded(
                      child: Text(
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
                    Icon(
                      Icons.chevron_right,
                      color: Color(0xFF9E8EFE),
                      size: 20,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 180,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  children: [
                    _buildInsightCard(
                      index: 0,
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
                      index: 1,
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
                              Text(
                                'FESTIVAL',
                                style: GoogleFonts.poppins(
                                  fontSize: 8,
                                  letterSpacing: 2,
                                  color: Colors.white70,
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
                      index: 2,
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
    int? index,
  }) {
    return GestureDetector(
      onTap: () {
        if (index != null) {
          Get.to(() => GrowthTipsReelScreen(initialIndex: index));
        } else {
          Get.to(
            () => VideoPlayerScreen(
              title: title,
              duration: duration,
              previewWidget: child,
              videoAssetPath: videoAssetPath,
            ),
          );
        }
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
}
