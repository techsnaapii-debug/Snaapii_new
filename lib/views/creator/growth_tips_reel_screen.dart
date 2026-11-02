import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

class GrowthTipsReelScreen extends StatefulWidget {
  final int initialIndex;

  const GrowthTipsReelScreen({super.key, this.initialIndex = 0});

  @override
  State<GrowthTipsReelScreen> createState() => _GrowthTipsReelScreenState();
}

class _GrowthTipsReelScreenState extends State<GrowthTipsReelScreen> {
  late PageController _pageController;
  int _currentIndex = 0;

  final List<String> _videos = [
    'assets/images/dvideo_1.mp4',
    'assets/images/dvideo_1.mp4',
    'assets/images/dvideo_1.mp4',
  ];

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex.clamp(0, _videos.length - 1);
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.black,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: Stack(
              children: [
                // Vertical PageView for Reels
                PageView.builder(
                  controller: _pageController,
                  scrollDirection: Axis.vertical,
                  physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics(),
                  ),
                  itemCount: _videos.length,
                  onPageChanged: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    return _ReelVideoItem(
                      key: ValueKey('video_$index'),
                      videoPath: _videos[index],
                      isActive: index == _currentIndex,
                    );
                  },
                ),

                // Back Button
                Positioned(
                  top: 0,
                  left: 0,
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        behavior: HitTestBehavior.opaque,
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.black.withValues(alpha: 0.4),
                          ),
                          child: const Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: Colors.white,
                            size: 20,
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
    );
  }
}

class _ReelVideoItem extends StatefulWidget {
  final String videoPath;
  final bool isActive;

  const _ReelVideoItem({
    super.key,
    required this.videoPath,
    required this.isActive,
  });

  @override
  State<_ReelVideoItem> createState() => _ReelVideoItemState();
}

class _ReelVideoItemState extends State<_ReelVideoItem> {
  VideoPlayerController? _controller;
  bool _isInitialized = false;
  bool _isPlaying = true;
  double _progress = 0.0;

  @override
  void initState() {
    super.initState();
    _initVideo();
  }

  void _initVideo() {
    _controller = VideoPlayerController.asset(widget.videoPath)
      ..initialize().then((_) {
        if (!mounted) return;
        setState(() {
          _isInitialized = true;
        });
        _controller?.setLooping(true);
        if (widget.isActive && _isPlaying) {
          _controller?.play();
        }
      });

    _controller?.addListener(_onControllerUpdate);
  }

  void _onControllerUpdate() {
    if (_controller == null || !_controller!.value.isInitialized) return;
    if (mounted) {
      final pos = _controller!.value.position;
      final dur = _controller!.value.duration;
      if (dur.inMilliseconds > 0) {
        setState(() {
          _progress = (pos.inMilliseconds / dur.inMilliseconds).clamp(0.0, 1.0);
        });
      }
    }
  }

  @override
  void didUpdateWidget(covariant _ReelVideoItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isActive != widget.isActive) {
      if (widget.isActive) {
        if (_isPlaying) {
          _controller?.play();
        }
      } else {
        _controller?.pause();
      }
    }
  }

  @override
  void dispose() {
    _controller?.removeListener(_onControllerUpdate);
    _controller?.dispose();
    super.dispose();
  }

  void _togglePlayPause() {
    setState(() {
      _isPlaying = !_isPlaying;
      if (_isPlaying) {
        _controller?.play();
      } else {
        _controller?.pause();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _togglePlayPause,
      behavior: HitTestBehavior.opaque,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Video Player
          if (_isInitialized && _controller != null)
            FittedBox(
              fit: BoxFit.cover,
              clipBehavior: Clip.hardEdge,
              child: SizedBox(
                width: _controller!.value.size.width,
                height: _controller!.value.size.height,
                child: VideoPlayer(_controller!),
              ),
            )
          else
            const Center(
              child: CircularProgressIndicator(
                color: Colors.white54,
                strokeWidth: 2,
              ),
            ),

          // Play/Pause Center Indicator
          if (!_isPlaying)
            Center(
              child: Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black.withValues(alpha: 0.5),
                ),
                child: const Icon(
                  Icons.play_arrow_rounded,
                  color: Colors.white,
                  size: 50,
                ),
              ),
            ),

          // Bottom Progress Bar
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: SizedBox(
              height: 2.5,
              child: LinearProgressIndicator(
                value: _progress,
                backgroundColor: Colors.white24,
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
