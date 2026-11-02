import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../services/home_api.dart';
import '../../services/auth_api.dart';
import '../../services/instagram_access_gate.dart';
import '../../services/notification_api.dart';
import '../../services/search_api.dart';
import '../shared/home_media.dart';
import '../brand/ai/ai_screen.dart';
import '../brand/my_campaign/video_player_screen.dart';
import 'creator_chat_screen.dart';
import 'creator_profile_screen.dart';
import 'explore_screen.dart';
import 'campaign_details_screen.dart';
import 'audio_screen.dart';
import 'smart_auto_dm_screen.dart';
import 'refer_earn_screen.dart';
import 'wallet_screen.dart';
import '../shared/notifications_screen.dart';

class CreatorHomeScreen extends StatefulWidget {
  const CreatorHomeScreen({super.key});

  @override
  State<CreatorHomeScreen> createState() => _CreatorHomeScreenState();
}

class _CreatorHomeScreenState extends State<CreatorHomeScreen> {
  int _selectedTabIndex = 0;
  List<Map<String, dynamic>> _banners = [];
  List<Map<String, dynamic>> _videos = [];
  List<Map<String, dynamic>> _campaigns = [];
  List<Map<String, dynamic>> _trendingAudios = [];
  String? _homeError;
  String _search = '';
  int _unreadNotifications = 0;
  Timer? _searchDebounce;

  @override
  void initState() {
    super.initState();
    _loadHome();
  }

  Future<void> _loadHome() async {
    final results = await Future.wait<Object>([
      _loadListSafely(HomeApi.banners),
      _loadListSafely(() => HomeApi.videos('creator')),
      _loadListSafely(HomeApi.creatorCampaigns),
      _loadListSafely(HomeApi.trendingAudios),
      _loadUnreadCountSafely(),
    ]);
    if (!mounted) return;
    setState(() {
      _banners = results[0] as List<Map<String, dynamic>>;
      _videos = results[1] as List<Map<String, dynamic>>;
      _campaigns = results[2] as List<Map<String, dynamic>>;
      _trendingAudios = results[3] as List<Map<String, dynamic>>;
      _unreadNotifications = results[4] as int;
      _homeError = null;
    });
  }

  Future<List<Map<String, dynamic>>> _loadListSafely(
    Future<List<Map<String, dynamic>>> Function() loader,
  ) async {
    try {
      return await loader();
    } catch (_) {
      return const [];
    }
  }

  Future<int> _loadUnreadCountSafely() async {
    try {
      return await NotificationApi.unreadCount();
    } catch (_) {
      return 0;
    }
  }

  void _searchCampaigns(String value) {
    final query = value.trim();
    setState(() => _search = query.toLowerCase());
    _searchDebounce?.cancel();
    if (query.isEmpty) {
      _loadHome();
      return;
    }
    _searchDebounce = Timer(const Duration(milliseconds: 350), () async {
      try {
        final campaigns = await SearchApi.campaigns(query);
        if (mounted && _search == query.toLowerCase()) {
          setState(() => _campaigns = campaigns);
        }
      } on ApiException catch (error) {
        if (mounted) setState(() => _homeError = error.message);
      }
    });
  }

  @override
  void dispose() {
    _searchDebounce?.cancel();
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
                    child: RefreshIndicator(
                      onRefresh: _loadHome,
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 16),

                            _buildTopBar(),

                            const SizedBox(height: 16),

                            _buildSearchBar(),

                            if (_homeError != null)
                              Padding(
                                padding: const EdgeInsets.all(16),
                                child: Text(
                                  _homeError!,
                                  style: const TextStyle(color: Colors.red),
                                ),
                              ),

                            const SizedBox(height: 16),

                            _buildBannerSlider(),

                            const SizedBox(height: 6),

                            _buildDotIndicators(),

                            const SizedBox(height: 16),

                            _buildActionCategories(),

                            const SizedBox(height: 24),

                            _buildSuggestCampaignSection(),

                            const SizedBox(height: 24),

                            _buildTrendingAudioSection(),

                            const SizedBox(height: 24),

                            _buildBrandInsights(),

                            const SizedBox(height: 36),

                            _buildFooterBlock(),

                            const SizedBox(height: 100),
                          ],
                        ),
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
                  text: 'SNAAPII',
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
                Icons.play_circle_outline,
                onTap: () {
                  if (_videos.isEmpty) return;
                  final video = _videos.first;
                  final url = HomeApi.mediaUrl(video['video_url']);
                  if (url == null) return;
                  Get.to(
                    () => VideoPlayerScreen(
                      title: video['title']?.toString() ?? 'Video',
                      duration: '0:00',
                      previewWidget: const SizedBox(),
                      videoUrl: url,
                    ),
                  );
                },
              ),
              const SizedBox(width: 8),
              _notificationButton(),
              const SizedBox(width: 8),
              _buildTopIconCircle(
                Icons.account_balance_wallet_outlined,
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

  Widget _buildTopIconCircle(IconData icon, {required VoidCallback onTap}) {
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
        child: Icon(icon, color: Colors.black, size: 20),
      ),
    );
  }

  Widget _notificationButton() => Stack(
    clipBehavior: Clip.none,
    children: [
      _buildTopIconCircle(
        Icons.notifications_none_outlined,
        onTap: () async {
          await Get.to(() => const NotificationsScreen());
          if (mounted) _loadHome();
        },
      ),
      if (_unreadNotifications > 0)
        Positioned(
          right: -2,
          top: -2,
          child: Container(
            constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
            padding: const EdgeInsets.symmetric(horizontal: 4),
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
            child: Text(
              _unreadNotifications > 9 ? '9+' : '$_unreadNotifications',
              style: const TextStyle(color: Colors.white, fontSize: 10),
            ),
          ),
        ),
    ],
  );

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
                onChanged: _searchCampaigns,
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

  Widget _buildBannerSlider() => HomeBanners(banners: _banners);

  Widget _buildDotIndicators() => const SizedBox.shrink();

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
            'assets/images/smart_dm_icon.png',
            'Smart Auto DM',
            onTap: () async {
              if (await InstagramAccessGate.requireConnection(
                'Smart Auto DM',
              )) {
                Get.to(() => const SmartAutoDmScreen());
              }
            },
          ),
          _buildActionItem(
            'assets/images/invite_earn_icon.png',
            'Invite & Earn',
            customPadding: const EdgeInsets.all(32),
            onTap: () => Get.to(() => const ReferEarnScreen()),
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

  Widget _buildSuggestCampaignSection() {
    final matchingCampaigns = _campaigns
        .where(
          (campaign) =>
              campaign['campaign_name']?.toString().toLowerCase().contains(
                    _search,
                  ) ==
                  true ||
              campaign['brand_name']?.toString().toLowerCase().contains(
                    _search,
                  ) ==
                  true,
        )
        .take(3);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Suggested campaigns',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          if (matchingCampaigns.isEmpty)
            Container(
              height: 100,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: const Color(0xFFF9F8FF),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                _search.isEmpty
                    ? 'No approved campaigns available yet.'
                    : 'No matching campaigns.',
              ),
            )
          else
            ...matchingCampaigns.map((campaign) {
              final imageUrl = HomeApi.mediaUrl(campaign['campaign_image']);
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () => Get.to(
                    () => CampaignDetailsScreen(
                      brandName: campaign['brand_name']?.toString(),
                      campaignId: int.tryParse(
                        (campaign['campaign_id'] ?? campaign['id'] ?? '')
                            .toString(),
                      ),
                      category: campaign['influencer_category']?.toString(),
                      imagePath: imageUrl ?? '',
                      followers: campaign['minimum_followers']?.toString(),
                      reel: campaign['reels']?.toString(),
                      story: campaign['stories']?.toString(),
                      post: campaign['posts']?.toString(),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (imageUrl != null)
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              imageUrl,
                              height: 150,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              errorBuilder: (_, _, _) =>
                                  const SizedBox.shrink(),
                            ),
                          ),
                        const SizedBox(height: 8),
                        Text(
                          campaign['campaign_name']?.toString() ?? 'Campaign',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(campaign['brand_name']?.toString() ?? 'Brand'),
                        Text(
                          'Category: ${campaign['influencer_category'] ?? '—'}',
                        ),
                        Text(
                          'Minimum followers: ${campaign['minimum_followers'] ?? '—'}',
                        ),
                        Text(
                          'Budget per influencer: ₹${campaign['budget_per_influencer'] ?? '—'}',
                        ),
                        const Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            'View details',
                            style: TextStyle(color: Color(0xFF7A58FF)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
        ],
      ),
    );
  }

  Widget _buildTrendingAudioSection() {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Instagram Trending Audio',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextButton.icon(
                  onPressed: () => Get.to(() => const AudioScreen()),
                  icon: const Text(
                    'View all',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 12,
                      color: Color(0xFF6B4EFF),
                    ),
                  ),
                  label: const Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 13,
                    color: Color(0xFF6B4EFF),
                  ),
                  iconAlignment: IconAlignment.end,
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          if (_trendingAudios.isEmpty)
            Container(
              height: 100,
              margin: const EdgeInsets.only(right: 16),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: const Color(0xFFF8F6FF),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFE6DFFF)),
              ),
              child: const Text(
                'No trending audio available yet.',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 12,
                  color: Color(0xFF6B7280),
                ),
              ),
            )
          else
            SizedBox(
              height: 164,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.only(right: 16),
                itemCount: _trendingAudios.length > 4
                    ? 4
                    : _trendingAudios.length,
                separatorBuilder: (context, index) => const SizedBox(width: 12),
                itemBuilder: (context, index) =>
                    _buildTrendingAudioCard(_trendingAudios[index]),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTrendingAudioCard(Map<String, dynamic> audio) {
    final coverUrl = HomeApi.mediaUrl(audio['cover_image_url']);
    final song = audio['song_name']?.toString().trim();
    final singer = audio['singer_name']?.toString().trim();
    return GestureDetector(
      onTap: () => Get.to(() => const AudioScreen()),
      child: Container(
        width: 172,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFFF8F6FF),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE6DFFF)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: SizedBox(
                width: 56,
                height: 56,
                child: coverUrl == null
                    ? const ColoredBox(
                        color: Color(0xFFE9E3FF),
                        child: Icon(
                          Icons.music_note_rounded,
                          color: Color(0xFF6B4EFF),
                        ),
                      )
                    : Image.network(
                        coverUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const ColoredBox(
                              color: Color(0xFFE9E3FF),
                              child: Icon(
                                Icons.music_note_rounded,
                                color: Color(0xFF6B4EFF),
                              ),
                            ),
                      ),
              ),
            ),
            const SizedBox(width: 9),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.music_note_rounded,
                    size: 18,
                    color: Color(0xFF1E1A34),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    song == null || song.isEmpty ? 'Trending audio' : song,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1E1A34),
                    ),
                  ),
                  if (singer != null && singer.isNotEmpty)
                    Text(
                      singer,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 10,
                        color: Color(0xFF6B7280),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBrandInsights() => HomeVideos(
    heading: 'Growth Tips',
    videos: _videos
        .where(
          (video) =>
              video['title']?.toString().toLowerCase().contains(_search) ??
              false,
        )
        .toList(),
  );

  Widget _buildFooterBlock() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: const Text(
              'Everything a Creator\nNeeds. 🚀',
              style: TextStyle(
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
              onTap: () => Get.to(() => const ExploreScreen()),
              child: _buildNavIcon(
                'assets/images/explore_icon.png',
                isActive: _selectedTabIndex == 1,
                width: 22,
                height: 20,
              ),
            ),
            GestureDetector(
              onTap: () => Get.to(() => const AiScreen()),
              child: _buildNavIcon(
                'assets/images/ai_icon.png',
                isActive: _selectedTabIndex == 2,
                width: 24,
                height: 20,
              ),
            ),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => Get.to(() => const CreatorChatScreen()),
              child: _buildNavIcon(
                'assets/images/message_icon.png',
                isActive: _selectedTabIndex == 3,
                width: 21,
                height: 20,
              ),
            ),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => Get.to(() => const CreatorProfileScreen()),
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
