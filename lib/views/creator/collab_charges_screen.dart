import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'collab_charges_insight_screen.dart';

class CollabChargesScreen extends StatefulWidget {
  const CollabChargesScreen({super.key});

  @override
  State<CollabChargesScreen> createState() => _CollabChargesScreenState();
}

class _CollabChargesScreenState extends State<CollabChargesScreen> {
  bool _isChecking = true;
  bool _hasInternet = true;

  @override
  void initState() {
    super.initState();
    _checkConnection();
  }

  Future<void> _checkConnection() async {
    setState(() {
      _isChecking = true;
    });

    bool connected = false;
    try {
      final lookup = await InternetAddress.lookup(
        'google.com',
      ).timeout(const Duration(seconds: 3));
      if (lookup.isNotEmpty && lookup[0].rawAddress.isNotEmpty) {
        connected = true;
      }
    } catch (_) {
      connected = false;
    }

    if (!mounted) return;

    setState(() {
      _hasInternet = connected;
      _isChecking = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Top Bar
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 12.0,
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Get.back(),
                    behavior: HitTestBehavior.opaque,
                    child: const Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Icon(
                        Icons.arrow_back_ios_new,
                        color: Color(0xFF6B4EFF),
                        size: 22,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Collab Charges',
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

            if (_isChecking && _hasInternet)
              const Expanded(
                child: Center(
                  child: CircularProgressIndicator(color: Color(0xFF6B4EFF)),
                ),
              )
            else if (!_hasInternet)
              _buildNoInternetView()
            else
              // Scrollable Content
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      const SizedBox(height: 6),

                      // Subtitle / Tagline
                      const Text(
                        'Collab Rate Estimator',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF6B4EFF),
                        ),
                      ),
                      const SizedBox(height: 6),

                      // Headline
                      const Text(
                        'Find Your\ncreator Value',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          color: Colors.black,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Description
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.0),
                        child: Text(
                          'See how much you can charge for a reel based\non your instagram perfomence',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                            height: 1.35,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),

                      // 3D Illustration Graphic
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: Image.asset(
                          'assets/images/collab_charges_illustration.png',
                          height: 135,
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Feature List Card
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20.0),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 14.0,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: const Color(
                              0xFF1E1A34,
                            ).withValues(alpha: 0.85),
                            width: 1.2,
                          ),
                        ),
                        child: Column(
                          children: [
                            _buildFeatureRow(
                              iconWidget: const Text(
                                '₹',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF9E8EFE),
                                ),
                              ),
                              title: 'Smart pricing',
                            ),
                            const Divider(
                              color: Color(0xFFEBEBEB),
                              height: 18,
                              thickness: 1,
                            ),
                            _buildFeatureRow(
                              iconWidget: const Icon(
                                Icons.bar_chart_rounded,
                                color: Color(0xFF9E8EFE),
                                size: 22,
                              ),
                              title: 'Reel Performance',
                            ),
                            const Divider(
                              color: Color(0xFFEBEBEB),
                              height: 18,
                              thickness: 1,
                            ),
                            _buildFeatureRow(
                              iconWidget: const Icon(
                                Icons.auto_awesome,
                                color: Color(0xFF9E8EFE),
                                size: 19,
                              ),
                              title: 'Ai Negotiate',
                            ),
                            const Divider(
                              color: Color(0xFFEBEBEB),
                              height: 18,
                              thickness: 1,
                            ),
                            _buildFeatureRow(
                              iconWidget: const Icon(
                                Icons.groups_rounded,
                                color: Color(0xFF9E8EFE),
                                size: 20,
                              ),
                              title: 'Audience quality',
                            ),
                            const Divider(
                              color: Color(0xFFEBEBEB),
                              height: 18,
                              thickness: 1,
                            ),
                            _buildFeatureRow(
                              iconWidget: const Icon(
                                Icons.badge_outlined,
                                color: Color(0xFF9E8EFE),
                                size: 20,
                              ),
                              title: 'Professional rate card',
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Get My Estimate Button
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: GestureDetector(
                          onTap: () =>
                              Get.to(() => const CollabChargesInsightScreen()),
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              gradient: const LinearGradient(
                                colors: [Color(0xFFBA8BFF), Color(0xFF5E65FF)],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(
                                    0xFF5E65FF,
                                  ).withValues(alpha: 0.35),
                                  blurRadius: 14,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: const Center(
                              child: Text(
                                'Get My Estimate',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildNoInternetView() {
    return Expanded(
      child: Center(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 28.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 30),

              // Stylized Wifi Error Graphic
              CustomPaint(
                size: const Size(90, 80),
                painter: _NoInternetIconPainter(),
              ),

              const SizedBox(height: 28),

              // Error Text
              const Text(
                'Oops!Something\nwent wrong',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                  height: 1.25,
                ),
              ),

              const SizedBox(height: 50),

              // Try Again Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: GestureDetector(
                  onTap: _isChecking ? null : _checkConnection,
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      gradient: const LinearGradient(
                        colors: [Color(0xFFBA8BFF), Color(0xFF5E65FF)],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(
                            0xFF5E65FF,
                          ).withValues(alpha: 0.35),
                          blurRadius: 16,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (_isChecking)
                          const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white,
                              ),
                            ),
                          )
                        else ...[
                          const Icon(
                            Icons.refresh_rounded,
                            color: Colors.white,
                            size: 24,
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'Try Again',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureRow({required Widget iconWidget, required String title}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFF3EFFF),
            ),
            child: Center(child: iconWidget),
          ),
          const SizedBox(width: 14),
          Text(
            title,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

class _NoInternetIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final strokePaint = Paint()
      ..color = const Color(0xFF8B5CF6)
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final dotPaint = Paint()
      ..color = const Color(0xFF8B5CF6)
      ..style = PaintingStyle.fill;

    final cx = size.width / 2;

    // Center vertical line
    canvas.drawLine(Offset(cx, 12), Offset(cx, 55), strokePaint);

    // Center bottom dot
    canvas.drawCircle(Offset(cx, 68), 2.0, dotPaint);

    // Left and Right dots
    canvas.drawCircle(Offset(cx - 15, 52), 1.6, dotPaint);
    canvas.drawCircle(Offset(cx + 15, 52), 1.6, dotPaint);

    // Outer left arc
    final outerLeft = Path()
      ..moveTo(cx - 8, 12)
      ..quadraticBezierTo(cx - 30, 14, cx - 42, 26);
    canvas.drawPath(outerLeft, strokePaint);

    // Outer right arc
    final outerRight = Path()
      ..moveTo(cx + 8, 12)
      ..quadraticBezierTo(cx + 30, 14, cx + 42, 26);
    canvas.drawPath(outerRight, strokePaint);

    // Inner left arc
    final innerLeft = Path()
      ..moveTo(cx - 8, 32)
      ..quadraticBezierTo(cx - 22, 34, cx - 30, 44);
    canvas.drawPath(innerLeft, strokePaint);

    // Inner right arc
    final innerRight = Path()
      ..moveTo(cx + 8, 32)
      ..quadraticBezierTo(cx + 22, 34, cx + 30, 44);
    canvas.drawPath(innerRight, strokePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
