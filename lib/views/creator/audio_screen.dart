import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class AudioScreen extends StatefulWidget {
  const AudioScreen({super.key});

  @override
  State<AudioScreen> createState() => _AudioScreenState();
}

class _AudioScreenState extends State<AudioScreen> {
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, String>> _audioList = [
    {
      'title': 'Gleech Music',
      'artist': '(Shreya Ghoshal)',
      'image': 'assets/images/banner_2.jpg',
      'duration': '1:03',
      'videoPath': 'assets/images/dvideo_1.mp4',
    },
    {
      'title': 'Music',
      'artist': '(Arijit Singh)',
      'image': 'assets/images/banner_3.jpg',
      'duration': '0:20',
      'videoPath': '',
    },
    {
      'title': 'Gleech Music',
      'artist': '(Shreya Ghoshal)',
      'image': 'assets/images/banner_2.jpg',
      'duration': '1:03',
      'videoPath': 'assets/images/dvideo_1.mp4',
    },
    {
      'title': 'Gleech Music',
      'artist': '(Shreya Ghoshal)',
      'image': 'assets/images/user_avatar.png',
      'duration': '0:45',
      'videoPath': '',
    },
    {
      'title': 'Music',
      'artist': '(Arijit Singh)',
      'image': 'assets/images/banner_2.jpg',
      'duration': '1:03',
      'videoPath': 'assets/images/dvideo_1.mp4',
    },
    {
      'title': 'Gleech Music',
      'artist': '(Shreya Ghoshal)',
      'image': 'assets/images/banner_3.jpg',
      'duration': '0:20',
      'videoPath': '',
    },
    {
      'title': 'Gleech Music',
      'artist': '(Shreya Ghoshal)',
      'image': 'assets/images/banner_2.jpg',
      'duration': '1:03',
      'videoPath': 'assets/images/dvideo_1.mp4',
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
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
            child: SafeArea(
              child: Column(
                children: [
                  const SizedBox(height: 8),

                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 6.0,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () => Get.back(),
                          behavior: HitTestBehavior.opaque,
                          child: const Icon(
                            Icons.arrow_back_ios_new,
                            color: Color(0xFF6B4EFF),
                            size: 22,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 8),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Container(
                      height: 48,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: const Color(0xFFD6C8FF),
                          width: 1.5,
                        ),
                      ),
                      child: Row(
                        children: [
                          const SizedBox(width: 12),
                          const Icon(
                            Icons.search,
                            color: Color(0xFF999999),
                            size: 22,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TextField(
                              controller: _searchController,
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 14,
                                color: Colors.black,
                              ),
                              decoration: const InputDecoration(
                                hintText: 'Search',
                                hintStyle: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 14,
                                  color: Color(0xFFCCCCCC),
                                ),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.zero,
                                isDense: true,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Instagram Trending Audio',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1E1A34),
                            ),
                          ),
                          const SizedBox(height: 6),
                          const Text(
                            'Discover daily trending Instagram audios to boost your reels, increase reach, and grow faster',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 11,
                              color: Color(0xFF1E1A34),
                              height: 1.3,
                            ),
                          ),

                          const SizedBox(height: 16),

                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF7F7FD),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: _audioList.length,
                              separatorBuilder: (context, index) =>
                                  const SizedBox(height: 12),
                              itemBuilder: (context, index) {
                                final item = _audioList[index];
                                return _buildAudioCardItem(item);
                              },
                            ),
                          ),

                          const SizedBox(height: 30),
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

  Widget _buildAudioCardItem(Map<String, String> item) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(
            item['image']!,
            width: 52,
            height: 52,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                width: 52,
                height: 52,
                color: const Color(0xFF9E8EFE),
                child: const Icon(
                  Icons.music_note,
                  color: Colors.white,
                  size: 22,
                ),
              );
            },
          ),
        ),

        const SizedBox(width: 10),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text('🎵 ', style: TextStyle(fontSize: 11)),
                  Expanded(
                    child: Text(
                      item['title']!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 11.5,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 1),
              Text(
                item['artist']!,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 11.5,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 4),

              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: const Color(0xFFF0EAFF),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'View on Instagram ',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 9.5,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF7A58FF),
                      ),
                    ),
                    Image.asset(
                      'assets/images/instagram_icon.png',
                      width: 11,
                      height: 11,
                      errorBuilder: (context, error, stackTrace) => const Icon(
                        Icons.camera_alt,
                        size: 11,
                        color: Color(0xFF7A58FF),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        const SizedBox(width: 8),

        GestureDetector(
          onTap: () {},
          child: Container(
            width: 28,
            height: 28,
            decoration: const BoxDecoration(
              color: Colors.black,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.play_arrow_rounded,
              color: Colors.white,
              size: 16,
            ),
          ),
        ),
      ],
    );
  }
}
