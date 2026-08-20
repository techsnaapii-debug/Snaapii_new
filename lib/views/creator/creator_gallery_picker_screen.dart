import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class GalleryMediaItem {
  final String path;
  final bool isAsset;
  final bool isVideo;

  const GalleryMediaItem({
    required this.path,
    this.isAsset = true,
    this.isVideo = false,
  });
}

class CreatorGalleryPickerScreen extends StatefulWidget {
  const CreatorGalleryPickerScreen({super.key});

  @override
  State<CreatorGalleryPickerScreen> createState() =>
      _CreatorGalleryPickerScreenState();
}

class _CreatorGalleryPickerScreenState
    extends State<CreatorGalleryPickerScreen> {
  final List<GalleryMediaItem> _mediaList = [
    const GalleryMediaItem(
      path: 'assets/images/girl_image.png',
      isAsset: true,
      isVideo: false,
    ),
    const GalleryMediaItem(
      path: 'assets/images/banner_2.jpg',
      isAsset: true,
      isVideo: false,
    ),
    const GalleryMediaItem(
      path: 'assets/images/banner_3.jpg',
      isAsset: true,
      isVideo: false,
    ),
    const GalleryMediaItem(
      path: 'assets/images/bancy.png',
      isAsset: true,
      isVideo: false,
    ),
    const GalleryMediaItem(
      path: 'assets/images/reel_mockup.png',
      isAsset: true,
      isVideo: false,
    ),
    const GalleryMediaItem(
      path: 'assets/images/onboard_1.png',
      isAsset: true,
      isVideo: false,
    ),
  ];

  int _selectedIndex = 0;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickFromDevice() async {
    try {
      final XFile? file = await _picker.pickMedia(imageQuality: 85);
      if (file != null) {
        final path = file.path.toLowerCase();
        final isVideo =
            path.endsWith('.mp4') ||
            path.endsWith('.mov') ||
            path.endsWith('.avi') ||
            path.endsWith('.mkv') ||
            path.endsWith('.webm');

        final newItem = GalleryMediaItem(
          path: file.path,
          isAsset: false,
          isVideo: isVideo,
        );

        setState(() {
          _mediaList.insert(0, newItem);
          _selectedIndex = 0;
        });
      }
    } catch (e) {
      debugPrint('Error picking media from device: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedMedia = _mediaList[_selectedIndex];

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: Colors.black,
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 10.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => Get.back(),
                      behavior: HitTestBehavior.opaque,
                      child: const Padding(
                        padding: EdgeInsets.all(6.0),
                        child: Icon(
                          Icons.arrow_back_ios_new,
                          color: Color(0xFF8655FE),
                          size: 20,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.back(result: selectedMedia);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 22,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFA78BFA),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          'Done',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: Container(
                  width: double.infinity,
                  color: Colors.black,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      if (selectedMedia.isAsset)
                        Image.asset(
                          selectedMedia.path,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                          errorBuilder: (context, error, stackTrace) =>
                              Container(
                                color: const Color(0xFF1E1A34),
                                alignment: Alignment.center,
                                child: const Icon(
                                  Icons.image_outlined,
                                  color: Colors.white54,
                                  size: 60,
                                ),
                              ),
                        )
                      else
                        Image.file(
                          File(selectedMedia.path),
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                          errorBuilder: (context, error, stackTrace) =>
                              Container(
                                color: const Color(0xFF1E1A34),
                                alignment: Alignment.center,
                                child: const Icon(
                                  Icons.image_outlined,
                                  color: Colors.white54,
                                  size: 60,
                                ),
                              ),
                        ),
                      if (selectedMedia.isVideo)
                        Center(
                          child: Container(
                            width: 64,
                            height: 64,
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.5),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.play_arrow_rounded,
                              color: Colors.white,
                              size: 44,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),

              Container(
                height: 100,
                color: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  itemCount: _mediaList.length + 1,
                  itemBuilder: (context, index) {
                    if (index == _mediaList.length) {
                      return GestureDetector(
                        onTap: _pickFromDevice,
                        child: Container(
                          width: 85,
                          height: 92,
                          margin: const EdgeInsets.symmetric(horizontal: 2.0),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1F1D2B),
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(
                              color: const Color(0xFF374151),
                              width: 1.0,
                            ),
                          ),
                          alignment: Alignment.center,
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add_photo_alternate_outlined,
                                color: Colors.white70,
                                size: 26,
                              ),
                              SizedBox(height: 4),
                              Text(
                                'More',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 10,
                                  color: Colors.white70,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }

                    final media = _mediaList[index];
                    final isSelected = _selectedIndex == index;

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedIndex = index;
                        });
                      },
                      child: Container(
                        width: 85,
                        height: 92,
                        margin: const EdgeInsets.symmetric(horizontal: 2.0),
                        decoration: BoxDecoration(
                          border: isSelected
                              ? Border.all(
                                  color: const Color(0xFF8655FE),
                                  width: 2.5,
                                )
                              : null,
                        ),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            if (media.isAsset)
                              Image.asset(
                                media.path,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    Container(
                                      color: const Color(0xFF2A2640),
                                      alignment: Alignment.center,
                                      child: const Icon(
                                        Icons.image,
                                        color: Colors.white30,
                                      ),
                                    ),
                              )
                            else
                              Image.file(
                                File(media.path),
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    Container(
                                      color: const Color(0xFF2A2640),
                                      alignment: Alignment.center,
                                      child: const Icon(
                                        Icons.image,
                                        color: Colors.white30,
                                      ),
                                    ),
                              ),
                            if (media.isVideo)
                              const Positioned(
                                bottom: 4,
                                right: 4,
                                child: Icon(
                                  Icons.play_circle_fill,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
