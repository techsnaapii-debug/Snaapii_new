import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../brand/profile/about_screen.dart';
import '../brand/profile/account_screen.dart';
import '../brand/profile/contact_screen.dart';
import '../brand/profile/feedback_screen.dart';
import '../brand/profile/help_screen.dart';
import 'edit_profile_screen.dart';
import 'explore_screen.dart';
import 'refer_earn_screen.dart';
import 'wallet_screen.dart';

class CreatorSettingScreen extends StatefulWidget {
  const CreatorSettingScreen({super.key});

  @override
  State<CreatorSettingScreen> createState() => _CreatorSettingScreenState();
}

class _CreatorSettingScreenState extends State<CreatorSettingScreen> {
  final List<Map<String, dynamic>> _menuItems = [
    {
      'title': 'Edit Profile',
      'icon': 'assets/images/edit_profile.png',
      'hasChevron': false,
    },
    {
      'title': 'Wallet',
      'icon': Icons.account_balance_wallet_rounded,
      'hasChevron': false,
    },
    {
      'title': 'Refer & Earn',
      'icon': Container(
        width: 27,
        height: 27,
        decoration: const BoxDecoration(
          color: Colors.black,
          shape: BoxShape.circle,
        ),
        child: const Center(
          child: Icon(
            Icons.currency_rupee_rounded,
            color: Colors.white,
            size: 17,
          ),
        ),
      ),
      'hasChevron': false,
    },
    {'title': 'Campaign', 'icon': Icons.campaign_rounded, 'hasChevron': false},
    {'title': 'Account', 'icon': Icons.person_rounded, 'hasChevron': true},
    {'title': 'About', 'icon': Icons.info_rounded, 'hasChevron': true},
    {
      'title': 'Help',
      'icon': Icons.account_circle_rounded,
      'hasChevron': false,
    },
    {'title': 'Feedback', 'icon': Icons.feedback_rounded, 'hasChevron': false},
    {
      'title': 'Contact',
      'icon': Icons.contact_page_rounded,
      'hasChevron': false,
    },
    {'title': 'Logout', 'icon': Icons.logout_rounded, 'hasChevron': false},
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
                          'Setting',
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

                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 24.0),
                        child: Material(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: const Color(0xFFE0E0E0),
                                width: 1,
                              ),
                            ),
                            child: ListView.separated(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: _menuItems.length,
                              separatorBuilder: (context, index) =>
                                  const Divider(
                                    color: Color(0xFFE0E0E0),
                                    height: 1.5,
                                    thickness: 1.5,
                                    indent: 16,
                                    endIndent: 16,
                                  ),
                              itemBuilder: (context, index) {
                                final item = _menuItems[index];
                                final bool isFirst = index == 0;
                                final bool isLast =
                                    index == _menuItems.length - 1;
                                final BorderRadius itemRadius =
                                    BorderRadius.vertical(
                                      top: isFirst
                                          ? const Radius.circular(20)
                                          : Radius.zero,
                                      bottom: isLast
                                          ? const Radius.circular(20)
                                          : Radius.zero,
                                    );

                                return InkWell(
                                  borderRadius: itemRadius,
                                  onTap: () {
                                    if (item['title'] == 'Edit Profile') {
                                      Get.to(() => const EditProfileScreen());
                                    } else if (item['title'] == 'Wallet') {
                                      Get.to(() => const WalletScreen());
                                    } else if (item['title'] ==
                                        'Refer & Earn') {
                                      Get.to(() => const ReferEarnScreen());
                                    } else if (item['title'] == 'Campaign') {
                                      Get.to(() => const ExploreScreen());
                                    } else if (item['title'] == 'Account') {
                                      Get.to(() => const AccountScreen());
                                    } else if (item['title'] == 'About') {
                                      Get.to(() => const AboutScreen());
                                    } else if (item['title'] == 'Help') {
                                      Get.to(() => const HelpScreen());
                                    } else if (item['title'] == 'Feedback') {
                                      Get.to(() => const FeedbackScreen());
                                    } else if (item['title'] == 'Contact') {
                                      Get.to(() => const ContactScreen());
                                    } else if (item['title'] == 'Logout') {
                                      _showLogoutDialog(context);
                                    }
                                  },
                                  child: SizedBox(
                                    height: 56,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0,
                                      ),
                                      child: Row(
                                        children: [
                                          item['icon'] is Widget
                                              ? (item['icon'] as Widget)
                                              : item['icon'] is IconData
                                              ? Icon(
                                                  item['icon'] as IconData,
                                                  color: Colors.black87,
                                                  size: 27,
                                                )
                                              : Image.asset(
                                                  item['icon'] as String,
                                                  width: 27,
                                                  height: 27,
                                                  fit: BoxFit.contain,
                                                  errorBuilder:
                                                      (
                                                        context,
                                                        error,
                                                        stackTrace,
                                                      ) => const Icon(
                                                        Icons.edit,
                                                        color: Colors.black87,
                                                        size: 27,
                                                      ),
                                                ),
                                          const SizedBox(width: 16),
                                          Expanded(
                                            child: Text(
                                              item['title'] as String,
                                              style: const TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black87,
                                              ),
                                            ),
                                          ),
                                          if (item['hasChevron'] as bool)
                                            const Icon(
                                              Icons.chevron_right_rounded,
                                              color: Colors.black87,
                                              size: 29,
                                            ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
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

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 24.0,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Are you sure you want to\nLogout?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () => Navigator.of(dialogContext).pop(),
                        borderRadius: BorderRadius.circular(30),
                        child: Container(
                          height: 44,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: const Color(0xFFBA8FFF),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: const Text(
                            'Cancel',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.of(dialogContext).pop();
                        },
                        borderRadius: BorderRadius.circular(30),
                        child: Container(
                          height: 44,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(
                              color: const Color(0xFFBA8FFF),
                              width: 1.5,
                            ),
                          ),
                          child: const Text(
                            'Yes',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
