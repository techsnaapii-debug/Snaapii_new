import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snaapii/widgets/custom_button.dart';
import 'package:snaapii/widgets/creator_widget/withdraw_top_clipper.dart';
import 'package:snaapii/views/creator/kyc_verification_screen.dart';
import 'package:snaapii/views/creator/add_withdrawal_account_screen.dart';

class WithdrawBottomSheetContent extends StatefulWidget {
  final bool initialKycStep;
  const WithdrawBottomSheetContent({super.key, this.initialKycStep = false});

  @override
  State<WithdrawBottomSheetContent> createState() =>
      _WithdrawBottomSheetContentState();
}

class _WithdrawBottomSheetContentState
    extends State<WithdrawBottomSheetContent> {
  late bool _showKycView;
  final TextEditingController _amountController = TextEditingController(
    text: '5000',
  );
  final List<String> _presetAmounts = ['5000', '1000', '10000', '15000'];

  @override
  void initState() {
    super.initState();
    _showKycView = widget.initialKycStep;
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: const WithdrawTopClipper(),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.73,
        color: const Color(0xFFF3EFFF),
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          top: 16,
          bottom: 20,
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 36,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Withdraw',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 14),

              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Enter Amount',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
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
                    padding: EdgeInsets.only(left: 16, right: 6),
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

              const SizedBox(height: 16),

              if (!_showKycView) ...[
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Choose amount',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _presetAmounts.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 3.2,
                  ),
                  itemBuilder: (context, index) {
                    final amountText = _presetAmounts[index];
                    final isSelected = _amountController.text == amountText;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _amountController.text = amountText;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isSelected
                                ? const Color(0xFF6B4EFF)
                                : const Color(0xFFE0E0E0),
                            width: isSelected ? 1.5 : 1,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            '₹ $amountText',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.w500,
                              color: isSelected
                                  ? const Color(0xFF6B4EFF)
                                  : Colors.black87,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 20),

                CustomButton(
                  text: 'Proceed to Pay',
                  isGradient: true,
                  width: double.infinity,
                  gradientColors: const [Color(0xFFBA8FFF), Color(0xFF6C63FF)],
                  textColor: Colors.white,
                  onTap: () {
                    setState(() {
                      _showKycView = true;
                    });
                  },
                ),
                const SizedBox(height: 10),
              ] else ...[
                const SizedBox(height: 70),

                CustomButton(
                  text: 'Verify KYC',
                  isGradient: true,
                  width: double.infinity,
                  height: 52,
                  borderRadius: 30,
                  gradientColors: const [Color(0xFFBA8FFF), Color(0xFF6C63FF)],
                  textColor: Colors.white,
                  onTap: () {
                    Get.back();
                    Get.to(() => const KycVerificationScreen());
                  },
                ),

                const SizedBox(height: 12),

                CustomButton(
                  text: 'Proceed to Withdraw Now',
                  isGradient: true,
                  width: double.infinity,
                  height: 52,
                  borderRadius: 30,
                  gradientColors: const [Color(0xFFBA8FFF), Color(0xFF6C63FF)],
                  textColor: Colors.white,
                  onTap: () {
                    Get.back();
                    Get.to(() => const AddWithdrawalAccountScreen());
                  },
                ),

                const SizedBox(height: 24),

                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Note',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 8),

                const Text(
                  '1. Manage your Finance effortlessly\n'
                  '2. Manage your Finance effortlessly\n'
                  '3. Manage your Finance effortlessly',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12,
                    color: Colors.black54,
                    height: 1.6,
                  ),
                ),

                const SizedBox(height: 10),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
