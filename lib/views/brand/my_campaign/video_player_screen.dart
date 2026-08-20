import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String title;
  final String duration;
  final Widget previewWidget;
  final String? videoAssetPath;

  const VideoPlayerScreen({
    super.key,
    required this.title,
    required this.duration,
    required this.previewWidget,
    this.videoAssetPath,
  });

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  bool _isPlaying = true;
  double _playbackProgress = 0.0;
  int _elapsedSeconds = 0;
  int _totalSeconds = 0;
  Timer? _playbackTimer;
  final Map<int, bool> _sentStatus = {};

  VideoPlayerController? _videoController;
  bool _isControllerInitialized = false;

  @override
  void initState() {
    super.initState();
    _parseTotalSeconds();

    if (widget.videoAssetPath != null) {
      _videoController = VideoPlayerController.asset(widget.videoAssetPath!)
        ..initialize().then((_) {
          setState(() {
            _isControllerInitialized = true;
          });
          if (_isPlaying) {
            _videoController?.play();
          }
        })
        ..setLooping(true);

      _videoController?.addListener(_onVideoControllerUpdate);
    } else {
      _startTimer();
    }
  }

  void _onVideoControllerUpdate() {
    if (_videoController == null || !_videoController!.value.isInitialized) {
      return;
    }
    setState(() {
      final pos = _videoController!.value.position;
      final dur = _videoController!.value.duration;
      if (dur.inMilliseconds > 0) {
        _playbackProgress = pos.inMilliseconds / dur.inMilliseconds;
        _elapsedSeconds = pos.inSeconds;
      }
    });
  }

  void _parseTotalSeconds() {
    final parts = widget.duration.split(':');
    if (parts.length == 2) {
      final minutes = int.tryParse(parts[0]) ?? 0;
      final seconds = int.tryParse(parts[1]) ?? 0;
      _totalSeconds = (minutes * 60) + seconds;
    } else {
      _totalSeconds = 15;
    }
  }

  void _startTimer() {
    _playbackTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_isPlaying) {
        setState(() {
          if (_elapsedSeconds < _totalSeconds) {
            _elapsedSeconds++;
            _playbackProgress = _elapsedSeconds / _totalSeconds;
          } else {
            _elapsedSeconds = 0;
            _playbackProgress = 0.0;
          }
        });
      }
    });
  }

  void _stopTimer() {
    _playbackTimer?.cancel();
  }

  @override
  void dispose() {
    _stopTimer();
    _videoController?.removeListener(_onVideoControllerUpdate);
    _videoController?.dispose();
    super.dispose();
  }

  void _togglePlayPause() {
    setState(() {
      _isPlaying = !_isPlaying;
      if (_videoController != null && _isControllerInitialized) {
        if (_isPlaying) {
          _videoController?.play();
        } else {
          _videoController?.pause();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.black,
      ),
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: GestureDetector(
              onTap: _togglePlayPause,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Container(
                      color: Colors.black,
                      child: ClipRect(
                        child: FittedBox(
                          fit: BoxFit.cover,
                          child: SizedBox(
                            width: 360,
                            height: 640,
                            child: (widget.videoAssetPath != null)
                                ? (_isControllerInitialized
                                      ? AspectRatio(
                                          aspectRatio: _videoController!
                                              .value
                                              .aspectRatio,
                                          child: VideoPlayer(_videoController!),
                                        )
                                      : Container(color: Colors.black))
                                : Image.asset(
                                    'assets/images/reel_mockup.png',
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return widget.previewWidget;
                                    },
                                  ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    height: 200,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.6),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                  ),

                  Positioned(
                    top: 24,
                    left: 16,
                    child: SafeArea(
                      child: GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          child: const Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                      ),
                    ),
                  ),

                  if (!_isPlaying)
                    const Positioned.fill(
                      child: Center(
                        child: CircleAvatar(
                          radius: 32,
                          backgroundColor: Colors.black45,
                          child: Icon(
                            Icons.play_arrow,
                            color: Colors.white,
                            size: 40,
                          ),
                        ),
                      ),
                    ),

                  Positioned(
                    right: 16,
                    bottom: 120,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: () => _showReviewsBottomSheet(context),
                          child: _buildTranslucentIcon(
                            icon: Icons.rate_review,
                            count: '500',
                          ),
                        ),
                        const SizedBox(height: 20),

                        Column(
                          children: [
                            Container(
                              width: 44,
                              height: 44,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.black.withOpacity(0.4),
                              ),
                              child: Transform(
                                alignment: Alignment.center,
                                transform: Matrix4.identity()
                                  ..scale(-1.0, 1.0, 1.0),
                                child: const Icon(
                                  Icons.reply,
                                  color: Colors.white,
                                  size: 26,
                                ),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '500',
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  Positioned(
                    left: 16,
                    bottom: 60,
                    right: 80,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Grow Faster With Smart Content',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          'SNAAPII',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      color: Colors.black,
                      height: 50,
                      alignment: Alignment.topCenter,
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          final width = constraints.maxWidth;
                          return Stack(
                            alignment: Alignment.centerLeft,
                            clipBehavior: Clip.none,
                            children: [
                              Container(
                                height: 4,
                                width: double.infinity,
                                color: Colors.white24,
                              ),
                              Container(
                                height: 4,
                                width: width * _playbackProgress,
                                color: const Color(0xFF3897F0),
                              ),
                              Positioned(
                                left: (width * _playbackProgress) - 5,
                                top: -3,
                                child: Container(
                                  width: 10,
                                  height: 10,
                                  decoration: const BoxDecoration(
                                    color: Colors.red,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
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

  Widget _buildTranslucentIcon({
    required IconData icon,
    required String count,
  }) {
    return Column(
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.black.withOpacity(0.4),
          ),
          child: Icon(icon, color: Colors.white, size: 22),
        ),
        const SizedBox(height: 4),
        Text(
          count,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  void _showReviewsBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.52,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              const SizedBox(height: 10),
              Container(
                width: 40,
                height: 4.5,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(height: 16),

              const Text(
                'Reviews',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 16),

              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: [
                    _buildReviewRow(
                      avatar: Image.asset(
                        'assets/images/user_avatar.png',
                        fit: BoxFit.cover,
                      ),
                      username: 'Richa 23',
                      comment: 'Great composition',
                      time: '10m',
                    ),
                    _buildReviewRow(
                      avatar: Container(
                        decoration: const BoxDecoration(
                          color: Color(0xFF4A0E17),
                          shape: BoxShape.circle,
                        ),
                        child: const Center(
                          child: Text(
                            'GUCCI',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 8,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ),
                      username: 'Gucci',
                      comment: 'Great Tips',
                      time: '20h',
                    ),
                    _buildReviewRow(
                      avatar: Image.asset(
                        'assets/images/user_avatar.png',
                        fit: BoxFit.cover,
                      ),
                      username: 'Richa 23',
                      comment: 'Great composition',
                      time: '20h',
                    ),
                    _buildReviewRow(
                      avatar: Container(
                        decoration: const BoxDecoration(
                          color: Color(0xFF4A0E17),
                          shape: BoxShape.circle,
                        ),
                        child: const Center(
                          child: Text(
                            'GUCCI',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 8,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ),
                      username: 'Gucci',
                      comment: 'Great Tips',
                      time: '10m',
                    ),
                    _buildReviewRow(
                      avatar: Image.asset(
                        'assets/images/user_avatar.png',
                        fit: BoxFit.cover,
                      ),
                      username: 'Richa 23',
                      comment: 'Great composition',
                      time: '20h',
                    ),
                    _buildReviewRow(
                      avatar: Container(
                        decoration: const BoxDecoration(
                          color: Color(0xFF4A0E17),
                          shape: BoxShape.circle,
                        ),
                        child: const Center(
                          child: Text(
                            'GUCCI',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 8,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ),
                      username: 'Gucci',
                      comment: 'Great Tips',
                      time: '10m',
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showShareBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.62,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 12),
                  Container(
                    width: 40,
                    height: 4.5,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  const SizedBox(height: 16),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1F1F1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search',
                          hintStyle: const TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.grey[500],
                            size: 20,
                          ),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 10,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      children: [
                        _buildFriendRow(
                          name: 'Kumar Prasad',
                          username: '@kumar_prasad',
                          initials: 'KP',
                          color: const Color(0xFFC7B8FF),
                          isSent: _sentStatus[0] ?? false,
                          onSend: () {
                            setModalState(() {
                              _sentStatus[0] = !(_sentStatus[0] ?? false);
                            });
                          },
                        ),
                        _buildFriendRow(
                          name: 'Richa Sharma',
                          username: '@richa_23',
                          initials: 'RS',
                          avatarImage: 'assets/images/user_avatar.png',
                          color: const Color(0xFFFFB2D9),
                          isSent: _sentStatus[1] ?? false,
                          onSend: () {
                            setModalState(() {
                              _sentStatus[1] = !(_sentStatus[1] ?? false);
                            });
                          },
                        ),
                        _buildFriendRow(
                          name: 'John Doe',
                          username: '@johndoe',
                          initials: 'JD',
                          color: const Color(0xFFB5E3FF),
                          isSent: _sentStatus[2] ?? false,
                          onSend: () {
                            setModalState(() {
                              _sentStatus[2] = !(_sentStatus[2] ?? false);
                            });
                          },
                        ),
                        _buildFriendRow(
                          name: 'Jane Smith',
                          username: '@janesmith',
                          initials: 'JS',
                          color: const Color(0xFFFFD1A9),
                          isSent: _sentStatus[3] ?? false,
                          onSend: () {
                            setModalState(() {
                              _sentStatus[3] = !(_sentStatus[3] ?? false);
                            });
                          },
                        ),
                      ],
                    ),
                  ),

                  const Divider(height: 1, color: Color(0xFFEBEBEB)),

                  Container(
                    height: 100,
                    color: Colors.white,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      children: [
                        _buildShareAction(Icons.link, 'Copy Link'),
                        _buildShareAction(Icons.ios_share, 'Share to...'),
                        _buildShareAction(
                          Icons.chat_bubble_outline,
                          'WhatsApp',
                        ),
                        _buildShareAction(Icons.sms_outlined, 'SMS'),
                        _buildShareAction(Icons.message_outlined, 'Messenger'),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildReviewRow({
    required Widget avatar,
    required String username,
    required String comment,
    required String time,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: const BoxDecoration(shape: BoxShape.circle),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: avatar,
            ),
          ),
          const SizedBox(width: 12),

          Text(
            username,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              comment,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 12,
                color: Colors.black54,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),

          Text(
            time,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 10,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFriendRow({
    required String name,
    required String username,
    required String initials,
    String? avatarImage,
    required Color color,
    required bool isSent,
    required VoidCallback onSend,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(shape: BoxShape.circle, color: color),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(22),
              child: avatarImage != null
                  ? Image.asset(avatarImage, fit: BoxFit.cover)
                  : Center(
                      child: Text(
                        initials,
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
            ),
          ),
          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  username,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),

          GestureDetector(
            onTap: onSend,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isSent ? Colors.white : const Color(0xFF3897F0),
                borderRadius: BorderRadius.circular(8),
                border: isSent
                    ? Border.all(color: Colors.grey[300]!, width: 1.5)
                    : null,
              ),
              child: Text(
                isSent ? 'Sent' : 'Send',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: isSent ? Colors.grey[600] : Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShareAction(IconData icon, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFFF5F5F5),
              border: Border.all(color: const Color(0xFFEBEBEB), width: 1),
            ),
            child: Icon(icon, color: Colors.black87, size: 20),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 10,
              color: Colors.black54,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
