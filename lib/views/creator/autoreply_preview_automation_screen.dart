import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:snaapii/widgets/creator_widget/live_automation_preview_slides.dart';
import 'automation_dashboard_screen.dart';
import 'package:snaapii/widgets/creator_widget/automation_live_dialog.dart';

class AutoreplyPreviewScreen extends StatefulWidget {
  final String? postImage;
  final String? automationName;
  final String? delay;
  final int? repliesCount;
  final int? autoLikeCount;

  const AutoreplyPreviewScreen({
    super.key,
    this.postImage,
    this.automationName,
    this.delay,
    this.repliesCount,
    this.autoLikeCount,
  });

  @override
  State<AutoreplyPreviewScreen> createState() => _AutoreplyPreviewScreenState();
}

class _AutoreplyPreviewScreenState extends State<AutoreplyPreviewScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
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
                          'Preview',
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
                  const SizedBox(height: 16),

                  Expanded(
                    child: Center(
                      child: SizedBox(
                        width: 275,
                        height: 490,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(36),
                            border: Border.all(
                              color: const Color(0xFF6B4EFF),
                              width: 2,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(
                                  0xFF6B4EFF,
                                ).withValues(alpha: 0.12),
                                blurRadius: 18,
                                spreadRadius: 2,
                                offset: const Offset(0, 6),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: const BorderRadius.all(Radius.circular(34)),
                            child: PageView(
                              controller: _pageController,
                              onPageChanged: (index) {
                                setState(() {
                                  _currentPage = index;
                                });
                              },
                              children: const [
                                LiveAutomationSlide2(isLiked: false),
                                LiveAutomationSlide2(isLiked: true),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(2, (index) {
                      final isActive = _currentPage == index;
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        margin: const EdgeInsets.symmetric(horizontal: 3),
                        height: 7,
                        width: isActive ? 12 : 7,
                        decoration: BoxDecoration(
                          color: isActive
                              ? const Color(0xFF6B4EFF)
                              : const Color(0xFFE9D5FF),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 14),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(28, 0, 28, 20),
                    child: GestureDetector(
                      onTap: () {
                        AutomationLiveDialog.show(
                          context,
                          onOkay: () {
                            Navigator.of(context).pop();
                            Get.to(
                              () => const AutomationDashboardScreen(
                                automationType: 'autoreply',
                                isDm: false,
                              ),
                            );
                          },
                        );
                      },
                      behavior: HitTestBehavior.opaque,
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          gradient: const LinearGradient(
                            colors: [Color(0xFF8B5CF6), Color(0xFF6366F1)],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(
                                0xFF6B4EFF,
                              ).withValues(alpha: 0.3),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: const Center(
                          child: Text(
                            'Go Live',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
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
}
