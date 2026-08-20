import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../widgets/custom_button.dart';
import 'add_withdrawal_account_screen.dart';
import 'creator_home_screen.dart';
import 'kyc_verification_screen.dart';

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
        return _WithdrawBottomSheetContent(initialKycStep: initialKycStep);
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
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                vertical: 24,
                                horizontal: 16,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFFBA8FFF),
                                    Color(0xFF6C63FF),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(
                                      0xFF6C63FF,
                                    ).withValues(alpha: 0.25),
                                    blurRadius: 15,
                                    offset: const Offset(0, 6),
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Text(
                                    'Current Balance',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  const Text(
                                    '₹200.45',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 32,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 20),

                                  Material(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(30),
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(30),
                                      onTap: () {
                                        WalletScreen.showWithdrawBottomSheet(
                                          context,
                                        );
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 24,
                                          vertical: 8,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          borderRadius: BorderRadius.circular(
                                            30,
                                          ),
                                          border: Border.all(
                                            color: Colors.white,
                                            width: 1.5,
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: const [
                                            Text(
                                              'Withdraw',
                                              style: TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.white,
                                              ),
                                            ),
                                            SizedBox(width: 6),
                                            Icon(
                                              Icons.arrow_forward,
                                              color: Colors.white,
                                              size: 16,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
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
                                        _buildHistoryTile(item),
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

  Widget _buildHistoryTile(Map<String, dynamic> item) {
    final bool isSuccess = item['isSuccess'] ?? false;
    final bool isBank = item['isBank'] ?? false;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: const Color(0xFFF3EFFF),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: isBank
                  ? const Icon(
                      Icons.account_balance_outlined,
                      color: Color(0xFF6B4EFF),
                      size: 22,
                    )
                  : const Text(
                      'UPI',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        color: Color(0xFF6B4EFF),
                      ),
                    ),
            ),
          ),
          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['title'] ?? '',
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  item['subtitle'] ?? '',
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item['date'] ?? '',
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 11,
                    color: Colors.black38,
                  ),
                ),
              ],
            ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                item['amount'] ?? '',
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 6),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: isSuccess
                      ? const Color(0xFFE8F5E9)
                      : const Color(0xFFFFF3E0),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      isSuccess ? Icons.check_circle : Icons.access_time_filled,
                      size: 12,
                      color: isSuccess
                          ? const Color(0xFF2E7D32)
                          : const Color(0xFFE65100),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      item['status'] ?? '',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: isSuccess
                            ? const Color(0xFF2E7D32)
                            : const Color(0xFFE65100),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _WithdrawBottomSheetContent extends StatefulWidget {
  final bool initialKycStep;
  const _WithdrawBottomSheetContent({this.initialKycStep = false});

  @override
  State<_WithdrawBottomSheetContent> createState() =>
      __WithdrawBottomSheetContentState();
}

class __WithdrawBottomSheetContentState
    extends State<_WithdrawBottomSheetContent> {
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
      clipper: const _WithdrawTopClipper(),
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

class _WithdrawTopClipper extends CustomClipper<Path> {
  const _WithdrawTopClipper();

  @override
  Path getClip(Size size) {
    final path = Path();
    double curveHeight = 45.0;
    double centerWidth = 180.0;
    double leftX = (size.width - centerWidth) / 2;
    double rightX = (size.width + centerWidth) / 2;

    path.moveTo(0, curveHeight);
    path.lineTo(leftX - 15, curveHeight);

    path.cubicTo(leftX + 35, curveHeight, leftX + 35, 0, size.width / 2, 0);

    path.cubicTo(
      rightX - 35,
      0,
      rightX - 35,
      curveHeight,
      rightX + 15,
      curveHeight,
    );

    path.lineTo(size.width, curveHeight);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
