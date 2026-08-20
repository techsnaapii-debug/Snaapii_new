import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../brand/ai/ai_screen.dart';
import '../brand/my_campaign/home_screen.dart';
import 'campaign_details_screen.dart';
import 'creator_chat_screen.dart';
import 'creator_profile_screen.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  int _selectedTabIndex = 1;
  int _currentCardIndex = 0;
  int _activeActionButtonIndex = 1;
  bool _isLiked = false;
  bool _isBookmarked = false;
  final PageController _cardPageController = PageController(
    viewportFraction: 0.85,
    initialPage: 0,
  );

  final List<Map<String, String>> _exploreCards = [
    {
      'brand': 'Gucci',
      'category': 'Lifestyle',
      'followers': '10K',
      'reel': 'Reel 2',
      'story': 'Story 1',
      'post': 'Post 1',
      'image': 'assets/images/bancy.png',
    },
    {
      'brand': 'Prada',
      'category': 'Fashion',
      'followers': '25K',
      'reel': 'Reel 3',
      'story': 'Story 2',
      'post': 'Post 2',
      'image': 'assets/images/banner_2.jpg',
    },
    {
      'brand': 'Chanel',
      'category': 'Beauty',
      'followers': '50K',
      'reel': 'Reel 1',
      'story': 'Story 3',
      'post': 'Post 1',
      'image': 'assets/images/banner_3.jpg',
    },
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _cardPageController.dispose();
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
                    child: Column(
                      children: [
                        const SizedBox(height: 8),

                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20.0,
                            vertical: 6.0,
                          ),
                          child: Row(
                            children: [
                              const Text(
                                'Explore',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF6B4EFF),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 8),

                        const Center(
                          child: Text(
                            'Find inspiring content tailored for you',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 13.5,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF1E1A34),
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        Expanded(
                          child: Center(
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  _buildCardDeck(),

                                  const SizedBox(height: 24),

                                  _buildActionPill(),
                                ],
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 90),
                      ],
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

  Widget _buildCardDeck() {
    return SizedBox(
      height: 390,
      child: PageView.builder(
        controller: _cardPageController,
        itemCount: _exploreCards.length,
        physics: const BouncingScrollPhysics(),
        onPageChanged: (index) {
          setState(() {
            _currentCardIndex = index;
          });
        },
        itemBuilder: (context, index) {
          final cardData = _exploreCards[index];
          return AnimatedBuilder(
            animation: _cardPageController,
            builder: (context, child) {
              double value = 1.0;
              if (_cardPageController.position.haveDimensions) {
                value = _cardPageController.page! - index;
                value = (1 - (value.abs() * 0.15)).clamp(0.85, 1.0);
              } else {
                value = index == _currentCardIndex ? 1.0 : 0.85;
              }
              return Center(
                child: SizedBox(height: value * 380, width: 325, child: child),
              );
            },
            child: _buildExploreCardItem(cardData),
          );
        },
      ),
    );
  }

  Widget _buildExploreCardItem(Map<String, String> cardData) {
    return GestureDetector(
      onTap: () {
        Get.to(
          () => CampaignDetailsScreen(
            brandName: cardData['brand'],
            category: cardData['category'],
            imagePath: cardData['image'],
            followers: cardData['followers'],
            reel: cardData['reel'],
            story: cardData['story'],
            post: cardData['post'],
          ),
        );
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF9E8EFE).withValues(alpha: 0.25),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  cardData['image']!,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: const Color(0xFFDCD6CD),
                      child: const Center(
                        child: Icon(
                          Icons.person,
                          size: 80,
                          color: Colors.white54,
                        ),
                      ),
                    );
                  },
                ),
              ),

              Positioned(
                top: 14,
                right: 14,
                child: GestureDetector(
                  onTap: () {
                    Get.to(
                      () => CampaignDetailsScreen(
                        brandName: cardData['brand'],
                        category: cardData['category'],
                        imagePath: cardData['image'],
                        followers: cardData['followers'],
                        reel: cardData['reel'],
                        story: cardData['story'],
                        post: cardData['post'],
                      ),
                    );
                  },
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      'Read more',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),

              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.transparent,
                        Colors.black.withValues(alpha: 0.7),
                        Colors.black.withValues(alpha: 0.95),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Text(
                            cardData['brand']!,
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Flexible(
                            child: Text(
                              'Category : ${cardData['category']!}',
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 13.5,
                                fontWeight: FontWeight.w500,
                                color: Colors.white70,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 6),
                            child: Text(
                              '|',
                              style: TextStyle(
                                fontSize: 22,
                                color: Colors.white54,
                              ),
                            ),
                          ),
                          const Icon(
                            Icons.person,
                            size: 18,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 3),
                          Text(
                            cardData['followers']!,
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 13.5,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),

                      Row(
                        children: [
                          const Icon(
                            Icons.movie_outlined,
                            size: 17,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            cardData['reel']!,
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 13.5,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              '|',
                              style: TextStyle(
                                fontSize: 22,
                                color: Colors.white54,
                              ),
                            ),
                          ),
                          const Icon(
                            Icons.play_circle_outline,
                            size: 17,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            cardData['story']!,
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 13.5,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              '|',
                              style: TextStyle(
                                fontSize: 22,
                                color: Colors.white54,
                              ),
                            ),
                          ),
                          Image.asset(
                            'assets/images/instagram_icon.png',
                            width: 17,
                            height: 17,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            cardData['post']!,
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 13.5,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ],
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

  Widget _buildActionPill() {
    return Container(
      width: 230,
      height: 56,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: const Color(0xFFEBE8FC), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildPillItem(
            index: 0,
            icon: Icon(
              _isBookmarked ? Icons.bookmark : Icons.bookmark_border,
              color: const Color(0xFF9E8EFE),
              size: 24,
            ),
            onTap: () {
              setState(() {
                _activeActionButtonIndex = 0;
                _isBookmarked = !_isBookmarked;
              });
            },
          ),

          _buildPillItem(
            index: 1,
            icon: Icon(
              _isLiked ? Icons.favorite : Icons.favorite_border,
              color: const Color(0xFF9E8EFE),
              size: 22,
            ),
            onTap: () {
              setState(() {
                _activeActionButtonIndex = 1;
                _isLiked = !_isLiked;
              });
            },
          ),

          _buildPillItem(
            index: 2,
            icon: Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(3.14159),
              child: const Icon(
                Icons.reply_rounded,
                color: Color(0xFF9E8EFE),
                size: 24,
              ),
            ),
            onTap: () {
              setState(() {
                _activeActionButtonIndex = 2;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPillItem({
    required int index,
    required Widget icon,
    required VoidCallback onTap,
  }) {
    final bool isActive = _activeActionButtonIndex == index;
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFFF0EAFF) : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Center(child: icon),
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
              onTap: () => Get.offAll(() => const HomeScreen(isCreator: true)),
              child: _buildNavIcon(
                'assets/images/home_icon.png',
                isActive: _selectedTabIndex == 0,
                width: 20,
                height: 20,
              ),
            ),
            GestureDetector(
              onTap: () => setState(() => _selectedTabIndex = 1),
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
