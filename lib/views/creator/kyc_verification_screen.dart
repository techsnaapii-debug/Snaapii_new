import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../widgets/custom_button.dart';
import 'wallet_kyc_screen.dart';

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
                  ? _buildSuccessView()
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

                                _buildInputField(
                                  'Pan Number',
                                  hintText: 'Enter Pan number',
                                  controller: _panController,
                                ),

                                _buildInputField(
                                  'Name as per PAN Card',
                                  hintText: 'Enter Name as per PAN Card',
                                  controller: _nameController,
                                ),

                                _buildInputField(
                                  'Adhaar Card Number',
                                  hintText: 'Enter Adhaar card number',
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

                                Container(
                                  padding: const EdgeInsets.all(14),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF7F3FF),
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Icon(
                                        Icons.info_outline,
                                        color: Colors.black87,
                                        size: 22,
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: const [
                                            Text(
                                              'Why do we need your KYC?',
                                              style: TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black,
                                              ),
                                            ),
                                            SizedBox(height: 4),
                                            Text(
                                              'KYC helps us verify your identity, ensures secure transactions and is required as per government regulations to process withdrawals.',
                                              style: TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 11.5,
                                                color: Colors.black54,
                                                height: 1.35,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

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

  Widget _buildInputField(
    String label, {
    required String hintText,
    TextEditingController? controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 14,
            color: Colors.black,
          ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
              color: Color(0xFFC0C0C0),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            filled: true,
            fillColor: Colors.white,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Color(0xFFE5E5E5),
                width: 1.2,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Color(0xFF6B4EFF),
                width: 1.5,
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildSuccessView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 140),

        Container(
          width: 240,
          height: 240,
          decoration: const BoxDecoration(
            color: Color(0xFFEFF9F2),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Container(
              width: 180,
              height: 180,
              decoration: const BoxDecoration(
                color: Color(0xFFC7F0D3),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Container(
                  width: 130,
                  height: 130,
                  decoration: const BoxDecoration(
                    color: Color(0xFF28C752),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check_rounded,
                    size: 76,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),

        const SizedBox(height: 40),

        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Text('🎉 ', style: TextStyle(fontSize: 22)),
            Text(
              'KYC Verified Successfully',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF28C752),
              ),
            ),
          ],
        ),

        const SizedBox(height: 10),

        const Text(
          'You can now withdraw your earning.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Color(0xFF666666),
          ),
        ),
      ],
    );
  }
}
