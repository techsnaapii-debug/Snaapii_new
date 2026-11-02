import 'dart:io';
import 'package:flutter/material.dart';

class LiveAutomationSlide1 extends StatelessWidget {
  const LiveAutomationSlide1({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset('assets/images/girl_image.png', fit: BoxFit.cover),
        ),
        const Positioned(
          top: 10,
          left: 16,
          right: 16,
          child: LivePhoneStatusBar(isDarkText: false),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          height: 130,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black.withValues(alpha: 0.75),
                  Colors.transparent,
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
          ),
        ),
        Positioned(
          right: 10,
          bottom: 22,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.favorite_border, color: Colors.white, size: 22),
              const SizedBox(height: 2),
              const Text(
                '6,323',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 9.5,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  shadows: [Shadow(color: Colors.black45, blurRadius: 4)],
                ),
              ),
              const SizedBox(height: 12),
              const Icon(
                Icons.chat_bubble_outline,
                color: Colors.white,
                size: 20,
              ),
              const SizedBox(height: 2),
              const Text(
                '10',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 9.5,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  shadows: [Shadow(color: Colors.black45, blurRadius: 4)],
                ),
              ),
              const SizedBox(height: 12),
              Transform.rotate(
                angle: -0.2,
                child: const Icon(
                  Icons.send_outlined,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(height: 2),
              const Text(
                '78',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 9.5,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  shadows: [Shadow(color: Colors.black45, blurRadius: 4)],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          left: 12,
          right: 55,
          bottom: 16,
          child: Row(
            children: [
              Container(
                width: 26,
                height: 26,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage('assets/images/user_avatar.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                'Riya',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  shadows: [Shadow(color: Colors.black45, blurRadius: 4)],
                ),
              ),
              const SizedBox(width: 18),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: Colors.white, width: 1.0),
                ),
                child: const Text(
                  'Follow',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class LiveAutomationSlide2 extends StatelessWidget {
  final bool isLiked;
  const LiveAutomationSlide2({super.key, this.isLiked = true});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset('assets/images/girl_image.png', fit: BoxFit.cover),
        ),
        Positioned(
          top: 10,
          left: 16,
          right: 16,
          child: Column(
            children: [
              const LivePhoneStatusBar(isDarkText: false),
              const SizedBox(height: 10),
              Row(
                children: const [
                  Icon(Icons.chevron_left, color: Colors.white, size: 24),
                  SizedBox(width: 8),
                  Text(
                    'Reel',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 18,
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
          left: 0,
          right: 0,
          bottom: 0,
          top: 130,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
            ),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  Center(
                    child: Container(
                      width: 38,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade400,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Comments',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF8E8E8E),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Comment 1
                  _buildCommentItem(
                    isPurpleAvatar: true,
                    username: 'Snaapii',
                    time: '2m',
                    comment: 'Woww',
                    isLiked: isLiked,
                  ),
                  const SizedBox(height: 14),

                  // Reply 1
                  Padding(
                    padding: const EdgeInsets.only(left: 42.0),
                    child: _buildCommentItem(
                      isPurpleAvatar: false,
                      username: 'r8iuc',
                      time: '2m',
                      comment: 'Thank You',
                      isLiked: false,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Comment 2
                  _buildCommentItem(
                    isPurpleAvatar: true,
                    username: 'Snaapii',
                    time: '2m',
                    comment: 'Woww',
                    isLiked: isLiked,
                  ),
                  const SizedBox(height: 14),

                  // Reply 2
                  Padding(
                    padding: const EdgeInsets.only(left: 42.0),
                    child: _buildCommentItem(
                      isPurpleAvatar: false,
                      username: 'r8iuc',
                      time: '2m',
                      comment: 'Thank You',
                      isLiked: false,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCommentItem({
    required bool isPurpleAvatar,
    required String username,
    required String time,
    required String comment,
    required bool isLiked,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isPurpleAvatar)
          Container(
            width: 34,
            height: 34,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFA78BFA),
            ),
          )
        else
          Container(
            width: 32,
            height: 32,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage('assets/images/girl_image.png'),
                fit: BoxFit.cover,
              ),
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
                  const SizedBox(width: 8),
                  Text(
                    time,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 11,
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
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
        Icon(
          isLiked ? Icons.favorite : Icons.favorite_border,
          size: 16,
          color: isLiked ? const Color(0xFFED4956) : const Color(0xFFBDBDBD),
        ),
      ],
    );
  }
}

class LiveAutomationSlide3 extends StatelessWidget {
  final File? selectedImage;

  const LiveAutomationSlide3({super.key, this.selectedImage});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 8, 16, 4),
            child: LivePhoneStatusBar(isDarkText: true),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
            child: Row(
              children: [
                Container(
                  width: 38,
                  height: 38,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage('assets/images/girl_image.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                const Text(
                  'Richa',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildOutgoingBubble('Link'),
                  const SizedBox(height: 8),
                  _buildIncomingBubble(
                    text:
                        "Hey there! 👋✨\nThanks a lot for reaching out — really excited to see your interest 🙃You're just one step away from getting everything you need.Tap below and I'll send the details right over 🚀",
                    actionButtons: [_buildPillActionButton('Send me the link')],
                  ),
                  const SizedBox(height: 8),
                  _buildOutgoingBubble('Send me the link'),
                  const SizedBox(height: 8),
                  _buildIncomingBubble(
                    text:
                        "Before I send you the details\nPlease follow the profile first,then tap \"I'm following\" below to continue",
                    actionButtons: [
                      _buildPillActionButton('Visit Profile'),
                      const SizedBox(height: 4),
                      _buildPillActionButton("I'm following"),
                    ],
                  ),
                  const SizedBox(height: 8),
                  _buildOutgoingBubble("I'm following"),
                  const SizedBox(height: 8),
                  _buildIncomingBubble(
                    imageWidget: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: selectedImage != null
                          ? Image.file(
                              selectedImage!,
                              height: 60,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            )
                          : Image.asset(
                              'assets/images/girl_image.png',
                              height: 60,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                    ),
                    text: 'Hey\nThanks for texting, Here is the link',
                    actionButtons: [_buildPillActionButton('Click Here')],
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(color: Colors.grey.shade200, width: 1),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Color(0xFFF3F4F6),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.camera_alt_outlined,
                    size: 13,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(width: 6),
                const Expanded(
                  child: Text(
                    'Message...',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 10,
                      color: Colors.grey,
                    ),
                  ),
                ),
                const Icon(Icons.image_outlined, size: 14, color: Colors.grey),
                const SizedBox(width: 6),
                const Icon(
                  Icons.chat_bubble_outline,
                  size: 14,
                  color: Colors.grey,
                ),
                const SizedBox(width: 6),
                const Icon(
                  Icons.add_circle_outline,
                  size: 14,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIncomingBubble({
    Widget? imageWidget,
    required String text,
    List<Widget>? actionButtons,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 20,
          height: 20,
          margin: const EdgeInsets.only(top: 2),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage('assets/images/user_avatar.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(width: 6),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFF3F4F6),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (imageWidget != null) ...[
                  imageWidget,
                  const SizedBox(height: 6),
                ],
                Text(
                  text,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 9.5,
                    color: Colors.black87,
                    height: 1.3,
                  ),
                ),
                if (actionButtons != null && actionButtons.isNotEmpty) ...[
                  const SizedBox(height: 6),
                  ...actionButtons,
                ],
              ],
            ),
          ),
        ),
        const SizedBox(width: 24),
      ],
    );
  }

  Widget _buildOutgoingBubble(String text) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xFF6B4EFF),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 9.5,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildPillActionButton(String label) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300, width: 0.8),
      ),
      child: Center(
        child: Text(
          label,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 9,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }
}

class LivePhoneStatusBar extends StatelessWidget {
  final bool isDarkText;

  const LivePhoneStatusBar({super.key, required this.isDarkText});

  @override
  Widget build(BuildContext context) {
    final color = isDarkText ? Colors.black : Colors.white;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '10:20',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 10,
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
        Row(
          children: [
            Icon(Icons.signal_cellular_4_bar, size: 10, color: color),
            const SizedBox(width: 3),
            Icon(Icons.wifi, size: 10, color: color),
            const SizedBox(width: 3),
            Icon(Icons.battery_full, size: 10, color: color),
          ],
        ),
      ],
    );
  }
}

class StoryAutomationSlide1 extends StatelessWidget {
  final String? storyImage;
  final String? username;

  const StoryAutomationSlide1({
    super.key,
    this.storyImage,
    this.username,
  });

  @override
  Widget build(BuildContext context) {
    final String displayImage = (storyImage != null && storyImage!.isNotEmpty)
        ? storyImage!
        : 'assets/images/girl_image.png';
    final String displayName = username ?? 'Richa';

    return Container(
      color: Colors.black,
      child: Stack(
        children: [
          Positioned(
            top: 70,
            left: 0,
            right: 0,
            bottom: 20,
            child: Image.asset(
              displayImage,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 85,
            child: Container(
              color: Colors.black,
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        children: const [
                          Icon(
                            Icons.signal_cellular_alt,
                            color: Colors.white,
                            size: 12,
                          ),
                          SizedBox(width: 4),
                          Icon(Icons.wifi, color: Colors.white, size: 12),
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
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(2),
                    child: Container(
                      height: 2.5,
                      color: Colors.white,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: FractionallySizedBox(
                          widthFactor: 0.45,
                          child: Container(color: const Color(0xFFE11D48)),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 26,
                        height: 26,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white,
                            width: 1.0,
                          ),
                          image: const DecorationImage(
                            image: AssetImage('assets/images/girl_image.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        displayName,
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12.5,
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
            height: 20,
            child: Container(
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

class StoryAutomationSlide2 extends StatelessWidget {
  final String? username;
  final String? storyImage;
  final String? keyword;
  final String? openingMessageText;
  final String? visitProfileText;
  final String? followingText;
  final String? message;
  final String? linkTitle;

  const StoryAutomationSlide2({
    super.key,
    this.username,
    this.storyImage,
    this.keyword,
    this.openingMessageText,
    this.visitProfileText,
    this.followingText,
    this.message,
    this.linkTitle,
  });

  @override
  Widget build(BuildContext context) {
    final String displayName = username ?? 'Richa';
    final String displayStoryImage = (storyImage != null && storyImage!.isNotEmpty)
        ? storyImage!
        : 'assets/images/girl_image.png';
    final String displayKeyword = (keyword != null && keyword!.trim().isNotEmpty)
        ? keyword!.trim().split(',').first.trim()
        : 'link';
    final String displayOpeningText = (openingMessageText != null &&
            openingMessageText!.trim().isNotEmpty)
        ? openingMessageText!
        : "Thanks a lot for reaching out — really excited to see your interest 🙃You're just one step away from getting everything you need.Tap below and I'll send the details right over 🚀";
    final String displayVisitText = visitProfileText ?? 'Visit Profile';
    final String displayFollowingText = followingText ?? 'I’m Following ✅';
    final String displayMessage = (message != null && message!.trim().isNotEmpty)
        ? message!
        : 'Hey\nThanks for texting, Here\nis the link';
    final String displayLinkTitle = (linkTitle != null && linkTitle!.trim().isNotEmpty)
        ? linkTitle!
        : 'Click Here';

    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  '10:20',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.signal_cellular_alt, color: Colors.black, size: 12),
                    SizedBox(width: 4),
                    Icon(Icons.wifi, color: Colors.black, size: 12),
                    SizedBox(width: 4),
                    Icon(Icons.battery_full, color: Colors.black, size: 13),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 15),
                const SizedBox(width: 6),
                Container(
                  width: 32,
                  height: 32,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage('assets/images/user_avatar.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  displayName,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14.5,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                const Spacer(),
                const Icon(Icons.call_outlined, color: Colors.black, size: 18),
                const SizedBox(width: 12),
                const Icon(Icons.videocam_outlined, color: Colors.black, size: 20),
              ],
            ),
            const SizedBox(height: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: SizedBox(
                    width: 75,
                    height: 90,
                    child: Image.asset(displayStoryImage, fit: BoxFit.cover),
                  ),
                ),
                const SizedBox(height: 3),
                const Text(
                  "Replied to @nia's story",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 8.5,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF4B5563),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 20,
                  height: 20,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage('assets/images/user_avatar.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE5E7EB),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    displayKeyword,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 10.5,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.only(left: 26.0),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F4F6),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Hey there 👋✨',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFFD97706),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      displayOpeningText,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 9.5,
                        color: Colors.black87,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Center(
                        child: Text(
                          'Send me the link',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 20,
                  height: 20,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage('assets/images/user_avatar.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE5E7EB),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Text(
                    'Send me the link',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.only(left: 26.0),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F4F6),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Before I send the details 🙃\nPlease follow the profile first, then tap\n“I’m Following” below to continue ✨',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 9.5,
                        color: Colors.black87,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          displayVisitText,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          displayFollowingText,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                width: 140,
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F4F6),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        displayStoryImage,
                        height: 60,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      displayMessage,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 8.5,
                        height: 1.2,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Center(
                        child: Text(
                          displayLinkTitle,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 8.5,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

