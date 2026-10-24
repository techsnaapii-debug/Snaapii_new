import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'media_kit_edit_screen.dart';

class MediaKitPreviewScreen extends StatelessWidget {
  final int selectedTemplateIndex;

  const MediaKitPreviewScreen({super.key, this.selectedTemplateIndex = 4});

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

              // Scrollable Content
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 6),

                      // Title & Subtitle (Only Colors.black)
                      const Text(
                        'Preview',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Here is your media kit, you can edit,\ndownload or share it.',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12.5,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                          height: 1.35,
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Preview Card
                      _buildPreviewCard(),

                      const SizedBox(height: 26),

                      // Edit and Share Buttons Row
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () =>
                                  Get.to(() => const MediaKitEditScreen()),
                              child: Container(
                                height: 46,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(23),
                                  border: Border.all(
                                    color: const Color(0xFF5667FF),
                                    width: 1.5,
                                  ),
                                ),
                                child: const Center(
                                  child: Text(
                                    'Edit',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: GestureDetector(
                              onTap: () => _showShareBottomSheet(context),
                              child: Container(
                                height: 46,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(23),
                                  border: Border.all(
                                    color: const Color(0xFF5667FF),
                                    width: 1.5,
                                  ),
                                ),
                                child: const Center(
                                  child: Text(
                                    'Share',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 18),

                      // Download Kit Button
                      GestureDetector(
                        onTap: () => _showDownloadBottomSheet(context),
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
                                color: const Color(
                                  0xFF5667FF,
                                ).withValues(alpha: 0.35),
                                blurRadius: 16,
                                offset: const Offset(0, 6),
                              ),
                            ],
                          ),
                          child: const Center(
                            child: Text(
                              'Download Kit',
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

                      const SizedBox(height: 28),
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

  void _showShareBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (bottomSheetContext) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
          ),
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header with Close Icon
              Stack(
                alignment: Alignment.center,
                children: [
                  Column(
                    children: const [
                      Text(
                        'Share Your Media Kit',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 3),
                      Text(
                        'Share Directoly to your social media',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(bottomSheetContext),
                      behavior: HitTestBehavior.opaque,
                      child: const Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Icon(Icons.close, color: Colors.black, size: 22),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Option 1: Instagram Story
              GestureDetector(
                onTap: () {},
                child: Container(
                  height: 56,
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: const Color(0xFFD1D5DB),
                      width: 1.1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/images/instagram_icon copy.png',
                        width: 30,
                        height: 30,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(
                              Icons.camera_alt,
                              color: Colors.pink,
                              size: 28,
                            ),
                      ),
                      const SizedBox(width: 14),
                      const Text(
                        'Instagram Story',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      const Spacer(),
                      const Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Colors.black,
                        size: 15,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // Option 2: WhatsApp Story
              GestureDetector(
                onTap: () {},
                child: Container(
                  height: 56,
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: const Color(0xFFD1D5DB),
                      width: 1.1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 30,
                        height: 30,
                        decoration: const BoxDecoration(
                          color: Color(0xFF25D366),
                          shape: BoxShape.circle,
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.call,
                            color: Colors.white,
                            size: 17,
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      const Text(
                        'WhatsApp Story',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      const Spacer(),
                      const Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Colors.black,
                        size: 15,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showDownloadBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (bottomSheetContext) {
        return const _DownloadKitBottomSheet();
      },
    );
  }

  Widget _buildPreviewCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 22),
      decoration: BoxDecoration(
        color: const Color(0xFF7044EC),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF7044EC).withValues(alpha: 0.35),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Row: Big Aarohi Sharma Name on Left + Creator Photo on Right
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    SizedBox(height: 8),
                    Text(
                      'Aarohi\nSharma',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        height: 1.15,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      '@aarohi',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      'Lifestyle | fashion',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  'assets/images/girl_image.png',
                  width: 140,
                  height: 140,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: 140,
                    height: 140,
                    color: Colors.white24,
                    child: const Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 50,
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 28),

          // 3-Column Stats with Vertical Separator Lines
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Column 1
              Expanded(
                child: Column(
                  children: const [
                    _MetricItem(value: '33K', label: 'Fallowers'),
                    SizedBox(height: 16),
                    _MetricItem(value: '70K', label: 'Average Like'),
                    SizedBox(height: 16),
                    _MetricItem(
                      value: '₹70K',
                      label: 'Per Reel',
                      isPrice: true,
                    ),
                  ],
                ),
              ),

              // Vertical Divider 1
              Container(
                width: 1,
                height: 145,
                color: Colors.white.withValues(alpha: 0.35),
              ),

              // Column 2
              Expanded(
                child: Column(
                  children: const [
                    _MetricItem(value: '3.9%', label: 'Engagement'),
                    SizedBox(height: 16),
                    _MetricItem(value: '4456', label: 'Average Comments'),
                    SizedBox(height: 16),
                    _MetricItem(
                      value: '₹70K',
                      label: 'Per Story',
                      isPrice: true,
                    ),
                  ],
                ),
              ),

              // Vertical Divider 2
              Container(
                width: 1,
                height: 145,
                color: Colors.white.withValues(alpha: 0.35),
              ),

              // Column 3
              Expanded(
                child: Column(
                  children: const [
                    _MetricItem(value: '446K', label: 'Avg. views'),
                    SizedBox(height: 16),
                    _MetricItem(value: '90', label: 'Share'),
                    SizedBox(height: 16),
                    _MetricItem(
                      value: '₹70K',
                      label: 'Per Post',
                      isPrice: true,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
        ],
      ),
    );
  }
}

class _MetricItem extends StatelessWidget {
  final String value;
  final String label;
  final bool isPrice;

  const _MetricItem({
    required this.value,
    required this.label,
    this.isPrice = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isPrice) {
      return Column(
        children: [
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 10,
              fontWeight: FontWeight.w400,
              color: Colors.white.withValues(alpha: 0.9),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ],
      );
    }

    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 10,
            fontWeight: FontWeight.w400,
            color: Colors.white.withValues(alpha: 0.9),
          ),
        ),
      ],
    );
  }
}

class _DownloadKitBottomSheet extends StatefulWidget {
  const _DownloadKitBottomSheet();

  @override
  State<_DownloadKitBottomSheet> createState() =>
      _DownloadKitBottomSheetState();
}

class _DownloadKitBottomSheetState extends State<_DownloadKitBottomSheet> {
  int _sheetState = 0; // 0: Choose Format, 1: Preparing, 2: Ready
  int _selectedFormat = -1; // 0: PDF, 1: JPG
  int _progress = 0;
  Timer? _timer;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _onFormatSelected(int format) {
    if (_sheetState != 0) return;
    setState(() {
      _selectedFormat = format;
    });

    // Brief delay to show active checkmark, then start preparing
    Future.delayed(const Duration(milliseconds: 300), () {
      if (!mounted) return;
      setState(() {
        _sheetState = 1;
        _progress = 0;
      });

      // Progress from 0% to 100% in ~2.5 seconds (25ms * 100 = 2500ms)
      _timer = Timer.periodic(const Duration(milliseconds: 25), (timer) {
        if (!mounted) {
          timer.cancel();
          return;
        }
        setState(() {
          if (_progress < 100) {
            _progress++;
          } else {
            timer.cancel();
            _sheetState = 2; // Media Kit Ready!
          }
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_sheetState == 1) {
      return _buildPreparingState();
    } else if (_sheetState == 2) {
      return _buildReadyState();
    }
    return _buildChooseFormatState();
  }

  // 1. Choose Format State
  Widget _buildChooseFormatState() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(28),
          topRight: Radius.circular(28),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 42),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header: Centered Title + Close Icon
          Stack(
            alignment: Alignment.center,
            children: [
              const Center(
                child: Text(
                  'Choose Format',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  behavior: HitTestBehavior.opaque,
                  child: const Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Icon(Icons.close, color: Colors.black, size: 26),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 26),

          // 2 Format Option Cards Row
          Row(
            children: [
              // PDF Option Card
              Expanded(
                child: GestureDetector(
                  onTap: () => _onFormatSelected(0),
                  child: Container(
                    height: 134,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 14,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: _selectedFormat == 0
                            ? const Color(0xFF6B4EFF)
                            : const Color(0xFFD1D5DB),
                        width: _selectedFormat == 0 ? 1.8 : 1.2,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 28,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              _buildPdfIcon(),
                              const SizedBox(width: 8),
                              const Text(
                                'PDF',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black,
                                ),
                              ),
                              const Spacer(),
                              _buildFormatIndicator(_selectedFormat == 0),
                            ],
                          ),
                        ),
                        const SizedBox(height: 14),
                        const Text(
                          'Best for shareing with brands',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                            height: 1.25,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 14),

              // JPG Option Card
              Expanded(
                child: GestureDetector(
                  onTap: () => _onFormatSelected(1),
                  child: Container(
                    height: 134,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 14,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: _selectedFormat == 1
                            ? const Color(0xFF6B4EFF)
                            : const Color(0xFFD1D5DB),
                        width: _selectedFormat == 1 ? 1.8 : 1.2,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 28,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/gallery_icon.png',
                                width: 26,
                                height: 26,
                                fit: BoxFit.contain,
                              ),
                              const SizedBox(width: 8),
                              const Text(
                                'JPG',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black,
                                ),
                              ),
                              const Spacer(),
                              _buildFormatIndicator(_selectedFormat == 1),
                            ],
                          ),
                        ),
                        const SizedBox(height: 14),
                        const Text(
                          'High quality image For Social media',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                            height: 1.25,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // 2. Preparing State (0% - 100%)
  Widget _buildPreparingState() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(28),
          topRight: Radius.circular(28),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Close button at top right
          Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              behavior: HitTestBehavior.opaque,
              child: const Padding(
                padding: EdgeInsets.all(4.0),
                child: Icon(Icons.close, color: Colors.black, size: 26),
              ),
            ),
          ),

          const SizedBox(height: 10),

          // Circular progress indicator with percentage
          SizedBox(
            width: 120,
            height: 120,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 120,
                  height: 120,
                  child: CircularProgressIndicator(
                    value: _progress / 100.0,
                    strokeWidth: 12,
                    backgroundColor: const Color(0xFFE5E7EB),
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      Color(0xFF5667FF),
                    ),
                    strokeCap: StrokeCap.round,
                  ),
                ),
                Text(
                  '$_progress%',
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 28),

          // Title
          const Text(
            'Preparing your Media Kit',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),

          const SizedBox(height: 8),

          // Subtitle
          Text(
            'Please wait  while  we generate\nyour high quality ${_selectedFormat == 0 ? "PDF" : "JPG"}.',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.black,
              height: 1.35,
            ),
          ),
        ],
      ),
    );
  }

  // 3. Media Kit Ready! State
  Widget _buildReadyState() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(28),
          topRight: Radius.circular(28),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Close button at top right
          Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              behavior: HitTestBehavior.opaque,
              child: const Padding(
                padding: EdgeInsets.all(4.0),
                child: Icon(Icons.close, color: Colors.black, size: 26),
              ),
            ),
          ),

          const SizedBox(height: 14),

          // Green circle with checkmark
          Container(
            width: 86,
            height: 86,
            decoration: const BoxDecoration(
              color: Color(0xFF4CAF50),
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Icon(Icons.check, color: Colors.white, size: 50),
            ),
          ),

          const SizedBox(height: 26),

          // Title
          const Text(
            'Media Kit Ready!',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),

          const SizedBox(height: 8),

          // Subtitle
          const Text(
            'Your media kit has been\nsuccesfully download',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.black,
              height: 1.35,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPdfIcon() {
    return Image.asset(
      'assets/images/pdf_icon.png',
      width: 26,
      height: 26,
      fit: BoxFit.contain,
    );
  }

  Widget _buildFormatIndicator(bool isSelected) {
    if (isSelected) {
      return Container(
        width: 22,
        height: 22,
        decoration: const BoxDecoration(
          color: Color(0xFF5667FF),
          shape: BoxShape.circle,
        ),
        child: const Center(
          child: Icon(Icons.check, color: Colors.white, size: 14),
        ),
      );
    }
    return Container(
      width: 22,
      height: 22,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.black, width: 2),
      ),
    );
  }
}
