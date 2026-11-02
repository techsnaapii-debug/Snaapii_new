import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'automation_dashboard_screen.dart';
import 'package:snaapii/widgets/creator_widget/live_automation_preview_slides.dart';
import 'package:snaapii/widgets/creator_widget/automation_live_dialog.dart';

class StoryPreviewScreen extends StatefulWidget {
  final String? storyImage;
  final File? selectedFile;
  final String? username;
  final String? automationName;
  final String? keyword;
  final String? message;
  final String? openingMessageText;
  final String? visitProfileText;
  final String? followingText;
  final String? linkTitle;
  final String? linkUrl;
  final int initialPageIndex;

  const StoryPreviewScreen({
    super.key,
    this.storyImage,
    this.selectedFile,
    this.username,
    this.automationName,
    this.keyword,
    this.message,
    this.openingMessageText,
    this.visitProfileText,
    this.followingText,
    this.linkTitle,
    this.linkUrl,
    this.initialPageIndex = 0,
  });

  @override
  State<StoryPreviewScreen> createState() => _StoryPreviewScreenState();
}

class _StoryPreviewScreenState extends State<StoryPreviewScreen> {
  late final PageController _pageController;
  late int _currentPage;

  @override
  void initState() {
    super.initState();
    _currentPage = widget.initialPageIndex;
    _pageController = PageController(initialPage: _currentPage);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onGoLiveTap() {
    AutomationLiveDialog.show(
      context,
      onOkay: () {
        Navigator.of(context).pop();
        Get.to(
          () => const AutomationDashboardScreen(
            automationType: 'story',
            isDm: false,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final String displayImage =
        (widget.storyImage != null && widget.storyImage!.isNotEmpty)
        ? widget.storyImage!
        : 'assets/images/girl_image.png';

    final String displayName = widget.username ?? 'Richa';

    final String displayKeyword =
        (widget.keyword != null && widget.keyword!.trim().isNotEmpty)
        ? widget.keyword!.trim().split(',').first.trim()
        : 'Link';

    final String displayOpeningText =
        (widget.openingMessageText != null &&
            widget.openingMessageText!.trim().isNotEmpty)
        ? widget.openingMessageText!
        : "Thanks a lot for reaching out — really excited to see your interest 🙃You're just one step away from getting everything you need.Tap below and I'll send the details right over 🚀";

    final String displayVisitText = widget.visitProfileText ?? 'Visit Profile';
    final String displayFollowingText =
        widget.followingText ?? 'I’m Following ✅';

    final String displayMessage =
        (widget.message != null && widget.message!.trim().isNotEmpty)
        ? widget.message!
        : 'Hey\nThanks for texting, Here\nis the link';

    final String displayLinkTitle =
        (widget.linkTitle != null && widget.linkTitle!.trim().isNotEmpty)
        ? widget.linkTitle!
        : 'Click Here';

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
                        const SizedBox(width: 10),
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
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 36.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(36),
                          border: Border.all(
                            color: const Color(0xFFC4B5FD),
                            width: 2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(
                                0xFF6B4EFF,
                              ).withValues(alpha: 0.08),
                              blurRadius: 16,
                              spreadRadius: 2,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(34),
                          child: PageView(
                            controller: _pageController,
                            onPageChanged: (index) {
                              setState(() {
                                _currentPage = index;
                              });
                            },
                            physics: const BouncingScrollPhysics(),
                            children: [
                              StoryAutomationSlide1(
                                storyImage: displayImage,
                                username: displayName,
                              ),
                              StoryAutomationSlide2(
                                username: displayName,
                                storyImage: displayImage,
                                keyword: displayKeyword,
                                openingMessageText: displayOpeningText,
                                visitProfileText: displayVisitText,
                                followingText: displayFollowingText,
                                message: displayMessage,
                                linkTitle: displayLinkTitle,
                              ),
                            ],
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
                  const SizedBox(height: 16),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(28, 0, 28, 20),
                    child: GestureDetector(
                      onTap: _onGoLiveTap,
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
