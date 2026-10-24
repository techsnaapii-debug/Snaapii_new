import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'dm_automation_screen.dart';
import 'dm_preview_screen.dart';
import 'package:snaapii/widgets/creator_widget/automation_action_button.dart';
import 'package:snaapii/widgets/creator_widget/automation_active_card.dart';
import 'package:snaapii/widgets/creator_widget/automation_confirmation_dialog.dart';
import 'package:snaapii/widgets/creator_widget/performance_metric_card.dart';
import 'package:snaapii/widgets/creator_widget/shoe_collection_card.dart';

class DmShoeCollectionScreen extends StatefulWidget {
  const DmShoeCollectionScreen({super.key});

  @override
  State<DmShoeCollectionScreen> createState() => _DmShoeCollectionScreenState();
}

class _DmShoeCollectionScreenState extends State<DmShoeCollectionScreen> {
  bool _isPaused = false;

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
                  const SizedBox(height: 14),

                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AutomationActiveCard(isPaused: _isPaused),
                          const SizedBox(height: 14),

                          const ShoeCollectionCard(),
                          const SizedBox(height: 18),

                          const Text(
                            'Performance Overview',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 12),

                          Column(
                            children: [
                              Row(
                                children: const [
                                  Expanded(
                                    child: PerformanceMetricCard(
                                      bgColor: Color(0xFFFDE8E8),
                                      borderColor: Color(0xFFFBCFE8),
                                      iconBgColor: Color(0xFFFBCFE8),
                                      iconColor: Color(0xFFDB2777),
                                      imagePath:
                                          'assets/images/up_arrow_icon.png',
                                      label: 'Link Clicks',
                                      value: '392',
                                    ),
                                  ),
                                  SizedBox(width: 12),
                                  Expanded(
                                    child: PerformanceMetricCard(
                                      bgColor: Color(0xFFEDE9FE),
                                      borderColor: Color(0xFFDDD6FE),
                                      iconBgColor: Color(0xFFDDD6FE),
                                      iconColor: Color(0xFF7C3AED),
                                      icon: Icons.send_rounded,
                                      label: 'DMs Sent',
                                      value: '1200',
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),

                              Row(
                                children: const [
                                  Expanded(
                                    child: PerformanceMetricCard(
                                      bgColor: Color(0xFFFFF7ED),
                                      borderColor: Color(0xFFFED7AA),
                                      iconBgColor: Color(0xFFFFEDD5),
                                      iconColor: Color(0xFFEA580C),
                                      icon: Icons.visibility_rounded,
                                      label: 'Profile Visits',
                                      value: '120',
                                    ),
                                  ),
                                  SizedBox(width: 12),
                                  Expanded(
                                    child: PerformanceMetricCard(
                                      bgColor: Color(0xFFD1FAE5),
                                      borderColor: Color(0xFFA7F3D0),
                                      iconBgColor: Color(0xFFA7F3D0),
                                      iconColor: Color(0xFF059669),
                                      icon: Icons.people_alt_rounded,
                                      label: 'Followers Gained',
                                      value: '1200',
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),

                          Row(
                            children: [
                              Expanded(
                                child: AutomationActionButton(
                                  label: 'Edit',
                                  onTap: () {
                                    Get.to(() => const DmAutomationScreen());
                                  },
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: AutomationActionButton(
                                  label: _isPaused ? 'Resume' : 'Paused',
                                  onTap: () {
                                    AutomationConfirmationDialog.show(
                                      context,
                                      actionText: _isPaused
                                          ? 'Resume'
                                          : 'Pause',
                                      onConfirm: () {
                                        setState(() {
                                          _isPaused = !_isPaused;
                                        });
                                      },
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: AutomationActionButton(
                                  label: 'Preview',
                                  onTap: () {
                                    Get.to(() => const DmPreviewScreen());
                                  },
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: AutomationActionButton(
                                  label: 'Delete',
                                  onTap: () {
                                    AutomationConfirmationDialog.show(
                                      context,
                                      actionText: 'Delete',
                                      onConfirm: () {
                                        Get.back();
                                      },
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
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
