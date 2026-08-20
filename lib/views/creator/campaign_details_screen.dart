import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../widgets/custom_button.dart';

class CampaignDetailsScreen extends StatefulWidget {
  final String? brandName;
  final String? category;
  final String? imagePath;
  final String? followers;
  final String? reel;
  final String? story;
  final String? post;

  const CampaignDetailsScreen({
    super.key,
    this.brandName,
    this.category,
    this.imagePath,
    this.followers,
    this.reel,
    this.story,
    this.post,
  });

  @override
  State<CampaignDetailsScreen> createState() => _CampaignDetailsScreenState();
}

class _CampaignDetailsScreenState extends State<CampaignDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final String displayBrand = widget.brandName ?? 'Clothes Shop';
    final String displayCategory = widget.category ?? 'Lifestyle';
    final String displayImage =
        (widget.imagePath != null && widget.imagePath!.isNotEmpty)
        ? widget.imagePath!
        : 'assets/images/banner_2.jpg';
    final String displayFollowers = widget.followers ?? '10K';
    final String displayReel = widget.reel ?? 'Reel 1';
    final String displayStory = widget.story ?? 'Story 1';
    final String displayPost = widget.post ?? 'Post 1';

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: Colors.transparent,
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: SizedBox.expand(
              child: Column(
                children: [
                  const SizedBox(height: 37),

                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8.0,
                    ),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () => Get.back(),
                          behavior: HitTestBehavior.opaque,
                          child: const Icon(
                            Icons.arrow_back_ios_new,
                            color: Color(0xFF6B4EFF),
                            size: 22,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'Campaign Details',
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
                  const SizedBox(height: 12),

                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: const Color(0xFFD6C8FF),
                                width: 1.5,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(14.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFFDEEE9),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    padding: const EdgeInsets.all(10.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image.asset(
                                        displayImage,
                                        height: 145,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                              return Container(
                                                height: 145,
                                                color: const Color(0xFFEDE8FF),
                                                child: const Center(
                                                  child: Icon(
                                                    Icons.image,
                                                    size: 50,
                                                    color: Color(0xFF9E8EFE),
                                                  ),
                                                ),
                                              );
                                            },
                                      ),
                                    ),
                                  ),
                                ),

                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                    16,
                                    0,
                                    16,
                                    16,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Center(
                                        child: Text(
                                          'Campaign Details',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xFF9E8EFE),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 14),

                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            displayBrand,
                                            style: const TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                          _buildInfoChip(
                                            icon: Icons.calendar_month_outlined,
                                            label: '5 days',
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 12),

                                      _buildInfoChip(
                                        image: Image.asset(
                                          'assets/images/money_icon.png',
                                          color: const Color(0xFF9E8EFE),
                                          errorBuilder:
                                              (
                                                context,
                                                error,
                                                stackTrace,
                                              ) => const Icon(
                                                Icons.monetization_on_outlined,
                                                color: Color(0xFF9E8EFE),
                                                size: 24,
                                              ),
                                        ),
                                        prefixText: 'Per Creator ',
                                        label: '₹1000',
                                        fontWeight: FontWeight.w700,
                                      ),
                                      const SizedBox(height: 16),

                                      const Text(
                                        'Deliverable',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black,
                                        ),
                                      ),
                                      const SizedBox(height: 8),

                                      _buildPillsCard(
                                        items: [
                                          _PillItem(
                                            icon: Icons.movie_outlined,
                                            label: displayReel,
                                          ),
                                          _PillItem(
                                            icon: Icons.play_circle_outline,
                                            label: displayStory,
                                          ),
                                          _PillItem(
                                            image: Image.asset(
                                              'assets/images/instagram_icon.png',
                                              color: const Color(0xFF6B4EFF),
                                              errorBuilder:
                                                  (
                                                    context,
                                                    error,
                                                    stackTrace,
                                                  ) => const Icon(
                                                    Icons.camera_alt_outlined,
                                                    color: Color(0xFF6B4EFF),
                                                    size: 22,
                                                  ),
                                            ),
                                            label: displayPost,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 16),

                                      const Text(
                                        'Influencer Requirements',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFF9E8EFE),
                                        ),
                                      ),
                                      const SizedBox(height: 8),

                                      _buildPillsCard(
                                        items: [
                                          _PillItem(
                                            icon: Icons.person_outline_rounded,
                                            label: displayFollowers,
                                          ),
                                          _PillItem(
                                            image: Image.asset(
                                              'assets/images/age_icon.png',
                                              color: const Color(0xFF6B4EFF),
                                              errorBuilder:
                                                  (
                                                    context,
                                                    error,
                                                    stackTrace,
                                                  ) => const Icon(
                                                    Icons
                                                        .accessibility_new_rounded,
                                                    color: Color(0xFF6B4EFF),
                                                    size: 22,
                                                  ),
                                            ),
                                            label: 'Age 18-25',
                                          ),
                                          _PillItem(
                                            image: Image.asset(
                                              'assets/images/male_icon.png',
                                              color: const Color(0xFF6B4EFF),
                                              errorBuilder:
                                                  (
                                                    context,
                                                    error,
                                                    stackTrace,
                                                  ) => const Icon(
                                                    Icons.people_alt_outlined,
                                                    color: Color(0xFF6B4EFF),
                                                    size: 22,
                                                  ),
                                            ),
                                            label: 'Male /Female',
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 16),

                                      const Text(
                                        'Influencer Applied : 20/ 50',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFF9E8EFE),
                                        ),
                                      ),
                                      const SizedBox(height: 8),

                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(4),
                                        child: const LinearProgressIndicator(
                                          value: 0.4,
                                          minHeight: 8,
                                          backgroundColor: Color(0xFFEDE8FF),
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                Color(0xFF9E8EFE),
                                              ),
                                        ),
                                      ),
                                      const SizedBox(height: 6),

                                      const Text(
                                        '20 of 50 influencers found',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 11,
                                          color: Color(0xFF8E8E93),
                                        ),
                                      ),
                                      const SizedBox(height: 14),

                                      Center(
                                        child: Text.rich(
                                          TextSpan(
                                            children: [
                                              const TextSpan(
                                                text: 'Category : ',
                                                style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600,
                                                  color: Color(0xFF9E8EFE),
                                                ),
                                              ),
                                              TextSpan(
                                                text: displayCategory,
                                                style: const TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 16),

                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: const Color(0xFFD6C8FF),
                                width: 1.5,
                              ),
                            ),
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  'About Campaign',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF9E8EFE),
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Artificial Intelligence (AI) is technology enabling '
                                  'machines to mimic human intelligence, learning from '
                                  'data to reason, solve problems.',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 13,
                                    height: 1.5,
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 24),

                          CustomButton(
                            text: 'Save',
                            isGradient: false,
                            backgroundColor: Colors.white,
                            borderColor: const Color(0xFFD6C8FF),
                            textColor: Colors.black,
                            width: double.infinity,
                            onTap: () {},
                          ),
                          const SizedBox(height: 12),
                          CustomButton(
                            text: 'Apply',
                            isGradient: true,
                            width: double.infinity,
                            textColor: Colors.white,
                            onTap: () {},
                          ),
                          const SizedBox(height: 32),
                        ],
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

  Widget _buildInfoChip({
    IconData? icon,
    Widget? image,
    String prefixText = '',
    required String label,
    FontWeight fontWeight = FontWeight.w600,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: const Color(0xFFEBE8FC),
            borderRadius: BorderRadius.circular(8),
          ),
          child: image != null
              ? SizedBox(width: 22, height: 22, child: image)
              : Icon(icon, size: 22, color: const Color(0xFF9E8EFE)),
        ),
        const SizedBox(width: 10),
        Text.rich(
          TextSpan(
            children: [
              if (prefixText.isNotEmpty)
                TextSpan(
                  text: prefixText,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14.5,
                    fontWeight: FontWeight.w400,
                    color: Colors.black87,
                  ),
                ),
              TextSpan(
                text: label,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 15,
                  fontWeight: fontWeight,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPillsCard({required List<_PillItem> items}) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFEDE8FF),
        borderRadius: BorderRadius.circular(14),
      ),
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: IntrinsicHeight(
        child: Row(
          children: List.generate(items.length * 2 - 1, (i) {
            if (i.isOdd) {
              return const VerticalDivider(
                color: Color(0xFFB8A8FF),
                thickness: 1,
                width: 1,
              );
            }
            final item = items[i ~/ 2];
            return Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  item.image != null
                      ? SizedBox(width: 22, height: 22, child: item.image)
                      : Icon(
                          item.icon,
                          size: 24,
                          color: const Color(0xFF6B4EFF),
                        ),
                  const SizedBox(height: 4),
                  Text(
                    item.label,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF2D007C),
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}

class _PillItem {
  final IconData? icon;
  final Widget? image;
  final String label;
  const _PillItem({this.icon, this.image, required this.label});
}
