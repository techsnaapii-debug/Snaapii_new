import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../widgets/custom_button.dart';
import 'package:snaapii/widgets/dashed_border_painter.dart';
import 'my_campaign_2_screen.dart';
import 'preview_screen.dart';

class Targeting2Screen extends StatefulWidget {
  const Targeting2Screen({super.key});

  @override
  State<Targeting2Screen> createState() => _Targeting2ScreenState();
}

class _Targeting2ScreenState extends State<Targeting2Screen> {
  File? _selectedImage;
  File? _selectedVideo;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? file = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );
    if (file != null) {
      setState(() {
        _selectedImage = File(file.path);
      });
    }
  }

  Future<void> _pickVideo() async {
    final XFile? file = await _picker.pickVideo(source: ImageSource.gallery);
    if (file != null) {
      setState(() {
        _selectedVideo = File(file.path);
      });
    }
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
        body: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: SizedBox.expand(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 37),

                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
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
                                'Campaign Media',
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
                        const SizedBox(height: 20),

                        const Text(
                          'Step 4 of 4',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF8E8E93),
                          ),
                        ),
                        const SizedBox(height: 12),

                        Row(
                          children: [
                            _buildStepCircle('1', isActive: true),
                            Expanded(
                              child: Container(
                                height: 4,
                                color: const Color(0xFF9E8EFE),
                              ),
                            ),
                            _buildStepCircle('2', isActive: true),
                            Expanded(
                              child: Container(
                                height: 4,
                                color: const Color(0xFF9E8EFE),
                              ),
                            ),
                            _buildStepCircle('3', isActive: true),
                            Expanded(
                              child: Container(
                                height: 4,
                                color: const Color(0xFF9E8EFE),
                              ),
                            ),
                            _buildStepCircle('4', isActive: true),
                          ],
                        ),
                        const SizedBox(height: 12),
                      ],
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const SizedBox(height: 20),

                            _buildUploadCard(
                              title: 'Upload Campaign Image',
                              subtitle: 'Drag & drop or Click to browse file',
                              isImage: true,
                              selectedFile: _selectedImage,
                              onTap: _pickImage,
                            ),
                            const SizedBox(height: 24),

                            _buildUploadCard(
                              title: 'Upload Sample Video',
                              subtitle: 'Drag & drop or Click to browse file',
                              isImage: false,
                              selectedFile: _selectedVideo,
                              onTap: _pickVideo,
                            ),
                            const SizedBox(height: 36),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
                    child: Column(
                      children: [
                        CustomButton(
                          text: 'Save as Draft',
                          width: double.infinity,
                          backgroundColor: const Color(0xFFF9F8FF),
                          textColor: const Color(0xFF000000),
                          onTap: () {
                            MyCampaign2Screen.isDraftSaved = true;
                            Get.to(
                              () =>
                                  const MyCampaign2Screen(initialTab: 'Draft'),
                            );
                          },
                        ),
                        const SizedBox(height: 16),
                        CustomButton(
                          text: 'Preview & Publish',
                          isGradient: true,
                          width: double.infinity,
                          onTap: () {
                            Get.to(() => const PreviewScreen());
                          },
                        ),
                      ],
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

  Widget _buildStepCircle(String step, {required bool isActive}) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive ? const Color(0xFF9E8EFE) : const Color(0xFFEBE8FC),
      ),
      child: Center(
        child: Text(
          step,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildUploadCard({
    required String title,
    required String subtitle,
    required bool isImage,
    required File? selectedFile,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFD6C8FF), width: 1.5),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const Text(
            'Optional',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF666666),
            ),
          ),
          const SizedBox(height: 12),
          CustomPaint(
            painter: DashedBorderPainter(
              color: const Color(0xFFD1D1D6),
              strokeWidth: 1.2,
              dashWidth: 6.0,
              dashGap: 4.0,
              radius: 12.0,
            ),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 28),
              child: Column(
                children: [
                  if (isImage && selectedFile != null) ...[
                    GestureDetector(
                      onTap: onTap,
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.file(
                              selectedFile,
                              width: 120,
                              height: 120,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            selectedFile.path.split('/').last.split('\\').last,
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 11,
                              color: Color(0xFF8E8E93),
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Tap to change',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF9E8EFE),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ] else if (!isImage && selectedFile != null) ...[
                    GestureDetector(
                      onTap: onTap,
                      child: Column(
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              color: const Color(0xFFEDE8FF),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(
                              Icons.videocam_rounded,
                              color: Color(0xFF9E8EFE),
                              size: 40,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            selectedFile.path.split('/').last.split('\\').last,
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 11,
                              color: Color(0xFF8E8E93),
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Tap to change',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF9E8EFE),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ] else ...[
                    GestureDetector(
                      onTap: onTap,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Image.asset(
                            'assets/images/ai_bg.png',
                            width: 95,
                            height: 95,
                            fit: BoxFit.contain,
                          ),
                          Transform.translate(
                            offset: const Offset(-1, -5),
                            child: Image.asset(
                              'assets/images/upload_icon.png',
                              width: 64,
                              height: 64,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      title,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF666666),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 13,
                        color: Color(0xFF8E8E93),
                      ),
                    ),
                    if (isImage) ...[
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0x0A9E8EFE),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: const Color(0x339E8EFE),
                            width: 1.0,
                          ),
                        ),
                        child: const Text(
                          'Recommended: Portrait\n(2:3 ratio), JPG/PNG',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF9E8EFE),
                          ),
                        ),
                      ),
                    ],
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
