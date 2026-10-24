import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../controllers/onboarding_controller.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnboardingController());

    final List<Map<String, String>> onboardingData = [
      {
        'image': 'assets/images/onboard_1.png',
        'title': 'Earn from Content',
        'subtitle':
            'Paid campaigns, creator services, and\ndirect brand opportunities to grow\nyour income faster.',
      },
      {
        'image': 'assets/images/onboard_2.png',
        'title': 'Grow with AI',
        'subtitle':
            'Smart tools, trends, analytics, and\nautomation designed for faster\ncreator and brand growth.',
      },
      {
        'image': 'assets/images/onboard_3.png',
        'title': 'Safe & Powerful',
        'subtitle':
            'Secure payments, trusted\ncollaborations, verified users, and\neverything in one powerful platform.',
      },
    ];

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
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Image.asset(
                    'assets/images/onboard_bg.png',
                    fit: BoxFit.fitWidth,
                  ),
                ),

                Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.68,
                      child: PageView.builder(
                        controller: controller.pageController,
                        onPageChanged: controller.onPageChanged,
                        itemCount: onboardingData.length,
                        itemBuilder: (context, index) {
                          return SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.12,
                                ),

                                if (onboardingData[index]['image'] != null &&
                                    onboardingData[index]['image']!.isNotEmpty)
                                  SizedBox(
                                    height:
                                        MediaQuery.of(context).size.height *
                                        0.32,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 24.0,
                                        vertical: 16.0,
                                      ),
                                      child: Image.asset(
                                        onboardingData[index]['image']!,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.02,
                                ),

                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 24.0,
                                  ),
                                  child: Text(
                                    onboardingData[index]['title']!,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 32,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF1E1A34),
                                      height: 1.2,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16),

                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 24.0,
                                  ),
                                  child: Text(
                                    onboardingData[index]['subtitle']!,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black,
                                      height: 1.5,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 24),

                    Obx(
                      () => Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          onboardingData.length,
                          (index) => AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            height: 8,
                            width: controller.currentPage.value == index
                                ? 8
                                : 8,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: controller.currentPage.value == index
                                  ? const Color(0xFF9E8EFE)
                                  : const Color(0xFFEBE8FC),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 80),

                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24.0,
                        vertical: 24.0,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 49,
                              child: OutlinedButton(
                                onPressed: controller.skipPage,
                                style: OutlinedButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  side: const BorderSide(
                                    color: Color(0xFFEBE8FC),
                                    width: 1.5,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                                child: Text(
                                  'Skip',
                                  style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF1E1A34),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 48),

                          Expanded(
                            child: Container(
                              height: 49,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFFB18CFF),
                                    Color(0xFF565EFA),
                                  ],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(
                                      0xFF565EFA,
                                    ).withValues(alpha: 0.3),
                                    blurRadius: 10,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Obx(() {
                                final isLast = controller.isLastPage;
                                return ElevatedButton(
                                  onPressed: controller.nextPage,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    shadowColor: Colors.transparent,
                                    padding: EdgeInsets.zero,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                  ),
                                  child: Text(
                                    isLast ? 'Get Started' : 'Next',
                                    style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
