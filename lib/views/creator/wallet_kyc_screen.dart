import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../widgets/custom_button.dart';
import 'package:snaapii/widgets/creator_widget/kyc_sheet_top_clipper.dart';
import 'add_withdrawal_account_screen.dart';
import 'kyc_verification_screen.dart';
import 'package:snaapii/widgets/creator_widget/wallet_balance_card.dart';
import 'package:snaapii/widgets/creator_widget/wallet_note_block.dart';

class WalletKycScreen extends StatefulWidget {
  final String? amount;

  const WalletKycScreen({super.key, this.amount});

  @override
  State<WalletKycScreen> createState() => _WalletKycScreenState();
}

class _WalletKycScreenState extends State<WalletKycScreen> {
  late TextEditingController _amountController;

  @override
  void initState() {
    super.initState();
    _amountController = TextEditingController(text: widget.amount ?? '5000');
  }

  @override
  void dispose() {
    _amountController.dispose();
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
              child: Column(
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
                          'My Wallet',
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

                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: WalletBalanceCard(balance: '₹2000.45'),
                  ),

                  const SizedBox(height: 16),

                  Expanded(
                    child: ClipPath(
                      clipper: const KycSheetTopClipper(),
                      child: Container(
                        width: double.infinity,
                        color: const Color(0xFFF3EFFF),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20.0,
                          vertical: 16.0,
                        ),
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Container(
                                  width: 36,
                                  height: 4,
                                  decoration: BoxDecoration(
                                    color: Colors.black87,
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Center(
                                child: Text(
                                  'Withdraw',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),

                              const Text(
                                'Enter Amount',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 6),

                              TextField(
                                controller: _amountController,
                                keyboardType: TextInputType.number,
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                                decoration: InputDecoration(
                                  prefixIcon: const Padding(
                                    padding: EdgeInsets.only(
                                      left: 16,
                                      right: 6,
                                    ),
                                    child: Center(
                                      widthFactor: 1,
                                      child: Text(
                                        '₹',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
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
                                      color: Color(0xFFE0E0E0),
                                      width: 1,
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

                              const SizedBox(height: 70),

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
                                  Get.to(() => const KycVerificationScreen());
                                },
                              ),

                              const SizedBox(height: 14),

                              CustomButton(
                                text: 'Proceed to Withdraw Now',
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
                                  Get.to(
                                    () => const AddWithdrawalAccountScreen(),
                                  );
                                },
                              ),

                              const SizedBox(height: 28),

                              const WalletNoteBlock(
                                notes: [
                                  '1. Manage your Finance effortlessly',
                                  '2. Manage your Finance effortlessly',
                                  '3. Manage your Finance effortlessly',
                                ],
                              ),

                              const SizedBox(height: 24),
                            ],
                          ),
                        ),
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
