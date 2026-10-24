import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'add_bank_account_screen.dart';
import 'add_upi_screen.dart';

class AddWithdrawalAccountScreen extends StatefulWidget {
  const AddWithdrawalAccountScreen({super.key});

  @override
  State<AddWithdrawalAccountScreen> createState() =>
      _AddWithdrawalAccountScreenState();
}

class _AddWithdrawalAccountScreenState
    extends State<AddWithdrawalAccountScreen> {
  String? _selectedMethod;

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
                          'Add Withdrawal Account',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 22,
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
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 40),

                          Image.asset(
                            'assets/images/withdrawal_icon.png',
                            width: 100,
                            height: 90,
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) =>
                                Container(
                                  width: 100,
                                  height: 90,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFB18CFF),
                                    borderRadius: BorderRadius.circular(22),
                                  ),
                                  child: const Center(
                                    child: Icon(
                                      Icons.account_balance_wallet_rounded,
                                      size: 52,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                          ),

                          const SizedBox(height: 24),

                          const Text(
                            'Add Withdrawal Account',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 8),

                          const Text(
                            'Choose where you want to receive your payment.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 12,
                              color: Color(0xFF888888),
                            ),
                          ),

                          const SizedBox(height: 70),

                          _buildOptionCard(
                            id: 'bank',
                            title: 'Bank Account',
                            icon: const Icon(
                              Icons.account_balance_outlined,
                              color: Color(0xFF6B4EFF),
                              size: 26,
                            ),
                          ),

                          const SizedBox(height: 14),

                          _buildOptionCard(
                            id: 'upi',
                            title: 'UPI ID',
                            icon: Image.asset(
                              'assets/images/upi_icon.png',
                              width: 26,
                              height: 26,
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Text(
                                    'UPI',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w800,
                                      fontStyle: FontStyle.italic,
                                      color: Color(0xFF6B4EFF),
                                    ),
                                  ),
                            ),
                          ),

                          const SizedBox(height: 40),
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

  Widget _buildOptionCard({
    required String id,
    required String title,
    required Widget icon,
  }) {
    final isSelected = _selectedMethod == id;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedMethod = id;
        });
        if (id == 'bank') {
          Get.to(() => const AddBankAccountScreen());
        } else if (id == 'upi') {
          Get.to(() => const AddUpiScreen());
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 30),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? const Color(0xFFD6C8FF)
                : const Color(0xFFE5E5E5),
            width: 1.5,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: const Color(0xFF6B4EFF).withValues(alpha: 0.08),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [],
        ),
        child: Row(
          children: [
            SizedBox(width: 32, height: 32, child: Center(child: icon)),
            const SizedBox(width: 14),
            Text(
              title,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            const Spacer(),

            Container(
              width: 52,
              height: 28,
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: isSelected
                      ? const Color(0xFFB18CFF)
                      : const Color(0xFFD0D0D0),
                  width: 1.5,
                ),
                color: isSelected
                    ? const Color(0xFFF3EFFF)
                    : const Color(0xFFF5F5F5),
              ),
              child: AnimatedAlign(
                duration: const Duration(milliseconds: 200),
                alignment: isSelected
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                child: Container(
                  width: 22,
                  height: 22,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isSelected
                        ? const Color(0xFF6B4EFF)
                        : const Color(0xFF9E9E9E),
                  ),
                  child: Icon(
                    isSelected ? Icons.check : Icons.close,
                    size: 14,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
