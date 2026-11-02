import 'dart:io';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'media_kit_template_screen.dart';

class MediaKitAnalysisScreen extends StatefulWidget {
  const MediaKitAnalysisScreen({super.key});

  @override
  State<MediaKitAnalysisScreen> createState() => _MediaKitAnalysisScreenState();
}

class _MediaKitAnalysisScreenState extends State<MediaKitAnalysisScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _progressAnimation;

  bool _isChecking = true;
  bool _hasInternet = true;

  final List<String> _steps = [
    'Fetching your profile data',
    'Analyzing engagement',
    'Calculating pricing',
    'Preparing your Media Kit',
  ];

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3800),
    );

    _progressAnimation =
        Tween<double>(begin: 0.0, end: 100.0).animate(
          CurvedAnimation(parent: _controller, curve: Curves.easeInOutCubic),
        )..addListener(() {
          setState(() {});
        });

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(const Duration(milliseconds: 600), () {
          if (mounted) {
            Get.off(
              () => const MediaKitTemplateScreen(),
              transition: Transition.fadeIn,
              duration: const Duration(milliseconds: 350),
            );
          }
        });
      }
    });

    _checkConnectionAndStart();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
      _controller.reset();
      _controller.forward();
    } else {
      setState(() {
        _hasInternet = false;
        _isChecking = false;
      });
    }
  }

  int get _currentProgress => _progressAnimation.value.toInt();

  bool _isStepCompleted(int index) {
    // 0: >= 25%, 1: >= 50%, 2: >= 75%, 3: >= 100%
    final thresholds = [25, 50, 75, 100];
    return _progressAnimation.value >= thresholds[index];
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
                        padding: EdgeInsets.symmetric(
                          vertical: 4.0,
                          horizontal: 2.0,
                        ),
                        child: Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: Color(0xFF6B4EFF),
                          size: 20,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      'Media Kit',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF6B4EFF),
                      ),
                    ),
                  ],
                ),
              ),

              // Content based on Internet Connection
              if (!_hasInternet)
                _buildNoInternetView()
              else if (_isChecking)
                const Expanded(
                  child: Center(
                    child: CircularProgressIndicator(color: Color(0xFF6B4EFF)),
                  ),
                )
              else
                _buildAnalysisView(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAnalysisView() {
    return Expanded(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 14),

            // Title & Subtitle
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Analyzing Your\nInstagram',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 26,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      height: 1.25,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'PLease wait while we fetch and\nanalyze your latest data.',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                      height: 1.35,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            // Circular Progress Indicator with Percentage
            Center(
              child: SizedBox(
                width: 170,
                height: 170,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CustomPaint(
                      size: const Size(170, 170),
                      painter: _CircularProgressPainter(
                        progressPercent: _progressAnimation.value / 100.0,
                      ),
                    ),
                    Text(
                      '$_currentProgress%',
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 26,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 50),

            // Analysis Steps Checklist
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28.0),
              child: Column(
                children: List.generate(_steps.length, (index) {
                  final isCompleted = _isStepCompleted(index);
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 22.0),
                    child: Row(
                      children: [
                        // Status Circle
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          width: 22,
                          height: 22,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isCompleted
                                ? const Color(0xFF2E24E6)
                                : Colors.transparent,
                            border: isCompleted
                                ? null
                                : Border.all(
                                    color: const Color(0xFF9EBAFD),
                                    width: 1.8,
                                  ),
                          ),
                          child: isCompleted
                              ? const Center(
                                  child: Icon(
                                    Icons.check,
                                    color: Colors.white,
                                    size: 14,
                                  ),
                                )
                              : null,
                        ),
                        const SizedBox(width: 16),

                        // Step Label
                        Expanded(
                          child: Text(
                            _steps[index],
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
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
              const SizedBox(height: 40),

              // Stylized Wifi Error Graphic
              CustomPaint(
                size: const Size(90, 80),
                painter: _NoInternetIconPainter(),
              ),

              const SizedBox(height: 28),

              // Error Text (Only black)
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

              const SizedBox(height: 70),

              // Try Again Button
              GestureDetector(
                onTap: _isChecking ? null : _checkConnectionAndStart,
                child: Container(
                  width: double.infinity,
                  height: 52,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(26),
                    gradient: const LinearGradient(
                      colors: [Color(0xFFB575FF), Color(0xFF5667FF)],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF5667FF).withValues(alpha: 0.35),
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

              const SizedBox(height: 40),
            ],
          ),
        ),
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

    // Outer left arc (bowing outwards and downwards)
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

class _CircularProgressPainter extends CustomPainter {
  final double progressPercent;

  _CircularProgressPainter({required this.progressPercent});

  @override
  void paint(Canvas canvas, Size size) {
    const strokeWidth = 24.0;
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    // Background grey track
    final trackPaint = Paint()
      ..color = const Color(0xFFE5E7EB)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.butt;

    canvas.drawCircle(center, radius, trackPaint);

    // Foreground active purple/blue progress
    if (progressPercent > 0) {
      final progressPaint = Paint()
        ..color = const Color(0xFF4F46E5)
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.butt;

      const startAngle = -math.pi / 2;
      final sweepAngle = 2 * math.pi * progressPercent.clamp(0.0, 1.0);

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        false,
        progressPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _CircularProgressPainter oldDelegate) {
    return oldDelegate.progressPercent != progressPercent;
  }
}
