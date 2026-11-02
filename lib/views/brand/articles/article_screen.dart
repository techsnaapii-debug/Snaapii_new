import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'article2_screen.dart';

class ArticleScreen extends StatefulWidget {
  const ArticleScreen({super.key});

  @override
  State<ArticleScreen> createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
  String _selectedCategory = 'All';

  final List<String> _categories = ['All', 'Growth', 'Brand Deals'];

  final List<Map<String, dynamic>> _allArticles = [
    {
      'title': '5 Ways to Improve\nYour Reel Reach',
      'tag': 'Creator Growth',
      'category': 'Growth',
      'readTime': '4 min read',
      'likes': 23,
      'image': 'assets/images/animate_girl.png',
    },
    {
      'title': '5 Ways to Improve\nYour Reel Reach',
      'tag': 'Creator Growth',
      'category': 'Growth',
      'readTime': '4 min read',
      'likes': 23,
      'image': 'assets/images/animate_girl.png',
    },
    {
      'title': '5 Ways to Improve\nYour Reel Reach',
      'tag': 'Creator Growth',
      'category': 'Growth',
      'readTime': '4 min read',
      'likes': 23,
      'image': 'assets/images/animate_girl.png',
    },
    {
      'title': '5 Ways to Improve\nYour Reel Reach',
      'tag': 'Creator Growth',
      'category': 'Growth',
      'readTime': '4 min read',
      'likes': 23,
      'image': 'assets/images/animate_girl.png',
    },
    {
      'title': 'How to Negotiate\nBrand Deals',
      'tag': 'Brand Deals',
      'category': 'Brand Deals',
      'readTime': '5 min read',
      'likes': 45,
      'image': 'assets/images/animate_girl.png',
    },
    {
      'title': 'Securing Long-Term\nBrand Sponsorships',
      'tag': 'Brand Deals',
      'category': 'Brand Deals',
      'readTime': '6 min read',
      'likes': 52,
      'image': 'assets/images/animate_girl.png',
    },
    {
      'title': 'Brand Collaboration\nMasterclass',
      'tag': 'Brand Deals',
      'category': 'Brand Deals',
      'readTime': '4 min read',
      'likes': 38,
      'image': 'assets/images/animate_girl.png',
    },
    {
      'title': 'Pitching to Top\nGlobal Brands',
      'tag': 'Brand Deals',
      'category': 'Brand Deals',
      'readTime': '5 min read',
      'likes': 61,
      'image': 'assets/images/animate_girl.png',
    },
  ];

  List<Map<String, dynamic>> get _filteredArticles {
    if (_selectedCategory == 'Growth') {
      return _allArticles
          .where((article) => article['category'] == 'Growth')
          .take(4)
          .toList();
    } else if (_selectedCategory == 'Brand Deals') {
      return _allArticles
          .where((article) => article['category'] == 'Brand Deals')
          .take(4)
          .toList();
    }
    return _allArticles.take(4).toList();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: SafeArea(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 12),
                      _buildHeader(),
                      const SizedBox(height: 16),
                      _buildMainHeading(),
                      const SizedBox(height: 16),
                      _buildHeroCard(),
                      const SizedBox(height: 20),
                      _buildCategoryFilters(),
                      const SizedBox(height: 20),
                      _buildArticlesGrid(),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        GestureDetector(
          onTap: () => Get.back(),
          child: const Icon(
            Icons.arrow_back_ios_new,
            color: Color(0xFF6B4EFF),
            size: 20,
          ),
        ),
        const SizedBox(width: 8),
        const Text(
          'Articles',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: Color(0xFF6B4EFF),
          ),
        ),
      ],
    );
  }

  Widget _buildMainHeading() {
    return const Text(
      'Learn. Grow. Earn',
      style: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    );
  }

  Widget _buildHeroCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          colors: [Color(0xFF6B4EFF), Color(0xFFE5D9FF)],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'How to Get\nYour First Brand\ncollaboration',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              height: 1.25,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'A compete guide for new\ncretors to start earning\nwith brands',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Colors.white70,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 16),
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () => Get.to(() => const Article2Screen()),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text(
                      'Read Article',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF7C5CFF),
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(Icons.arrow_forward, color: Color(0xFF7C5CFF), size: 18),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryFilters() {
    return SizedBox(
      height: 40,
      child: Row(
        children: _categories.map((category) {
          final bool isSelected = _selectedCategory == category;
          return Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                if (_selectedCategory != category) {
                  setState(() {
                    _selectedCategory = category;
                  });
                }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? const Color(0xFF8B5CF6)
                      : const Color(0xFFF3EDFF),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Text(
                  category,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: isSelected ? Colors.white : Colors.black87,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildArticlesGrid() {
    final articles = _filteredArticles;

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 240,
                child: _buildArticleCard(articles[0]),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: SizedBox(
                height: 240,
                child: _buildArticleCard(articles[1]),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 240,
                child: _buildArticleCard(articles[2]),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: SizedBox(
                height: 240,
                child: _buildArticleCard(articles[3]),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildArticleCard(Map<String, dynamic> article) {
    return GestureDetector(
      onTap: () => Get.to(() => const Article2Screen()),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFEBE8FC), width: 1.2),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 58,
                child: Image.asset(
                  article['image'],
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: const Color(0xFFF3EDFF),
                      child: const Center(
                        child: Icon(Icons.image, color: Color(0xFF8B5CF6)),
                      ),
                    );
                  },
                ),
              ),
              Expanded(
                flex: 42,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 8.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        article['title'],
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 11.5,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 7,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF3EDFF),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          article['tag'],
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 8.5,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF8B5CF6),
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.access_time,
                                size: 12,
                                color: Colors.black54,
                              ),
                              const SizedBox(width: 3),
                              Text(
                                article['readTime'],
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 8.5,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 16),
                          Row(
                            children: [
                              const Icon(
                                Icons.favorite_border,
                                size: 12,
                                color: Colors.black87,
                              ),
                              const SizedBox(width: 3),
                              Text(
                                '${article['likes']}',
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 9.5,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
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
}
