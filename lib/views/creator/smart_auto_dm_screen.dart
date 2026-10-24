import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'comment_automation_screen.dart';
import 'dm_automation_screen.dart';
import 'story_automation_screen.dart';
import 'autoreply_automation_screen.dart';
import 'package:snaapii/widgets/creator_widget/live_automation_preview_slides.dart';
import 'package:snaapii/widgets/creator_widget/smart_auto_tab_bar.dart';

class SmartAutoDmScreen extends StatefulWidget {
  final int initialTab;
  const SmartAutoDmScreen({super.key, this.initialTab = 0});

  @override
  State<SmartAutoDmScreen> createState() => _SmartAutoDmScreenState();
}

class _SmartAutoDmScreenState extends State<SmartAutoDmScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  late int _selectedTab;

  final List<String> _tabs = ['Comment', 'DM', 'Story', 'Auto reply'];

  @override
  void initState() {
    super.initState();
    _selectedTab = widget.initialTab;
  }

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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
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
                              'Smart Auto DM',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF6B4EFF),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Image.asset(
                            'assets/images/tutorial_icon.png',
                            height: 40,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),

                  const Text(
                    'Live Automations Preview',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF757575),
                    ),
                  ),
                  const SizedBox(height: 14),

                  SmartAutoTabBar(
                    tabs: _tabs,
                    selectedTab: _selectedTab,
                    onTabSelected: (index) {
                      setState(() {
                        _selectedTab = index;
                        _currentPage = 0;
                      });
                      if (_pageController.hasClients) {
                        _pageController.jumpToPage(0);
                      }
                    },
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
                          child: _selectedTab == 3
                              ? PageView(
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
                                )
                              : _selectedTab == 1
                              ? const LiveAutomationSlide3()
                              : _selectedTab == 2
                              ? PageView(
                                  controller: _pageController,
                                  onPageChanged: (index) {
                                    setState(() {
                                      _currentPage = index;
                                    });
                                  },
                                  children: const [
                                    StoryAutomationSlide1(),
                                    StoryAutomationSlide2(),
                                  ],
                                )
                              : PageView(
                                  controller: _pageController,
                                  onPageChanged: (index) {
                                    setState(() {
                                      _currentPage = index;
                                    });
                                  },
                                  children: const [
                                    LiveAutomationSlide1(),
                                    LiveAutomationSlide2(),
                                    LiveAutomationSlide3(),
                                  ],
                                ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _selectedTab == 1
                          ? 1
                          : ((_selectedTab == 2 || _selectedTab == 3) ? 2 : 3),
                      (index) {
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
                      },
                    ),
                  ),
                  const SizedBox(height: 16),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(28, 0, 28, 20),
                    child: GestureDetector(
                      onTap: () {
                        if (_selectedTab == 0) {
                          Get.to(() => const CreateAutomationScreen());
                        } else if (_selectedTab == 1) {
                          Get.to(() => const DmAutomationScreen());
                        } else if (_selectedTab == 2) {
                          Get.to(() => const StoryAutomationScreen());
                        } else if (_selectedTab == 3) {
                          Get.to(() => const AutoreplyAutomationScreen());
                        }
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
                            'Create Automation',
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
