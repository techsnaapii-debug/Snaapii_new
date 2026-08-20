import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'story_preview2_screen.dart';

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
  });

  @override
  State<StoryPreviewScreen> createState() => _StoryPreviewScreenState();
}

class _StoryPreviewScreenState extends State<StoryPreviewScreen> {
  @override
  Widget build(BuildContext context) {
    final String displayImage =
        (widget.storyImage != null && widget.storyImage!.isNotEmpty)
        ? widget.storyImage!
        : 'assets/images/girl_image.png';

    final String displayName = widget.username ?? 'Richa';

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
                  const SizedBox(height: 20),

                  Expanded(
                    child: Center(
                      child: Container(
                        width: 275,
                        height: 490,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(32),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.15),
                              blurRadius: 18,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(32),
                          child: Stack(
                            children: [
                              Positioned(
                                top: 90,
                                left: 0,
                                right: 0,
                                bottom: 24,
                                child: widget.selectedFile != null
                                    ? Image.file(
                                        widget.selectedFile!,
                                        fit: BoxFit.cover,
                                      )
                                    : Image.asset(
                                        displayImage,
                                        fit: BoxFit.cover,
                                      ),
                              ),

                              Positioned(
                                top: 0,
                                left: 0,
                                right: 0,
                                height: 95,
                                child: Container(
                                  color: Colors.black,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 14,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 10),

                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            '10:20',
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 11,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(
                                                Icons.signal_cellular_alt,
                                                color: Colors.white,
                                                size: 13,
                                              ),
                                              const SizedBox(width: 4),

                                              Icon(
                                                Icons.wifi,
                                                color: Colors.white,
                                                size: 13,
                                              ),
                                              const SizedBox(width: 4),

                                              Icon(
                                                Icons.battery_full,
                                                color: Colors.white,
                                                size: 14,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),

                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(2),
                                        child: Container(
                                          height: 2.5,
                                          color: Colors.white,
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: FractionallySizedBox(
                                              widthFactor: 0.45,
                                              child: Container(
                                                color: const Color(0xFFE11D48),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 10),

                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: 28,
                                            height: 28,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                color: Colors.white,
                                                width: 1.0,
                                              ),
                                              image: const DecorationImage(
                                                image: AssetImage(
                                                  'assets/images/girl_image.png',
                                                ),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            displayName,
                                            style: const TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                height: 24,
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.vertical(
                                      bottom: Radius.circular(32),
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
                  const SizedBox(height: 20),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 0, 24, 20),
                    child: GestureDetector(
                      onTap: () {
                        Get.to(
                          () => StoryPreview2Screen(
                            storyImage: widget.storyImage,
                            selectedFile: widget.selectedFile,
                            username: widget.username,
                            automationName: widget.automationName,
                            keyword: widget.keyword,
                            message: widget.message,
                            openingMessageText: widget.openingMessageText,
                            visitProfileText: widget.visitProfileText,
                            followingText: widget.followingText,
                            linkTitle: widget.linkTitle,
                            linkUrl: widget.linkUrl,
                          ),
                        );
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
