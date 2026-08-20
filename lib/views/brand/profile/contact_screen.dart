import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
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
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
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
                            child: const Icon(
                              Icons.arrow_back_ios_new,
                              color: Color(0xFF6B4EFF),
                              size: 22,
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'Contact',
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

                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        'you can get in touch with us through below platforms our team will reach out to you as soon as it would be possible.',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 13,
                          color: Color(0xFF9E9E9E),
                          height: 1.4,
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: _buildContactSectionCard(
                        title: 'Support',
                        children: [
                          _buildContactRow(
                            iconWidget: _buildMailIcon(),
                            text: 'support@snaapii.com',
                          ),
                          const SizedBox(height: 16),
                          _buildContactRow(
                            iconWidget: _buildMailIcon(),
                            text: 'business@snaapii.com',
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: _buildContactSectionCard(
                        title: 'Social Media',
                        children: [
                          _buildContactRow(
                            iconWidget: Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                color: const Color(0xFFBA8FFF),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: const Center(
                                child: Text(
                                  'in',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            text: '@snaapii',
                          ),
                          const SizedBox(height: 16),
                          _buildContactRow(
                            iconWidget: Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                color: const Color(0xFFBA8FFF),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Center(
                                child: Image.asset(
                                  'assets/images/instagram_icon.png',
                                  width: 17,
                                  height: 17,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            text: '@snaapii',
                          ),
                          const SizedBox(height: 16),
                          _buildContactRow(
                            iconWidget: Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                color: const Color(0xFFBA8FFF),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Center(
                                child: CustomPaint(
                                  size: const Size(16, 16),
                                  painter: const _TwitterBirdPainter(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            text: '@snaapii',
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 60),

                    const Center(
                      child: Text(
                        'SNAAPII',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFFD5CEEA),
                          letterSpacing: 1.5,
                        ),
                      ),
                    ),

                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContactSectionCard({
    required String title,
    required List<Widget> children,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE0E0E0), width: 1),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 14),
            child: Text(
              title,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.black87,
              ),
            ),
          ),
          const Divider(height: 1, thickness: 1, color: Color(0xFFEEEEEE)),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: children,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactRow({required Widget iconWidget, required String text}) {
    return Row(
      children: [
        SizedBox(width: 32, height: 32, child: Center(child: iconWidget)),
        const SizedBox(width: 16),
        Text(
          text,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 14.5,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  Widget _buildMailIcon() {
    return Container(
      width: 26,
      height: 26,
      decoration: BoxDecoration(
        color: const Color(0xFFF3EFFF),
        borderRadius: BorderRadius.circular(6),
      ),
      child: const Icon(Icons.mail_rounded, size: 16, color: Color(0xFFBA8FFF)),
    );
  }
}

class _TwitterBirdPainter extends CustomPainter {
  final Color color;
  const _TwitterBirdPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();
    double w = size.width;
    double h = size.height;

    path.moveTo(w * 1.0, h * 0.194);
    path.cubicTo(
      w * 0.963,
      h * 0.21,
      w * 0.924,
      h * 0.221,
      w * 0.883,
      h * 0.226,
    );
    path.cubicTo(
      w * 0.925,
      h * 0.201,
      w * 0.957,
      h * 0.161,
      w * 0.972,
      h * 0.113,
    );
    path.cubicTo(
      w * 0.933,
      h * 0.136,
      w * 0.89,
      h * 0.153,
      w * 0.844,
      h * 0.162,
    );
    path.cubicTo(
      w * 0.807,
      h * 0.123,
      w * 0.755,
      h * 0.098,
      w * 0.697,
      h * 0.098,
    );
    path.cubicTo(
      w * 0.585,
      h * 0.098,
      w * 0.495,
      h * 0.188,
      w * 0.495,
      h * 0.3,
    );
    path.cubicTo(
      w * 0.495,
      h * 0.316,
      w * 0.497,
      h * 0.331,
      w * 0.501,
      h * 0.346,
    );
    path.cubicTo(
      w * 0.333,
      h * 0.338,
      w * 0.184,
      h * 0.257,
      w * 0.084,
      h * 0.134,
    );
    path.cubicTo(
      w * 0.066,
      h * 0.164,
      w * 0.056,
      h * 0.199,
      w * 0.056,
      h * 0.237,
    );
    path.cubicTo(
      w * 0.056,
      h * 0.307,
      w * 0.092,
      h * 0.369,
      w * 0.147,
      h * 0.406,
    );
    path.cubicTo(
      w * 0.113,
      h * 0.405,
      w * 0.082,
      h * 0.396,
      w * 0.054,
      h * 0.381,
    );
    path.cubicTo(
      w * 0.054,
      h * 0.382,
      w * 0.054,
      h * 0.383,
      w * 0.054,
      h * 0.384,
    );
    path.cubicTo(
      w * 0.054,
      h * 0.482,
      w * 0.124,
      h * 0.564,
      w * 0.217,
      h * 0.583,
    );
    path.cubicTo(w * 0.2, h * 0.588, w * 0.182, h * 0.59, w * 0.164, h * 0.59);
    path.cubicTo(
      w * 0.151,
      h * 0.59,
      w * 0.139,
      h * 0.589,
      w * 0.127,
      h * 0.587,
    );
    path.cubicTo(
      w * 0.153,
      h * 0.667,
      w * 0.227,
      h * 0.725,
      w * 0.315,
      h * 0.727,
    );
    path.cubicTo(
      w * 0.246,
      h * 0.781,
      w * 0.159,
      h * 0.813,
      w * 0.065,
      h * 0.813,
    );
    path.cubicTo(
      w * 0.049,
      h * 0.813,
      w * 0.033,
      h * 0.812,
      w * 0.017,
      h * 0.81,
    );
    path.cubicTo(
      w * 0.106,
      h * 0.867,
      w * 0.212,
      h * 0.901,
      w * 0.326,
      h * 0.901,
    );
    path.cubicTo(w * 0.697, h * 0.901, w * 0.9, h * 0.594, w * 0.9, h * 0.328);
    path.cubicTo(w * 0.9, h * 0.319, w * 0.9, h * 0.31, w * 0.899, h * 0.302);
    path.cubicTo(
      w * 0.938,
      h * 0.274,
      w * 0.972,
      h * 0.239,
      w * 1.0,
      h * 0.194,
    );
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
