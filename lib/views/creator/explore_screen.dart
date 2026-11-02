import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:snaapii/widgets/creator_widget/creator_bottom_nav_bar.dart';
import 'package:snaapii/widgets/creator_widget/explore_action_pill.dart';
import 'package:snaapii/widgets/creator_widget/explore_card_item.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
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

                                  ExploreActionPill(
                                    activeIndex: _activeActionButtonIndex,
                                    isBookmarked: _isBookmarked,
                                    isLiked: _isLiked,
                                    onBookmarkTap: () {
                                      setState(() {
                                        _activeActionButtonIndex = 0;
                                        _isBookmarked = !_isBookmarked;
                                      });
                                    },
                                    onLikeTap: () {
                                      setState(() {
                                        _activeActionButtonIndex = 1;
                                        _isLiked = !_isLiked;
                                      });
                                    },
                                    onShareTap: () {
                                      setState(() {
                                        _activeActionButtonIndex = 2;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 90),
                      ],
                    ),
                  ),

                  const CreatorBottomNavBar(selectedTabIndex: 1),
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
            child: ExploreCardItem(cardData: cardData),
          );
        },
      ),
    );
  }


}


