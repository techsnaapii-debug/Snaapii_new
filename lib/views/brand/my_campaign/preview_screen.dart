import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../widgets/custom_button.dart';
import 'publish_campaign_screen.dart';

class PreviewScreen extends StatelessWidget {
  const PreviewScreen({super.key});

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
                          child: const Icon(
                            Icons.arrow_back_ios_new,
                            color: Color(0xFF6B4EFF),
                            size: 22,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'Preview',
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
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: const Color(0xFFD6C8FF),
                                width: 1.5,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                    16,
                                    16,
                                    16,
                                    0,
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(14),
                                    child: Image.asset(
                                      'assets/images/banner_2.jpg',
                                      height: 140,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),

                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Campaign Details',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFF9E8EFE),
                                        ),
                                      ),
                                      const SizedBox(height: 15),

                                      const Text(
                                        'Clothes Shop',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black,
                                        ),
                                      ),
                                      const SizedBox(height: 12),

                                      Row(
                                        children: [
                                          _buildInfoChip(
                                            image: Image.asset(
                                              "assets/images/money_icon.png",
                                              color: const Color(0xFF9E8EFE),
                                            ),
                                            label: '₹1000',
                                            fontWeight: FontWeight.w700,
                                          ),
                                          const Spacer(),
                                          _buildInfoChip(
                                            icon: Icons.calendar_month_outlined,
                                            label: '5 days',
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 12),

                                      Row(
                                        children: const [
                                          Text(
                                            'Category : ',
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xFF9E8EFE),
                                            ),
                                          ),
                                          Text(
                                            'Lifestyle',
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 12),

                                      _buildPillsCard(
                                        items: [
                                          _PillItem(
                                            icon: Icons.smart_display_outlined,
                                            label: 'Reel 1',
                                          ),
                                          _PillItem(
                                            icon: Icons.play_circle_outline,
                                            label: 'Story 1',
                                          ),
                                          _PillItem(
                                            image: Image.asset(
                                              'assets/images/instagram_icon.png',
                                              color: const Color(0xFF6B4EFF),
                                            ),
                                            label: 'Post 1',
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 16),

                                      const Text(
                                        'Influencer Requirements',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFF9E8EFE),
                                        ),
                                      ),
                                      const SizedBox(height: 10),

                                      _buildPillsCard(
                                        items: [
                                          _PillItem(
                                            icon: Icons.person,
                                            label: '10K',
                                          ),
                                          _PillItem(
                                            image: Image.asset(
                                              'assets/images/age_icon.png',
                                              color: const Color(0xFF6B4EFF),
                                            ),
                                            label: 'Age 18-25',
                                          ),
                                          _PillItem(
                                            image: Image.asset(
                                              'assets/images/male_icon.png',
                                              color: const Color(0xFF6B4EFF),
                                            ),
                                            label: 'male',
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 16),

                                      const Text(
                                        'Influencer Required : 0/ 50',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFF9E8EFE),
                                        ),
                                      ),
                                      const SizedBox(height: 8),

                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(4),
                                        child: LinearProgressIndicator(
                                          value: 0.0,
                                          minHeight: 6,
                                          backgroundColor: const Color(
                                            0xFFEDE8FF,
                                          ),
                                          valueColor:
                                              const AlwaysStoppedAnimation<
                                                Color
                                              >(Color(0xFF9E8EFE)),
                                        ),
                                      ),
                                      const SizedBox(height: 6),

                                      const Text(
                                        '0 of 50 influencers found',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 11,
                                          color: Color(0xFF8E8E93),
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
                                    fontSize: 16,
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
                                    height: 1.6,
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 32),
                        ],
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: CustomButton(
                                text: 'Edit',
                                imagePath: 'assets/images/edit_icon.png',
                                backgroundColor: const Color(0xFFF9F8FF),
                                textColor: const Color(0xFF000000),
                                onTap: () {
                                  Get.back();
                                },
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: CustomButton(
                                text: 'Draft',
                                imagePath: 'assets/images/draft_icon.png',
                                backgroundColor: const Color(0xFFF9F8FF),
                                textColor: const Color(0xFF000000),
                                onTap: () {},
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        CustomButton(
                          text: 'Publish',
                          isGradient: true,
                          width: double.infinity,
                          onTap: () {
                            Get.to(() => const PublishCampaignScreen());
                          },
                        ),
                      ],
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
    required String label,
    FontWeight fontWeight = FontWeight.w600,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
          decoration: BoxDecoration(
            color: const Color(0xFFEBE8FC),
            borderRadius: BorderRadius.circular(6),
          ),
          child: image != null
              ? SizedBox(width: 24, height: 24, child: image)
              : Icon(icon, size: 24, color: const Color(0xFF9E8EFE)),
        ),
        const SizedBox(width: 12),
        Text(
          label,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 16,
            fontWeight: fontWeight,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _buildPillsCard({required List<_PillItem> items}) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFEDE8FF),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: IntrinsicHeight(
        child: Row(
          children: List.generate(items.length * 2 - 1, (i) {
            if (i.isOdd) {
              return VerticalDivider(
                color: const Color(0xFFB8A8FF),
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
                      ? SizedBox(width: 24, height: 24, child: item.image)
                      : Icon(
                          item.icon,
                          size: 28,
                          color: const Color(0xFF6B4EFF),
                        ),
                  const SizedBox(height: 4),
                  Text(
                    item.label,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
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
