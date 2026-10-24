import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:snaapii/widgets/creator_widget/withdraw_bottom_sheet.dart';
import 'creator_home_screen.dart';
import 'package:snaapii/widgets/creator_widget/wallet_balance_card.dart';
import 'package:snaapii/widgets/creator_widget/withdraw_history_tile.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  static void showWithdrawBottomSheet(
    BuildContext context, {
    bool initialKycStep = false,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext bottomSheetContext) {
        return WithdrawBottomSheetContent(initialKycStep: initialKycStep);
      },
    );
  }

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  final List<Map<String, dynamic>> _withdrawHistory = [
    {
      'title': 'Withdrawal to UPI',
      'subtitle': 'UPI ID: ritesh@upi',
      'date': '07 Jul 2026  |  03:45 PM',
      'amount': '₹ 500.00',
      'status': 'Pending',
      'isSuccess': false,
      'isBank': false,
    },
    {
      'title': 'Withdrawal to UPI',
      'subtitle': 'UPI ID: ritesh@upi',
      'date': '07 Jul 2026  |  03:45 PM',
      'amount': '₹ 500.00',
      'status': 'Success',
      'isSuccess': true,
      'isBank': false,
    },
    {
      'title': 'Withdrawal to Bank',
      'subtitle': 'A/c No: **** **** 4321',
      'date': '07 Jul 2026  |  03:45 PM',
      'amount': '₹ 500.00',
      'status': 'Success',
      'isSuccess': true,
      'isBank': true,
    },
  ];

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
                          onTap: () {
                            if (Navigator.canPop(context)) {
                              Get.back();
                            } else {
                              Get.offAll(() => const CreatorHomeScreen());
                            }
                          },
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

                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),

                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                            ),
                            child: WalletBalanceCard(
                              balance: '₹200.45',
                              onWithdrawTap: () {
                                WalletScreen.showWithdrawBottomSheet(context);
                              },
                            ),
                          ),

                          const SizedBox(height: 24),

                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.0),
                            child: Text(
                              'Withdraw History',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                          ),

                          const SizedBox(height: 12),

                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: const Color(0xFFF0F0F0),
                                  width: 1.2,
                                ),
                              ),
                              child: Column(
                                children: List.generate(
                                  _withdrawHistory.length,
                                  (index) {
                                    final item = _withdrawHistory[index];
                                    final isLast =
                                        index == _withdrawHistory.length - 1;
                                    return Column(
                                      children: [
                                        WithdrawHistoryTile(item: item),
                                        if (!isLast)
                                          const Divider(
                                            height: 1,
                                            thickness: 1,
                                            color: Color(0xFFF0F0F0),
                                            indent: 16,
                                            endIndent: 16,
                                          ),
                                      ],
                                    );
                                  },
                                ),
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
