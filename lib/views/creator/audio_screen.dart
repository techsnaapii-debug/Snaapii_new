import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../services/auth_api.dart';
import '../../services/home_api.dart';

class AudioScreen extends StatefulWidget {
  const AudioScreen({super.key});

  @override
  State<AudioScreen> createState() => _AudioScreenState();
}

class _AudioScreenState extends State<AudioScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _audioList = const [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadAudios();
  }

  Future<void> _loadAudios() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    try {
      final audios = await HomeApi.trendingAudios();
      if (!mounted) return;
      setState(() {
        _audioList = audios;
        _isLoading = false;
      });
    } on ApiException catch (error) {
      if (!mounted) return;
      setState(() {
        _errorMessage = error.message;
        _isLoading = false;
      });
    }
  }

  List<Map<String, dynamic>> get _filteredAudios {
    final query = _searchController.text.trim().toLowerCase();
    if (query.isEmpty) return _audioList;
    return _audioList.where((audio) {
      final song = audio['song_name']?.toString().toLowerCase() ?? '';
      final singer = audio['singer_name']?.toString().toLowerCase() ?? '';
      return song.contains(query) || singer.contains(query);
    }).toList();
  }

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
                      horizontal: 16,
                      vertical: 6,
                    ),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: Get.back,
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
                    padding: const EdgeInsets.symmetric(horizontal: 16),
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
                              onChanged: (_) => setState(() {}),
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 14,
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
                      padding: const EdgeInsets.symmetric(horizontal: 16),
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
                          _buildAudioList(),
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

  Widget _buildAudioList() {
    if (_isLoading) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(28),
          child: CircularProgressIndicator(),
        ),
      );
    }
    if (_errorMessage != null) {
      return Center(
        child: Column(
          children: [
            Text(
              _errorMessage!,
              textAlign: TextAlign.center,
              style: const TextStyle(fontFamily: 'Poppins', fontSize: 12),
            ),
            TextButton.icon(
              onPressed: _loadAudios,
              icon: const Icon(Icons.refresh, size: 18),
              label: const Text('Try again'),
            ),
          ],
        ),
      );
    }
    final audios = _filteredAudios;
    if (audios.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(20),
        child: Center(
          child: Text(
            'No trending audio found.',
            style: TextStyle(fontFamily: 'Poppins', fontSize: 12),
          ),
        ),
      );
    }
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F7FD),
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: audios.length,
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, index) => _buildAudioCardItem(audios[index]),
      ),
    );
  }

  Widget _buildAudioCardItem(Map<String, dynamic> item) {
    final imageUrl = HomeApi.mediaUrl(item['cover_image_url']);
    final audioUrl = Uri.tryParse(
      item['instagram_audio_url']?.toString() ?? '',
    );
    final title = item['song_name']?.toString().trim();
    final artist = item['singer_name']?.toString().trim();

    Future<void> openInstagram() async {
      if (audioUrl == null ||
          !await launchUrl(audioUrl, mode: LaunchMode.externalApplication)) {
        if (mounted) {
          Get.snackbar(
            'Unable to open Instagram',
            'The audio link is not available.',
          );
        }
      }
    }

    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: imageUrl == null
              ? _audioPlaceholder()
              : Image.network(
                  imageUrl,
                  width: 52,
                  height: 52,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      _audioPlaceholder(),
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
                      title?.isNotEmpty == true ? title! : 'Untitled audio',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 11.5,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 1),
              Text(
                artist?.isNotEmpty == true ? artist! : 'Unknown artist',
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 11.5,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 4),
              GestureDetector(
                onTap: audioUrl == null ? null : openInstagram,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
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
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(
                              Icons.camera_alt,
                              size: 11,
                              color: Color(0xFF7A58FF),
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        GestureDetector(
          onTap: audioUrl == null ? null : openInstagram,
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

  Widget _audioPlaceholder() => Container(
    width: 52,
    height: 52,
    color: const Color(0xFF9E8EFE),
    child: const Icon(Icons.music_note, color: Colors.white, size: 22),
  );
}
