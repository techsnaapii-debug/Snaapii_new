import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'media_kit_preview_screen.dart';

class MediaKitTemplateScreen extends StatefulWidget {
  const MediaKitTemplateScreen({super.key});

  @override
  State<MediaKitTemplateScreen> createState() => _MediaKitTemplateScreenState();
}

class _MediaKitTemplateScreenState extends State<MediaKitTemplateScreen> {
  int _selectedCategoryIndex = 0;
  int _selectedTemplateIndex = -1; // Initially all unchosen until user selects one

  final List<String> _categories = ['All', 'Simple', 'Creative'];

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
            crossAxisAlignment: CrossAxisAlignment.start,
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
                      const SizedBox(height: 8),

                      // Title & Subtitle
                      const Text(
                        'Choose a Template',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Select a template that matches your style.',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Category Filter Chips
                      Row(
                        children: List.generate(_categories.length, (index) {
                          final isSelected = _selectedCategoryIndex == index;
                          return Padding(
                            padding: const EdgeInsets.only(right: 12.0),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedCategoryIndex = index;
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 22,
                                  vertical: 7,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: isSelected
                                      ? const Color(0xFF7C3AED)
                                      : const Color(0xFFF3E8FF),
                                ),
                                child: Text(
                                  _categories[index],
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: isSelected
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                      ),

                      const SizedBox(height: 20),

                      // Template Cards List
                      _buildTemplateCard(
                        index: 0,
                        child: _buildTemplate1(),
                      ),
                      const SizedBox(height: 18),

                      _buildTemplateCard(
                        index: 1,
                        child: _buildTemplate2(),
                      ),
                      const SizedBox(height: 18),

                      _buildTemplateCard(
                        index: 2,
                        child: _buildTemplate3(),
                      ),
                      const SizedBox(height: 18),

                      _buildTemplateCard(
                        index: 3,
                        child: _buildTemplate4(),
                      ),
                      const SizedBox(height: 18),

                      _buildTemplateCard(
                        index: 4,
                        child: _buildTemplate5(),
                      ),

                      const SizedBox(height: 90), // Spacing for bottom button
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),

        // Bottom Button: Preview & Download (lifted up)
        bottomNavigationBar: Container(
          color: Colors.white,
          padding: const EdgeInsets.only(
            left: 24.0,
            right: 24.0,
            top: 12.0,
            bottom: 28.0,
          ),
          child: SafeArea(
            top: false,
            child: GestureDetector(
              onTap: () {
                if (_selectedTemplateIndex != -1) {
                  Get.to(
                    () => MediaKitPreviewScreen(
                      selectedTemplateIndex: _selectedTemplateIndex,
                    ),
                  );
                } else {
                  Get.snackbar(
                    'Notice',
                    'Please select one template',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.black,
                    colorText: Colors.white,
                    duration: const Duration(seconds: 2),
                    margin: const EdgeInsets.all(16),
                    borderRadius: 12,
                  );
                }
              },
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
                      color: const Color(0xFF5667FF).withValues(alpha: 0.35),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: const Center(
                  child: Text(
                    'Preview & Download',
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
          ),
        ),
      ),
    );
  }

  Widget _buildTemplateCard({required int index, required Widget child}) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTemplateIndex = index;
        });
      },
      child: child,
    );
  }

  Widget _buildRadioIndicator(bool isSelected, {bool isDark = false}) {
    return Container(
      width: 22,
      height: 22,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isSelected ? const Color(0xFF2E24E6) : Colors.transparent,
        border: isSelected
            ? null
            : Border.all(
                color: isDark
                    ? Colors.white70
                    : const Color(0xFF6B4EFF),
                width: 1.8,
              ),
      ),
      child: isSelected
          ? const Center(
              child: Icon(
                Icons.check,
                color: Colors.white,
                size: 14,
              ),
            )
          : null,
    );
  }

  // Template 1: Minimal White Clean
  Widget _buildTemplate1() {
    final isSelected = _selectedTemplateIndex == 0;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isSelected
              ? const Color(0xFF6B4EFF)
              : const Color(0xFFE5E7EB),
          width: isSelected ? 2.0 : 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: _buildRadioIndicator(isSelected),
          ),
          // Avatar
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
            ),
            child: ClipOval(
              child: Image.asset(
                'assets/images/user_avatar.png',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => const CircleAvatar(
                  backgroundColor: Color(0xFF10B981),
                  child: Icon(Icons.person, color: Colors.white),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'aldrina badss',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          const Text(
            '@aldrina badss',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 10,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
          const Text(
            'Lifestyle | fashion',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 9,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 14),

          // 3 Columns Stats (Row 1)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              _StatItem(value: '33K', label: 'Followers', textColor: Colors.black),
              _StatItem(value: '3.9%', label: 'Engagement', textColor: Colors.black),
              _StatItem(value: '446K', label: 'Avg. views', textColor: Colors.black),
            ],
          ),
          const SizedBox(height: 10),

          // 3 Columns Stats (Row 2)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              _StatItem(value: '70K', label: 'Average Like', textColor: Colors.black),
              _StatItem(value: '4450', label: 'Average Comments', textColor: Colors.black),
              _StatItem(value: '446K', label: 'Share', textColor: Colors.black),
            ],
          ),
          const SizedBox(height: 14),

          // Divider
          const Divider(color: Color(0xFFE5E7EB), thickness: 1),
          const SizedBox(height: 6),

          // Pricing Row with dividers
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              _PriceItem(label: 'Per Reel', price: '₹70K', textColor: Colors.black),
              _VerticalLine(color: Color(0xFFE5E7EB)),
              _PriceItem(label: 'Per Story', price: '₹70K', textColor: Colors.black),
              _VerticalLine(color: Color(0xFFE5E7EB)),
              _PriceItem(label: 'Per Post', price: '₹70K', textColor: Colors.black),
            ],
          ),
        ],
      ),
    );
  }

  // Template 2: Minimal Black Clean
  Widget _buildTemplate2() {
    final isSelected = _selectedTemplateIndex == 1;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF0F0F13),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isSelected ? const Color(0xFF6B4EFF) : Colors.white24,
          width: isSelected ? 2.0 : 1.0,
        ),
      ),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: _buildRadioIndicator(isSelected, isDark: true),
          ),
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
            ),
            child: ClipOval(
              child: Image.asset(
                'assets/images/user_avatar.png',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => const CircleAvatar(
                  backgroundColor: Color(0xFF10B981),
                  child: Icon(Icons.person, color: Colors.white),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'aldrina badss',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          const Text(
            '@aldrina badss',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 10,
              fontWeight: FontWeight.w400,
              color: Colors.white70,
            ),
          ),
          const Text(
            'Lifestyle | fashion',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 9,
              fontWeight: FontWeight.w500,
              color: Colors.white70,
            ),
          ),
          const SizedBox(height: 14),

          // 3 Columns Stats (Row 1)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              _StatItem(value: '33K', label: 'Followers', textColor: Colors.white),
              _StatItem(value: '3.9%', label: 'Engagement', textColor: Colors.white),
              _StatItem(value: '446K', label: 'Avg. views', textColor: Colors.white),
            ],
          ),
          const SizedBox(height: 10),

          // 3 Columns Stats (Row 2)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              _StatItem(value: '70K', label: 'Average Like', textColor: Colors.white),
              _StatItem(value: '4450', label: 'Average Comments', textColor: Colors.white),
              _StatItem(value: '446K', label: 'Share', textColor: Colors.white),
            ],
          ),
          const SizedBox(height: 14),

          const Divider(color: Colors.white24, thickness: 1),
          const SizedBox(height: 6),

          // Pricing Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              _PriceItem(label: 'Per Reel', price: '₹70K', textColor: Colors.white),
              _VerticalLine(color: Colors.white24),
              _PriceItem(label: 'Per Story', price: '₹70K', textColor: Colors.white),
              _VerticalLine(color: Colors.white24),
              _PriceItem(label: 'Per Post', price: '₹70K', textColor: Colors.white),
            ],
          ),
        ],
      ),
    );
  }

  // Template 3: Dark with Left Large Avatar & Boxed Stats
  Widget _buildTemplate3() {
    final isSelected = _selectedTemplateIndex == 2;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF0F0F13),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isSelected ? const Color(0xFF6B4EFF) : Colors.white24,
          width: isSelected ? 2.0 : 1.0,
        ),
      ),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: _buildRadioIndicator(isSelected, isDark: true),
          ),
          const SizedBox(height: 4),

          // Top Row: Big Avatar + Info
          Row(
            children: [
              Container(
                width: 90,
                height: 90,
                decoration: const BoxDecoration(shape: BoxShape.circle),
                child: ClipOval(
                  child: Image.asset(
                    'assets/images/user_avatar.png',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => const CircleAvatar(
                      backgroundColor: Color(0xFF10B981),
                      child: Icon(Icons.person, color: Colors.white, size: 40),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'aldrina badss',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      '@aldrina badss',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 10,
                        color: Colors.white70,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'Lifestyle | fashion',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 9,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Boxed Stats Container
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white24, width: 1),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    _StatItem(value: '33K', label: 'Followers', textColor: Colors.white),
                    _StatItem(value: '3.9%', label: 'Engagement', textColor: Colors.white),
                    _StatItem(value: '446K', label: 'Avg. views', textColor: Colors.white),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    _StatItem(value: '70K', label: 'Average Like', textColor: Colors.white),
                    _StatItem(value: '4450', label: 'Average Comments', textColor: Colors.white),
                    _StatItem(value: '95', label: 'Share', textColor: Colors.white),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),

          // Pricing Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              _PriceItem(label: 'Per Reel', price: '₹70K', textColor: Colors.white),
              _VerticalLine(color: Colors.white24),
              _PriceItem(label: 'Per Story', price: '₹70K', textColor: Colors.white),
              _VerticalLine(color: Colors.white24),
              _PriceItem(label: 'Per Post', price: '₹70K', textColor: Colors.white),
            ],
          ),
        ],
      ),
    );
  }

  // Template 4: Dark with Rectangular Girl Photo on Right
  Widget _buildTemplate4() {
    final isSelected = _selectedTemplateIndex == 3;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF0F0F13),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isSelected ? const Color(0xFF6B4EFF) : Colors.white24,
          width: isSelected ? 2.0 : 1.0,
        ),
      ),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: _buildRadioIndicator(isSelected, isDark: true),
          ),
          const SizedBox(height: 4),

          // Top Row: Text Left + Rectangular Photo Right
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'aldrina badss',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      '@aldrina badss',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 10,
                        color: Colors.white70,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'Lifestyle | fashion',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 9,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  'assets/images/girl_image.png',
                  width: 95,
                  height: 95,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => const CircleAvatar(
                    backgroundColor: Color(0xFF10B981),
                    child: Icon(Icons.person, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Stats with Dividers
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              _StatItem(value: '33K', label: 'Followers', textColor: Colors.white),
              _VerticalLine(color: Colors.white24),
              _StatItem(value: '3.9%', label: 'Engagement', textColor: Colors.white),
              _VerticalLine(color: Colors.white24),
              _StatItem(value: '446K', label: 'Avg. views', textColor: Colors.white),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              _StatItem(value: '70K', label: 'Average Like', textColor: Colors.white),
              _VerticalLine(color: Colors.white24),
              _StatItem(value: '4450', label: 'Average Comments', textColor: Colors.white),
              _VerticalLine(color: Colors.white24),
              _StatItem(value: '95', label: 'Share', textColor: Colors.white),
            ],
          ),
          const SizedBox(height: 14),

          const Divider(color: Colors.white24, thickness: 1),
          const SizedBox(height: 6),

          // Pricing Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              _PriceItem(label: 'Per Reel', price: '₹70K', textColor: Colors.white),
              _VerticalLine(color: Colors.white24),
              _PriceItem(label: 'Per Story', price: '₹70K', textColor: Colors.white),
              _VerticalLine(color: Colors.white24),
              _PriceItem(label: 'Per Post', price: '₹70K', textColor: Colors.white),
            ],
          ),
        ],
      ),
    );
  }

  // Template 5: Vibrant Purple Card (Aarohi Sharma - Selected)
  Widget _buildTemplate5() {
    final isSelected = _selectedTemplateIndex == 4;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF6B4EFF),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isSelected ? Colors.white : Colors.transparent,
          width: 2.0,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6B4EFF).withValues(alpha: 0.35),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: _buildRadioIndicator(isSelected, isDark: true),
          ),
          const SizedBox(height: 4),

          // Top Row: Big Aarohi Sharma Text + Image Right
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Aarohi\nSharma',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        height: 1.15,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '@aarohisharma',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 10,
                        color: Colors.white70,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'Lifestyle | fashion',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 9,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  'assets/images/girl_image.png',
                  width: 95,
                  height: 95,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => const CircleAvatar(
                    backgroundColor: Colors.white24,
                    child: Icon(Icons.person, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Stats with Dividers
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              _StatItem(value: '33K', label: 'Followers', textColor: Colors.white),
              _VerticalLine(color: Colors.white24),
              _StatItem(value: '3.9%', label: 'Engagement', textColor: Colors.white),
              _VerticalLine(color: Colors.white24),
              _StatItem(value: '446K', label: 'Avg. views', textColor: Colors.white),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              _StatItem(value: '70K', label: 'Average Like', textColor: Colors.white),
              _VerticalLine(color: Colors.white24),
              _StatItem(value: '4450', label: 'Average Comments', textColor: Colors.white),
              _VerticalLine(color: Colors.white24),
              _StatItem(value: '95', label: 'Share', textColor: Colors.white),
            ],
          ),
          const SizedBox(height: 14),

          const Divider(color: Colors.white24, thickness: 1),
          const SizedBox(height: 6),

          // Pricing Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              _PriceItem(label: 'Per Reel', price: '₹70K', textColor: Colors.white),
              _VerticalLine(color: Colors.white24),
              _PriceItem(label: 'Per Story', price: '₹70K', textColor: Colors.white),
              _VerticalLine(color: Colors.white24),
              _PriceItem(label: 'Per Post', price: '₹70K', textColor: Colors.white),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String value;
  final String label;
  final Color textColor;

  const _StatItem({
    required this.value,
    required this.label,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: textColor,
          ),
        ),
        const SizedBox(height: 1),
        Text(
          label,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 7.5,
            fontWeight: FontWeight.w500,
            color: textColor == Colors.white ? Colors.white70 : Colors.black,
          ),
        ),
      ],
    );
  }
}

class _PriceItem extends StatelessWidget {
  final String label;
  final String price;
  final Color textColor;

  const _PriceItem({
    required this.label,
    required this.price,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 8,
            fontWeight: FontWeight.w500,
            color: textColor == Colors.white ? Colors.white70 : Colors.black,
          ),
        ),
        const SizedBox(height: 1),
        Text(
          price,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 10,
            fontWeight: FontWeight.w700,
            color: textColor,
          ),
        ),
      ],
    );
  }
}

class _VerticalLine extends StatelessWidget {
  final Color color;

  const _VerticalLine({required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 24,
      color: color,
    );
  }
}
