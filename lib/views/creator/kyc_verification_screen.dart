import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../widgets/custom_button.dart';
import 'wallet_kyc_screen.dart';
import 'package:snaapii/widgets/creator_widget/creator_input_field.dart';
import 'package:snaapii/widgets/creator_widget/kyc_success_view.dart';
import 'package:snaapii/widgets/creator_widget/kyc_why_card.dart';

class KycVerificationScreen extends StatefulWidget {
  const KycVerificationScreen({super.key});

  @override
  State<KycVerificationScreen> createState() => _KycVerificationScreenState();
}

class _KycVerificationScreenState extends State<KycVerificationScreen> {
  bool _isVerified = false;
  final TextEditingController _panController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _adhaarController = TextEditingController();

  @override
  void dispose() {
    _panController.dispose();
    _nameController.dispose();
    _adhaarController.dispose();
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
        body: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: SizedBox.expand(
              child: _isVerified
                  ? const KycSuccessView()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 37),

                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 8.0,
                          ),
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
                                'KYC Verification',
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

                        Expanded(
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20.0,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 8),

                                Center(
                                  child: Column(
                                    children: [
                                      Image.asset(
                                        'assets/images/kyc_logo.png',
                                        width: 120,
                                        height: 120,
                                        fit: BoxFit.contain,
                                        errorBuilder:
                                            (
                                              context,
                                              error,
                                              stackTrace,
                                            ) => Container(
                                              width: 110,
                                              height: 110,
                                              decoration: const BoxDecoration(
                                                color: Color(0xFFB18CFF),
                                                shape: BoxShape.circle,
                                              ),
                                              child: const Icon(
                                                Icons.security,
                                                size: 50,
                                                color: Colors.white,
                                              ),
                                            ),
                                      ),
                                      const SizedBox(height: 14),
                                      const Text(
                                        'Please complete your kyc to withdraw\nyour earning.',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 14,
                                          color: Color(0xFF666666),
                                          height: 1.4,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                const SizedBox(height: 24),

                                CreatorInputField(
                                  label: 'Pan Number',
                                  controller: _panController,
                                ),

                                CreatorInputField(
                                  label: 'Name as per PAN Card',
                                  controller: _nameController,
                                ),

                                CreatorInputField(
                                  label: 'Adhaar Card Number',
                                  controller: _adhaarController,
                                ),

                                const SizedBox(height: 12),

                                CustomButton(
                                  text: 'Verify KYC',
                                  isGradient: true,
                                  width: double.infinity,
                                  height: 52,
                                  borderRadius: 30,
                                  gradientColors: const [
                                    Color(0xFFBA8FFF),
                                    Color(0xFF6C63FF),
                                  ],
                                  textColor: Colors.white,
                                  onTap: () {
                                    setState(() {
                                      _isVerified = true;
                                    });
                                    Future.delayed(
                                      const Duration(seconds: 2),
                                      () {
                                        if (mounted) {
                                          Get.off(
                                            () => const WalletKycScreen(),
                                          );
                                        }
                                      },
                                    );
                                  },
                                ),

                                const SizedBox(height: 24),

                                const KycWhyCard(),

                                const SizedBox(height: 24),

                                const Center(
                                  child: Text(
                                    'Your information is safe and secure with us',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFF2E7D32),
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 30),
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


}
