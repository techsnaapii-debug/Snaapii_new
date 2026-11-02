import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class Article2Screen extends StatefulWidget {
  const Article2Screen({super.key});

  @override
  State<Article2Screen> createState() => _Article2ScreenState();
}

class _Article2ScreenState extends State<Article2Screen> {
  bool? _isHelpful;

  final List<Map<String, dynamic>> _relatedArticles = [
    {
      'title': '5 Ways to Improve\nYour Reel Reach',
      'tag': 'Brand deals',
      'readTime': '4 min read',
      'likes': 23,
      'image': 'assets/images/bancy.png',
    },
    {
      'title': '5 Ways to Improve\nYour Reel Reach',
      'tag': 'Brand deals',
      'readTime': '4 min read',
      'likes': 23,
      'image': 'assets/images/bancy.png',
    },
    {
      'title': '5 Ways to Improve\nYour Reel Reach',
      'tag': 'Brand deals',
      'readTime': '4 min read',
      'likes': 23,
      'image': 'assets/images/bancy.png',
    },
  ];

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
                      _buildHeaderImage(),
                      const SizedBox(height: 14),
                      _buildMetaRow(),
                      const SizedBox(height: 14),
                      _buildArticleTitle(),
                      const SizedBox(height: 16),
                      _buildArticleContent(),
                      const SizedBox(height: 24),
                      _buildFeedbackSection(),
                      const SizedBox(height: 28),
                      _buildRelatedArticlesSection(),
                      const SizedBox(height: 28),
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

  Widget _buildHeaderImage() {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.asset(
          'assets/images/bancy.png',
          width: double.infinity,
          height: 200,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: const Color(0xFFF3EDFF),
              child: const Center(
                child: Icon(Icons.image, color: Color(0xFF8B5CF6), size: 40),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildMetaRow() {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: const Color(0xFFF3EDFF),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Text(
            'Brand deals',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 10,
              fontWeight: FontWeight.w500,
              color: Color(0xFF8B5CF6),
            ),
          ),
        ),
        const SizedBox(width: 20),
        Row(
          children: const [
            Icon(Icons.favorite_border, size: 14, color: Colors.black87),
            SizedBox(width: 4),
            Text(
              '23',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
        const SizedBox(width: 20),
        Row(
          children: const [
            Icon(Icons.access_time, size: 14, color: Colors.black54),
            SizedBox(width: 4),
            Text(
              '4 min read',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 10,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildArticleTitle() {
    return const Text(
      'How to Get Your First\nBrand collaboration',
      style: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.black,
        height: 1.25,
      ),
    );
  }

  Widget _buildArticleContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Getting your first brand collaboration can feel difficult when you're still growing as a creator. The good news is that brands don't only look at follower count—they also consider your content quality, audience, engagement, niche, and professionalism.",
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 12.5,
            color: Colors.black87,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 14),
        _buildSectionHeader('1. Choose Your Creator Niche'),
        const SizedBox(height: 6),
        const Text(
          'Start by making it clear what type of content you create.',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 12.5,
            color: Colors.black87,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Examples:\n'
          '• Fashion\n'
          '• Beauty\n'
          '• Technology\n'
          '• Fitness\n'
          '• Food\n'
          '• Travel\n'
          '• Gaming\n'
          '• Lifestyle\n'
          '• Education',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 12,
            color: Colors.black87,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'A clear niche helps brands understand whether your audience matches their product.',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 12.5,
            color: Colors.black87,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 16),
        _buildSectionHeader('2. Build a Strong Profile'),
        const SizedBox(height: 6),
        const Text(
          'Before approaching brands, make sure your Instagram profile is collaboration-ready.',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 12.5,
            color: Colors.black87,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Make sure you have:\n'
          '• A clear profile photo\n'
          '• A simple and professional bio\n'
          '• Your content category mentioned\n'
          '• Contact information\n'
          '• Consistent content\n'
          '• Your best work visible on your profile',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 12,
            color: Colors.black87,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Your profile should quickly tell a brand who you are, what you create, and who your content is for.',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 12.5,
            color: Colors.black87,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 16),
        _buildSectionHeader('3. Focus on Content Quality'),
        const SizedBox(height: 6),
        const Text(
          "You don't need thousands of followers to start.",
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 12.5,
            color: Colors.black87,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Create content that demonstrates:\n'
          '• Good storytelling\n'
          '• Clear visuals\n'
          '• Useful information or entertainment\n'
          '• Strong hooks\n'
          '• Consistent posting\n'
          '• Your unique personality',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 12,
            color: Colors.black87,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Your existing content can become your portfolio.',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 12.5,
            color: Colors.black87,
            height: 1.4,
          ),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontFamily: 'Poppins',
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    );
  }

  Widget _buildFeedbackSection() {
    return Column(
      children: [
        const Center(
          child: Text(
            'Was this article helpful?',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _isHelpful = true;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: _isHelpful == true
                        ? const Color(0xFF6B4EFF)
                        : Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(
                      color: const Color(0xFFEBE8FC),
                      width: 1.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.04),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.thumb_up,
                        size: 18,
                        color: _isHelpful == true
                            ? Colors.white
                            : const Color(0xFF6B4EFF),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Yes',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: _isHelpful == true
                              ? Colors.white
                              : Colors.black,
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
                onTap: () {
                  setState(() {
                    _isHelpful = false;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: _isHelpful == false
                        ? const Color(0xFF6B4EFF)
                        : const Color(0xFFF3EDFF),
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(
                      color: const Color(0xFFEBE8FC),
                      width: 1.5,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.thumb_down,
                        size: 18,
                        color: _isHelpful == false
                            ? Colors.white
                            : const Color(0xFF6B4EFF),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'No',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: _isHelpful == false
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRelatedArticlesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Related Articles',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 12),
        Column(
          children: _relatedArticles.map((article) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: _buildRelatedArticleCard(article),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildRelatedArticleCard(Map<String, dynamic> article) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFEBE8FC), width: 1.2),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.horizontal(
              left: Radius.circular(14),
            ),
            child: Image.asset(
              article['image'],
              width: 100,
              height: 100,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 100,
                  height: 100,
                  color: const Color(0xFFF3EDFF),
                  child: const Center(
                    child: Icon(Icons.image, color: Color(0xFF8B5CF6)),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    article['title'],
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      height: 1.2,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
    );
  }
}
