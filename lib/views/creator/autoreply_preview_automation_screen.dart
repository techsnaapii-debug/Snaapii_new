import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'automation_dashboard_screen.dart';

class AutoreplyPreviewScreen extends StatefulWidget {
  final String? postImage;
  final String? automationName;
  final String? delay;
  final int? repliesCount;
  final int? autoLikeCount;

  const AutoreplyPreviewScreen({
    super.key,
    this.postImage,
    this.automationName,
    this.delay,
    this.repliesCount,
    this.autoLikeCount,
  });

  @override
  State<AutoreplyPreviewScreen> createState() => _AutoreplyPreviewScreenState();
}

class _AutoreplyPreviewScreenState extends State<AutoreplyPreviewScreen> {
  bool _isLiked = false;

  @override
  Widget build(BuildContext context) {
    final String displayImage =
        (widget.postImage != null && widget.postImage!.isNotEmpty)
        ? widget.postImage!
        : 'assets/images/girl_image.png';

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
                        const SizedBox(width: 12),
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
                  const SizedBox(height: 16),

                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 36.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(36),
                          border: Border.all(
                            color: const Color(0xFF6B4EFF),
                            width: 2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(
                                0xFF6B4EFF,
                              ).withValues(alpha: 0.12),
                              blurRadius: 18,
                              spreadRadius: 2,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(34),
                          child: Stack(
                            children: [
                              Positioned(
                                top: 0,
                                left: 0,
                                right: 0,
                                height: 260,
                                child: Image.asset(
                                  displayImage,
                                  fit: BoxFit.cover,
                                ),
                              ),

                              Positioned(
                                top: 0,
                                left: 0,
                                right: 0,
                                child: Container(
                                  padding: const EdgeInsets.fromLTRB(
                                    16,
                                    12,
                                    16,
                                    10,
                                  ),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Colors.black.withValues(alpha: 0.7),
                                        Colors.transparent,
                                      ],
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            '10:20',
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Row(
                                            children: const [
                                              Icon(
                                                Icons.signal_cellular_alt,
                                                color: Colors.white,
                                                size: 13,
                                              ),
                                              SizedBox(width: 4),
                                              Icon(
                                                Icons.wifi,
                                                color: Colors.white,
                                                size: 13,
                                              ),
                                              SizedBox(width: 4),
                                              Icon(
                                                Icons.battery_full,
                                                color: Colors.white,
                                                size: 13,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),

                                      Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: const Icon(
                                              Icons.arrow_back_ios_new,
                                              color: Colors.white,
                                              size: 18,
                                            ),
                                          ),
                                          const Text(
                                            'Reel',
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 17,
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
                                top: 215,
                                left: 0,
                                right: 0,
                                bottom: 0,
                                child: Container(
                                  padding: const EdgeInsets.fromLTRB(
                                    16,
                                    10,
                                    16,
                                    14,
                                  ),
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(24),
                                    ),
                                  ),
                                  child: SingleChildScrollView(
                                    physics: const BouncingScrollPhysics(),
                                    child: Column(
                                      children: [
                                        Center(
                                          child: Container(
                                            width: 36,
                                            height: 4,
                                            decoration: BoxDecoration(
                                              color: const Color(0xFF9E9E9E),
                                              borderRadius:
                                                  BorderRadius.circular(2),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 8),

                                        const Text(
                                          'Comments',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xFF616161),
                                          ),
                                        ),
                                        const SizedBox(height: 14),

                                        _buildCommentThread(
                                          userAvatarColor: const Color(
                                            0xFF8B5CF6,
                                          ),
                                          username: 'Snaapii',
                                          time: '2m',
                                          comment: 'Woww',
                                          isCommentLiked: _isLiked,
                                          replyUsername: 'r8iuc',
                                          replyTime: '2m',
                                          replyText: 'Thank You',
                                          replyAvatar:
                                              'assets/images/bancy.png',
                                        ),
                                        const SizedBox(height: 14),

                                        _buildCommentThread(
                                          userAvatarColor: const Color(
                                            0xFF8B5CF6,
                                          ),
                                          username: 'Snaapii',
                                          time: '2m',
                                          comment: 'Woww',
                                          isCommentLiked: _isLiked,
                                          replyUsername: 'r8iuc',
                                          replyTime: '2m',
                                          replyText: 'Thank You',
                                          replyAvatar:
                                              'assets/images/bancy.png',
                                        ),
                                      ],
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
                  const SizedBox(height: 16),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(28, 0, 28, 20),
                    child: GestureDetector(
                      onTap: () {
                        if (!_isLiked) {
                          setState(() {
                            _isLiked = true;
                          });
                        } else {
                          Get.to(
                            () => const AutomationDashboardScreen(
                              automationType: 'autoreply',
                              isDm: false,
                            ),
                          );
                        }
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

  Widget _buildCommentThread({
    required Color userAvatarColor,
    required String username,
    required String time,
    required String comment,
    required bool isCommentLiked,
    required String replyUsername,
    required String replyTime,
    required String replyText,
    required String replyAvatar,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: userAvatarColor,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        username,
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        time,
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 11.5,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF9E9E9E),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    comment,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 12.5,
                      fontWeight: FontWeight.w400,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              isCommentLiked ? Icons.favorite : Icons.favorite_border,
              size: 17,
              color: isCommentLiked
                  ? const Color(0xFFE53935)
                  : const Color(0xFF9E9E9E),
            ),
          ],
        ),
        const SizedBox(height: 10),

        Padding(
          padding: const EdgeInsets.only(left: 42.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 14,
                backgroundImage: AssetImage(replyAvatar),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          replyUsername,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          replyTime,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 11.5,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF9E9E9E),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      replyText,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12.5,
                        fontWeight: FontWeight.w400,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.favorite_border,
                size: 16,
                color: Color(0xFF9E9E9E),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
