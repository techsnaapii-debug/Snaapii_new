import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../services/home_api.dart';
import '../brand/my_campaign/video_player_screen.dart';

String _duration(Object? seconds) {
  final total = int.tryParse(seconds?.toString() ?? '') ?? 0;
  return '${total ~/ 60}:${(total % 60).toString().padLeft(2, '0')}';
}

class HomeBanners extends StatelessWidget {
  final List<Map<String, dynamic>> banners;
  const HomeBanners({super.key, required this.banners});

  @override
  Widget build(BuildContext context) {
    if (banners.isEmpty) {
      return const _EmptyHomeCard(message: 'No banners available yet.');
    }
    return SizedBox(
      height: 180,
      child: PageView.builder(
        itemCount: banners.length,
        itemBuilder: (context, index) {
          final banner = banners[index];
          final url = HomeApi.mediaUrl(banner['image_path']);
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  if (url != null)
                    Image.network(
                      url,
                      fit: BoxFit.cover,
                      errorBuilder: (_, _, _) =>
                          const ColoredBox(color: Color(0xFFEBE8FC)),
                    )
                  else
                    const ColoredBox(color: Color(0xFFEBE8FC)),
                  Positioned(
                    left: 16,
                    right: 16,
                    bottom: 14,
                    child: Text(
                      banner['headline']?.toString() ?? '',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        shadows: [Shadow(color: Colors.black87, blurRadius: 8)],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class HomeVideos extends StatelessWidget {
  final String heading;
  final List<Map<String, dynamic>> videos;
  const HomeVideos({super.key, required this.heading, required this.videos});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            heading,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          if (videos.isEmpty)
            const _EmptyHomeCard(
              message: 'No videos available yet.',
              horizontalMargin: 0,
            )
          else
            SizedBox(
              height: 180,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: videos.length,
                separatorBuilder: (_, _) => const SizedBox(width: 12),
                itemBuilder: (context, index) {
                  final video = videos[index];
                  final url = HomeApi.mediaUrl(video['video_url']);
                  final thumbnail = HomeApi.mediaUrl(video['thumbnail_url']);
                  final title = video['title']?.toString() ?? 'Video';
                  return GestureDetector(
                    onTap: url == null
                        ? null
                        : () => Get.to(
                            () => VideoPlayerScreen(
                              title: title,
                              duration: _duration(video['duration']),
                              previewWidget: const SizedBox(),
                              videoUrl: url,
                            ),
                          ),
                    child: SizedBox(
                      width: 128,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            if (thumbnail != null)
                              Image.network(
                                thumbnail,
                                fit: BoxFit.cover,
                                errorBuilder: (_, _, _) =>
                                    const ColoredBox(color: Color(0xFFEBE8FC)),
                              )
                            else
                              const ColoredBox(color: Color(0xFFEBE8FC)),
                            const Center(
                              child: Icon(
                                Icons.play_circle_fill,
                                color: Colors.white,
                                size: 36,
                              ),
                            ),
                            Positioned(
                              left: 8,
                              right: 8,
                              bottom: 8,
                              child: Text(
                                title,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  shadows: [
                                    Shadow(
                                      color: Colors.black87,
                                      blurRadius: 6,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}

class _EmptyHomeCard extends StatelessWidget {
  final String message;
  final double horizontalMargin;
  const _EmptyHomeCard({required this.message, this.horizontalMargin = 16});

  @override
  Widget build(BuildContext context) => Container(
    height: 110,
    margin: EdgeInsets.symmetric(horizontal: horizontalMargin),
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: const Color(0xFFF9F8FF),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: const Color(0xFFEBE8FC)),
    ),
    child: Text(message, style: const TextStyle(color: Color(0xFF665D78))),
  );
}
