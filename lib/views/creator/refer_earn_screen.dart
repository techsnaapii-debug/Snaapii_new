import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../widgets/custom_button.dart';
import 'package:snaapii/widgets/creator_widget/referral_option_tile.dart';
import 'how_work_screen.dart';

class ReferEarnScreen extends StatefulWidget {
  const ReferEarnScreen({super.key});

  @override
  State<ReferEarnScreen> createState() => _ReferEarnScreenState();
}

class _ReferEarnScreenState extends State<ReferEarnScreen> {
  final String _referralCode = 'SNAAPII1234';
  final String _referralLink = 'https://snaapii.com/snaapii1234';

  void _copyToClipboard(String text, String label) {
    Clipboard.setData(ClipboardData(text: text));
    Get.snackbar(
      'Copied',
      '$label copied to clipboard',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF6B4EFF),
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
    );
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
        body: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 37),

                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
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
                                'Refer & Earn',
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
                        const SizedBox(height: 16),

                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFFF7F3FF), Color(0xFFEFE6FF)],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: const Color(0xFFEADEFF),
                              width: 1,
                            ),
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 160,
                                child: Image.asset(
                                  'assets/images/invite_icon.png',
                                  fit: BoxFit.contain,
                                  errorBuilder: (context, error, stackTrace) =>
                                      Image.asset(
                                        'assets/images/invite_icon.png',
                                        fit: BoxFit.contain,
                                        errorBuilder:
                                            (context, error, stackTrace) =>
                                                const Icon(
                                                  Icons.card_giftcard_rounded,
                                                  size: 100,
                                                  color: Color(0xFF9E8EFE),
                                                ),
                                      ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              const Text(
                                'Invite Friends & Earn Together',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                'Share your referral link with friends. When they join and purchase a subscription, you earn ₹199 and your friend receives ₹50 reward.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 13,
                                  height: 1.4,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF616161),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),

                        const Text(
                          'Your Referral Code',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 13.5,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF616161),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          height: 52,
                          padding: const EdgeInsets.only(left: 16, right: 6),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: const Color(0xFFE2D6FF),
                              width: 1.2,
                            ),
                          ),
                          child: Row(
                            children: [
                              Text(
                                _referralCode,
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  letterSpacing: 0.5,
                                ),
                              ),
                              const Spacer(),
                              InkWell(
                                onTap: () => _copyToClipboard(
                                  _referralCode,
                                  'Referral Code',
                                ),
                                borderRadius: BorderRadius.circular(20),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 26,
                                    vertical: 9,
                                  ),
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [
                                        Color(0xFF9E8EFE),
                                        Color(0xFF6B4EFF),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: const Text(
                                    'Copy',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 13.5,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),

                        const Text(
                          'Your Referral Link',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 13.5,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF616161),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          height: 52,
                          padding: const EdgeInsets.only(left: 16, right: 6),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: const Color(0xFFE2D6FF),
                              width: 1.2,
                            ),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  _referralLink,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 13.5,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              InkWell(
                                onTap: () => _copyToClipboard(
                                  _referralLink,
                                  'Referral Link',
                                ),
                                borderRadius: BorderRadius.circular(20),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 26,
                                    vertical: 9,
                                  ),
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [
                                        Color(0xFF9E8EFE),
                                        Color(0xFF6B4EFF),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: const Text(
                                    'Copy',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 13.5,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),

                        ReferralOptionTile(
                          icon: Icons.person_rounded,
                          title: 'My Referrals',
                          onTap: () {},
                        ),
                        const SizedBox(height: 10),

                        ReferralOptionTile(
                          icon: Icons.autorenew_rounded,
                          title: 'Pending',
                          onTap: () {},
                        ),
                        const SizedBox(height: 10),

                        ReferralOptionTile(
                          icon: Icons.check_circle_rounded,
                          title: 'Successful',
                          onTap: () {},
                        ),
                        const SizedBox(height: 24),

                        const Text(
                          'How It Works',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 10),
                        GestureDetector(
                          onTap: () => Get.to(() => const HowWorkScreen()),
                          behavior: HitTestBehavior.opaque,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 7,
                              vertical: 7,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF7F3FF),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 68,
                                  height: 68,
                                  child: Image.asset(
                                    'assets/images/invite_icon.png',
                                    fit: BoxFit.contain,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            const Icon(
                                              Icons.card_giftcard_rounded,
                                              color: Color(0xFF8655FE),
                                              size: 36,
                                            ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                const Expanded(
                                  child: Text(
                                    'Learn how the Refer & Earn Program works',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 13.5,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFF8655FE),
                                    ),
                                  ),
                                ),
                                const Icon(
                                  Icons.chevron_right_rounded,
                                  color: Color(0xFF8655FE),
                                  size: 24,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 28),
                      ],
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
                  child: CustomButton(
                    text: 'View My Referrals ',
                    isGradient: true,
                    gradientColors: const [
                      Color(0xFF9E8EFE),
                      Color(0xFF6B4EFF),
                    ],
                    height: 49,
                    borderRadius: 28,
                    fontSize: 19,
                    onTap: () {},
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
