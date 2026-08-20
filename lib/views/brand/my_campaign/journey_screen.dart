import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../widgets/custom_button.dart';
import 'create_account_screen.dart';

class JourneyScreen extends StatelessWidget {
  const JourneyScreen({super.key});

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

                  SafeArea(
                    top: true,
                    bottom: false,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 16),

                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.32,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 25.0,
                                vertical: 20.0,
                              ),
                              child: Image.asset(
                                'assets/images/bancy.png',
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),

                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.03,
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24.0,
                            ),
                            child: Text(
                              'Choose Your Journey',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 27,
                                fontWeight: FontWeight.w500,
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
                              'Select your role to unlock the right\nfeatures, tools, and opportunities with\nSnaapii.',
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

                          const SizedBox(height: 48),

                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 56.0,
                            ),
                            child: Column(
                              children: [
                                CustomButton(
                                  text: "I'm a creator",
                                  width: 263.0,
                                  backgroundColor: Colors.white,
                                  fontSize: 16,
                                  onTap: () {
                                    Get.to(
                                      () => const CreateAccountScreen(
                                        isCreator: true,
                                      ),
                                    );
                                  },
                                ),

                                const SizedBox(height: 25),

                                CustomButton(
                                  text: "I'm a Brand",
                                  width: 263.0,
                                  isGradient: true,
                                  fontSize: 16,
                                  onTap: () {
                                    Get.to(
                                      () => const CreateAccountScreen(
                                        isCreator: false,
                                      ),
                                    );
                                  },
                                ),

                                const SizedBox(height: 25),

                                CustomButton(
                                  text: "I'm a Agency",
                                  width: 263.0,
                                  backgroundColor: const Color(0xFFF9F8FF),
                                  fontSize: 16,
                                  onTap: () {
                                    Get.to(
                                      () => const CreateAccountScreen(
                                        isCreator: false,
                                      ),
                                    );
                                  },
                                ),

                                const SizedBox(height: 32),
                              ],
                            ),
                          ),
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
