import 'dart:io';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'collab_charges2_screen.dart';

class StepData {
  final String title;
  final String subtitle;
  final IconData icon;

  const StepData({
    required this.title,
    required this.subtitle,
    required this.icon,
  });
}

class CollabChargesInsightScreen extends StatefulWidget {
  const CollabChargesInsightScreen({super.key});

  @override
  State<CollabChargesInsightScreen> createState() =>
      _CollabChargesInsightScreenState();
}

class _CollabChargesInsightScreenState
    extends State<CollabChargesInsightScreen> {
  int _currentStep = 0;
  final Set<int> _verifiedSteps = {};
  bool _isNavigating = false;
  bool _isChecking = true;
  bool _hasInternet = true;

  final List<StepData> _steps = const [
    StepData(
      title: 'Fetching your instagram reels',
      subtitle: 'Retriving your recent reel insight',
      icon: Icons.smart_display_outlined,
    ),
    StepData(
      title: 'Reviewing reel performance',
      subtitle: 'Checking views, reach & audience',
      icon: Icons.bar_chart_rounded,
    ),
    StepData(
      title: 'Calculting average reach',
      subtitle: 'Processing your overall reach...',
      icon: Icons.show_chart_rounded,
    ),
    StepData(
      title: 'Checking engagement rate',
      subtitle: 'Reviviewing likes comments...',
      icon: Icons.trending_up_rounded,
    ),
    StepData(
      title: 'Assessing audience quality',
      subtitle: 'Evaluating audience authenticity',
      icon: Icons.groups_rounded,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _checkConnectionAndStart();
  }

  Future<void> _checkConnectionAndStart() async {
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

    if (connected) {
      setState(() {
        _hasInternet = true;
        _isChecking = false;
      });
      _startVerification();
    } else {
      setState(() {
        _hasInternet = false;
        _isChecking = false;
      });
    }
  }

  Future<void> _startVerification() async {
    // Initial short delay before step 1 starts
    await Future.delayed(const Duration(milliseconds: 400));

    for (int i = 0; i < _steps.length; i++) {
      if (!mounted) return;
      setState(() {
        _currentStep = i;
      });

      // Verification active duration for each step
      await Future.delayed(const Duration(milliseconds: 900));
      if (!mounted) return;

      setState(() {
        _verifiedSteps.add(i);
      });

      // Brief pause between completing current step and starting next step
      await Future.delayed(const Duration(milliseconds: 350));
    }

    // All steps verified!
    await Future.delayed(const Duration(milliseconds: 600));
    if (!mounted || _isNavigating) return;
    _isNavigating = true;

    Get.off(
      () => const CollabCharges2Screen(),
      transition: Transition.fadeIn,
      duration: const Duration(milliseconds: 350),
    );
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                // Content
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 8.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 8),

                        // Headline
                        const Text(
                          'Working on\nyour insight',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                            color: Colors.black,
                            height: 1.2,
                          ),
                        ),

                        const SizedBox(height: 10),

                        // Subtitle
                        const Text(
                          'Our AI analysing your recent Reels\nperfomance and audience data',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 13.5,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF222222),
                            height: 1.4,
                          ),
                        ),

                        const SizedBox(height: 28),

                        // Steps Timeline
                        for (int i = 0; i < _steps.length; i++) ...[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              _buildStepIndicator(i),
                              const SizedBox(width: 14),
                              Expanded(child: _buildStepCard(_steps[i], i)),
                            ],
                          ),
                          if (i < _steps.length - 1)
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 14.0),
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 350),
                                  width: 2.5,
                                  height: 20,
                                  color: _verifiedSteps.contains(i)
                                      ? const Color(0xFF0EA357)
                                      : const Color(0xFFD5D5D5),
                                ),
                              ),
                            ),
                        ],

                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
            ],
          ),
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
                  onTap: _isChecking ? null : _checkConnectionAndStart,
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

  Widget _buildStepIndicator(int index) {
    final bool isCompleted = _verifiedSteps.contains(index);
    final bool isCurrent = _currentStep == index && !isCompleted;

    return SizedBox(
      width: 30,
      height: 30,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (child, animation) {
          return ScaleTransition(scale: animation, child: child);
        },
        child: isCompleted
            ? Container(
                key: ValueKey('completed_$index'),
                width: 30,
                height: 30,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF0EA357),
                ),
                child: const Icon(Icons.check, color: Colors.white, size: 19),
              )
            : isCurrent
            ? Stack(
                key: ValueKey('current_$index'),
                alignment: Alignment.center,
                children: [
                  CustomPaint(
                    size: const Size(30, 30),
                    painter: DashedCirclePainter(
                      color: const Color(0xFF0EA357),
                      dashCount: 12,
                      strokeWidth: 2.0,
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                    height: 15,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Color(0xFF0EA357),
                      ),
                    ),
                  ),
                ],
              )
            : CustomPaint(
                key: ValueKey('pending_$index'),
                size: const Size(30, 30),
                painter: DashedCirclePainter(
                  color: const Color(0xFF9E9E9E),
                  dashCount: 12,
                  strokeWidth: 2.0,
                ),
              ),
      ),
    );
  }

  Widget _buildStepCard(StepData step, int index) {
    final bool isCurrent =
        _currentStep == index && !_verifiedSteps.contains(index);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: isCurrent ? const Color(0xFFBA8BFF) : const Color(0xFFE5E7EB),
          width: isCurrent ? 1.4 : 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: isCurrent
                ? const Color(0xFF5E65FF).withValues(alpha: 0.1)
                : Colors.black.withValues(alpha: 0.04),
            blurRadius: isCurrent ? 12 : 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: const Color(0xFFF3EFFF),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Center(
              child: Icon(step.icon, color: const Color(0xFF8B5CF6), size: 24),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  step.title,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1E1A34),
                    height: 1.25,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  step.subtitle,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 11.5,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF6B7280),
                    height: 1.2,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DashedCirclePainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final int dashCount;

  DashedCirclePainter({
    required this.color,
    this.strokeWidth = 2.0,
    this.dashCount = 12,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final radius = size.width / 2;
    final center = Offset(size.width / 2, size.height / 2);
    final circumference = 2 * math.pi * radius;
    final dashLength = circumference / (dashCount * 2);

    for (int i = 0; i < dashCount; i++) {
      final startAngle = (i * 2 * dashLength) / radius;
      final sweepAngle = dashLength / radius;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant DashedCirclePainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.dashCount != dashCount;
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
