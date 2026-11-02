import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:snaapii/widgets/creator_widget/automation_action_button.dart';
import 'package:snaapii/widgets/creator_widget/automation_active_card.dart';
import 'package:snaapii/widgets/creator_widget/automation_stat_card.dart';
import 'package:snaapii/widgets/creator_widget/shoe_collection_card.dart';
import 'comment_automation_screen.dart';

class CommentShoeCollectionScreen extends StatelessWidget {
  const CommentShoeCollectionScreen({super.key});

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
        body: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 480),
              child: Column(
                children: [
                  const SizedBox(height: 8),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () => Get.back(),
                          behavior: HitTestBehavior.opaque,
                          child: const Icon(
                            Icons.arrow_back_ios_new,
                            color: Color(0xFF6B4EFF),
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Text(
                          'Shoe Collection',
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
                  const SizedBox(height: 12),

                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 4.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const AutomationActiveCard(),
                          const SizedBox(height: 14),

                          const ShoeCollectionCard(),
                          const SizedBox(height: 18),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              Text(
                                'Performance Overview',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black87,
                                ),
                              ),
                              Text(
                                'Today',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF757575),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),

                          Row(
                            children: const [
                              Expanded(
                                child: AutomationStatCard(
                                  icon: Icons.chat_bubble_rounded,
                                  iconColor: Color(0xFF6366F1),
                                  iconBgColor: Color(0xFFEEF2FF),
                                  title: 'Comments Triggered',
                                  value: '1200',
                                ),
                              ),
                              SizedBox(width: 12),
                              Expanded(
                                child: AutomationStatCard(
                                  icon: Icons.send_rounded,
                                  iconColor: Color(0xFF8B5CF6),
                                  iconBgColor: Color(0xFFF3E8FF),
                                  title: 'DMs Sent',
                                  value: '1200',
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: const [
                              Expanded(
                                child: AutomationStatCard(
                                  icon: Icons.remove_red_eye_rounded,
                                  iconColor: Color(0xFFF97316),
                                  iconBgColor: Color(0xFFFFEDD5),
                                  title: 'Profile Visits',
                                  value: '120',
                                ),
                              ),
                              SizedBox(width: 12),
                              Expanded(
                                child: AutomationStatCard(
                                  icon: Icons.people_alt_rounded,
                                  iconColor: Color(0xFF059669),
                                  iconBgColor: Color(0xFFD1FAE5),
                                  title: 'Followers Gained',
                                  value: '120',
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),

                          const FullWidthStatCard(
                            imagePath: 'assets/images/up_arrow_icon.png',
                            iconColor: Color(0xFFDB2777),
                            iconBgColor: Color(0xFFFCE7F3),
                            title: 'Link Clicks',
                            value: '392',
                          ),
                          const SizedBox(height: 22),

                          Row(
                            children: [
                              Expanded(
                                child: AutomationActionButton(
                                  label: 'Edit',
                                  onTap: () {
                                    Get.to(
                                      () => const CreateAutomationScreen(),
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: AutomationActionButton(
                                  label: 'Paused',
                                  onTap: () {
                                    _showConfirmationDialog(
                                      context,
                                      actionText: 'Pause',
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: AutomationActionButton(
                                  label: 'Preview',
                                  onTap: () {},
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: AutomationActionButton(
                                  label: 'Delete',
                                  onTap: () {
                                    _showConfirmationDialog(
                                      context,
                                      actionText: 'Delete',
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
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

  void _showConfirmationDialog(
    BuildContext context, {
    required String actionText,
  }) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.45),
      builder: (dialogContext) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        backgroundColor: Colors.white,
        insetPadding: const EdgeInsets.symmetric(horizontal: 40),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 26, 20, 22),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FittedBox(
                fit: BoxFit.scaleDown,
                child: RichText(
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  text: TextSpan(
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14.5,
                      color: Colors.black87,
                    ),
                    children: [
                      const TextSpan(
                        text: 'Are you sure you want to ',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.black87,
                        ),
                      ),
                      TextSpan(
                        text: actionText,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 44,
                      child: OutlinedButton(
                        onPressed: () => Navigator.of(dialogContext).pop(),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(
                            color: Color(0xFFD1D5DB),
                            width: 1.2,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          backgroundColor: Colors.white,
                        ),
                        child: const Text(
                          'Cancel',
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
                  const SizedBox(width: 14),

                  Expanded(
                    child: SizedBox(
                      height: 44,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(dialogContext).pop();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFF5E5E),
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          actionText,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
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
      ),
    );
  }
}
