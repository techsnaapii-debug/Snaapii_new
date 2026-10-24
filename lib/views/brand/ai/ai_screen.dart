import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../my_campaign/home_screen.dart';
import '../my_campaign/my_campaign_screen.dart';
import '../chat/chat_screen.dart';
import '../chat/brand_chat_detail_screen.dart';
import '../profile/profile_screen_1.dart';
import '../../creator/explore_screen.dart';

class AiScreen extends StatefulWidget {
  const AiScreen({super.key});

  @override
  State<AiScreen> createState() => _AiScreenState();
}

class ChatMessage {
  final String userText;
  final String aiResponse;

  ChatMessage({required this.userText, required this.aiResponse});
}

class _AiScreenState extends State<AiScreen> {
  int _selectedTabIndex = 2;
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<ChatMessage> _messages = [];

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage([String? text]) {
    final messageText = text ?? _messageController.text.trim();
    if (messageText.isEmpty) return;

    _messageController.clear();
    FocusScope.of(context).unfocus();

    setState(() {
      _messages.add(
        ChatMessage(
          userText: messageText,
          aiResponse: _getAiResponse(messageText),
        ),
      );
    });

    _scrollToBottom();
  }

  String _getAiResponse(String prompt) {
    return "Here's a professional bio for your content creator lifestyle brand:\n\n"
        "Content Creator | Lifestyle Enthusiast | Storyteller\n\n"
        "I create engaging content that inspires, entertains, and connects.From lifestyle tips to behind-the-scenes moments, I share real Instagram Caption experiences to build a positive and creative community.\n\n"
        "Let's collaborate and create something amazing together. ✨";
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
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
        resizeToAvoidBottomInset: false,
        drawer: _buildDrawer(),
        body: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: SizedBox.expand(
              child: Stack(
                children: [
                  if (_selectedTabIndex == 3)
                    _buildChatTabPage()
                  else
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 50),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Row(
                            children: [
                              Builder(
                                builder: (context) {
                                  if (_messages.isNotEmpty) {
                                    return GestureDetector(
                                      behavior: HitTestBehavior.opaque,
                                      onTap: () {
                                        setState(() {
                                          _messages.clear();
                                        });
                                      },
                                      child: Container(
                                        width: 44,
                                        height: 44,
                                        alignment: Alignment.centerLeft,
                                        color: Colors.transparent,
                                        child: const Icon(
                                          Icons.arrow_back_ios_new_rounded,
                                          color: Color(0xFF9E8EFE),
                                          size: 22,
                                        ),
                                      ),
                                    );
                                  }
                                  return GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                    onTap: () {
                                      Scaffold.of(context).openDrawer();
                                    },
                                    child: Container(
                                      width: 48,
                                      height: 48,
                                      color: Colors.transparent,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: 24,
                                            height: 2.5,
                                            decoration: BoxDecoration(
                                              color: Colors.black,
                                              borderRadius:
                                                  BorderRadius.circular(2),
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                          Container(
                                            margin: const EdgeInsets.only(
                                              left: 8,
                                            ),
                                            width: 24,
                                            height: 2.5,
                                            decoration: BoxDecoration(
                                              color: Colors.black,
                                              borderRadius:
                                                  BorderRadius.circular(2),
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                          Container(
                                            width: 24,
                                            height: 2.5,
                                            decoration: BoxDecoration(
                                              color: Colors.black,
                                              borderRadius:
                                                  BorderRadius.circular(2),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),

                        Expanded(
                          child: _messages.isEmpty
                              ? _buildInitialView()
                              : _buildChatView(),
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Container(
                            constraints: const BoxConstraints(
                              minHeight: 60,
                              maxHeight: 120,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: const Color(0xFFD6C8FF),
                                width: 1.5,
                              ),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 10,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: TextField(
                                    controller: _messageController,
                                    minLines: 1,
                                    maxLines: 4,
                                    textInputAction: TextInputAction.send,
                                    onSubmitted: (val) => _sendMessage(),
                                    style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 15,
                                      color: Colors.black87,
                                    ),
                                    decoration: const InputDecoration(
                                      hintText: 'Ask anything...',
                                      hintStyle: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 15,
                                        color: Color(0xFF9E9E9E),
                                      ),
                                      border: InputBorder.none,
                                      isDense: true,
                                      contentPadding: EdgeInsets.symmetric(
                                        vertical: 4,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                GestureDetector(
                                  onTap: () => _sendMessage(),
                                  child: Container(
                                    width: 42,
                                    height: 42,
                                    decoration: const BoxDecoration(
                                      color: Color(0xFF9E8EFE),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.arrow_upward,
                                      color: Colors.white,
                                      size: 24,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).viewInsets.bottom > 0
                              ? MediaQuery.of(context).viewInsets.bottom + 12
                              : 100,
                        ),
                      ],
                    ),

                  _buildBottomNavigationBar(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInitialView() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Hi! What can I help you\ncreate today?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF757575),
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 40),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildOptionCard(
                      icon: Icons.edit,
                      title: 'Refine a\nBio',
                      onTap: () {
                        _sendMessage(
                          'Write a professional bio for my content creator lifestyle brand',
                        );
                      },
                    ),
                    const SizedBox(width: 16),
                    _buildOptionCard(
                      icon: Icons.auto_awesome,
                      title: 'Generate\nCaption',
                      onTap: () {
                        _sendMessage(
                          'Generate an engaging caption for my lifestyle content',
                        );
                      },
                    ),
                    const SizedBox(width: 16),
                    _buildOptionCard(
                      icon: Icons.insert_drive_file,
                      title: 'Draft a\nScript',
                      onTap: () {
                        _sendMessage('Draft a video script for my channel');
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildChatView() {
    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      itemCount: _messages.length,
      itemBuilder: (context, index) {
        final message = _messages[index];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildUserBubble(message.userText),
            const SizedBox(height: 8),

            _buildAiResponseCard(message.aiResponse),
            const SizedBox(height: 24),
          ],
        );
      },
    );
  }

  Widget _buildUserBubble(String text) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.only(left: 40),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        decoration: BoxDecoration(
          color: const Color(0xFFF3E9FF),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 14.5,
            fontWeight: FontWeight.w500,
            color: Color(0xFF1A1A1A),
            height: 1.35,
          ),
        ),
      ),
    );
  }

  Widget _buildAiResponseCard(String aiText) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 2, bottom: 8),
          child: Icon(
            Icons.auto_awesome_outlined,
            color: Color(0xFF9E8EFE),
            size: 30,
          ),
        ),

        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: const Color(0xFFE9DDFE), width: 1.5),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Here's a professional bio for your content creator lifestyle brand:",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 13.5,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF222222),
                  height: 1.35,
                ),
              ),
              const SizedBox(height: 14),
              const Text(
                "Content Creator | Lifestyle Enthusiast | Storyteller",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 13.5,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF111111),
                  height: 1.35,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                "I create engaging content that inspires, entertains, and connects.From lifestyle tips to behind-the-scenes moments, I share real Instagram Caption experiences to build a positive and creative community.",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 13.5,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF333333),
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 14),
              const Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text:
                          "Let's collaborate and create something amazing together. ",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 13.5,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF222222),
                        height: 1.35,
                      ),
                    ),
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: Icon(
                        Icons.auto_awesome_outlined,
                        color: Color(0xFF9E8EFE),
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),

              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildActionButton(
                      icon: Icons.copy_outlined,
                      label: 'Copy',
                      onTap: () {
                        Clipboard.setData(ClipboardData(text: aiText));
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Bio copied to clipboard!',
                              style: TextStyle(fontFamily: 'Poppins'),
                            ),
                            duration: Duration(seconds: 2),
                            backgroundColor: Color(0xFF9E8EFE),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                    ),
                    const SizedBox(width: 8),
                    _buildActionButton(
                      icon: Icons.refresh_rounded,
                      label: 'Regenerate',
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Regenerating bio...',
                              style: TextStyle(fontFamily: 'Poppins'),
                            ),
                            duration: Duration(seconds: 1),
                            backgroundColor: Color(0xFF9E8EFE),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                    ),
                    const SizedBox(width: 8),
                    _buildActionButton(
                      icon: Icons.share_outlined,
                      label: 'Share',
                      onTap: () {
                        Clipboard.setData(ClipboardData(text: aiText));
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Bio copied to share!',
                              style: TextStyle(fontFamily: 'Poppins'),
                            ),
                            duration: Duration(seconds: 2),
                            backgroundColor: Color(0xFF9E8EFE),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xFFF3E9FF),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 15, color: Colors.black87),
            const SizedBox(width: 5),
            Text(
              label,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 12.5,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionCard({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFEBE8FC), width: 2),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.02),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: const Color(0xFF9E8EFE), size: 28),
              const SizedBox(height: 12),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                  height: 1.2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Positioned(
      left: 16,
      right: 16,
      bottom: 24,
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color: const Color(0xFF9E8EFE),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF9E8EFE).withValues(alpha: 0.4),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () => Get.offAll(() => const HomeScreen()),
              child: _buildNavIcon(
                'assets/images/home_icon.png',
                isActive: _selectedTabIndex == 0,
                width: 20,
                height: 20,
              ),
            ),
            GestureDetector(
              onTap: () {
                if (HomeScreen.isCreatorRole) {
                  Get.to(() => const ExploreScreen());
                } else {
                  Get.to(() => const MyCampaignScreen());
                }
              },
              child: _buildNavIcon(
                HomeScreen.isCreatorRole
                    ? 'assets/images/explore_icon.png'
                    : 'assets/images/create_compaign_icon.png',
                isActive: _selectedTabIndex == 1,
                width: HomeScreen.isCreatorRole ? 22 : 26,
                height: 20,
              ),
            ),
            GestureDetector(
              onTap: () => setState(() => _selectedTabIndex = 2),
              child: _buildNavIcon(
                'assets/images/ai_icon.png',
                isActive: _selectedTabIndex == 2,
                width: 24,
                height: 20,
              ),
            ),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => Get.to(() => const ChatScreen()),
              child: _buildNavIcon(
                'assets/images/message_icon.png',
                isActive: _selectedTabIndex == 3,
                width: 21,
                height: 20,
              ),
            ),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => Get.to(() => const ProfileScreen1()),
              child: _buildNavIcon(
                'assets/images/person_icon.png',
                isActive: _selectedTabIndex == 4,
                width: 20,
                height: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavIcon(
    dynamic icon, {
    bool isActive = false,
    double width = 24,
    double height = 24,
  }) {
    return Container(
      color: Colors.transparent,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedScale(
            scale: isActive ? 1.25 : 1.0,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOutBack,
            child: icon is IconData
                ? Icon(icon, color: Colors.white, size: height)
                : Image.asset(
                    icon,
                    width: width,
                    height: height,
                    color: Colors.white,
                    fit: BoxFit.contain,
                  ),
          ),
          if (isActive) ...[
            const SizedBox(height: 8),
            Container(
              width: 30,
              height: 2.5,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),

              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  setState(() {
                    _messages.clear();
                  });
                },
                child: Row(
                  children: const [
                    Icon(Icons.edit_square, color: Colors.black, size: 24),
                    SizedBox(width: 12),
                    Text(
                      'New Chat',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Recent Chats',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  Text(
                    'View all',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFFB18CFF),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    _buildRecentChatItem(
                      title: 'Write a bio for my brand',
                      time: '2 min ago',
                      onTap: () {
                        Navigator.pop(context);
                        _sendMessage(
                          'Write a professional bio for my content creator lifestyle brand',
                        );
                      },
                    ),
                    _buildRecentChatItem(
                      title: 'Hook ideas for Instagram',
                      time: '10 min ago',
                      onTap: () {
                        Navigator.pop(context);
                        _sendMessage('Hook ideas for Instagram');
                      },
                    ),
                    _buildRecentChatItem(
                      title: 'Script for Youtube',
                      time: 'yesterday',
                      onTap: () {
                        Navigator.pop(context);
                        _sendMessage('Script for Youtube');
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRecentChatItem({
    required String title,
    required String time,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12, right: 40),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFFF9F8FF),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.chat_bubble_outline,
              color: Colors.black87,
              size: 20,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    time,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChatTabPage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 50),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedTabIndex = 2;
                  });
                },
                child: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Color(0xFFB18CFF),
                  size: 22,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Chat',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFFB18CFF),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: UnconstrainedBox(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 8.5,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFF8655FE),
                borderRadius: BorderRadius.circular(24),
              ),
              child: const Text(
                'Campaign',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),

        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            children: [
              _buildChatItem(
                avatarWidget: Container(
                  width: 50,
                  height: 50,
                  decoration: const BoxDecoration(
                    color: Color(0xFF4A0010),
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    'GUCCI',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 9.5,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
                title: 'Gucci',
                time: '10:00 PM',
                unreadCount: 1,
              ),
              const Divider(color: Color(0xFFE9DDFE), height: 1, thickness: 1),

              _buildChatItem(
                avatarWidget: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFFE5E0FF),
                      width: 1,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: CustomPaint(
                    size: const Size(26, 26),
                    painter: _AdidasLogoPainter(),
                  ),
                ),
                title: 'Adidas',
                time: '10:00 PM',
                unreadCount: 1,
              ),
              const Divider(color: Color(0xFFE9DDFE), height: 1, thickness: 1),
            ],
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).viewInsets.bottom > 0
              ? MediaQuery.of(context).viewInsets.bottom + 12
              : 100,
        ),
      ],
    );
  }

  Widget _buildChatItem({
    required Widget avatarWidget,
    required String title,
    String? time,
    int unreadCount = 0,
  }) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => Get.to(() => BrandChatDetailScreen(brandName: title)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14.0),
        child: Row(
          children: [
            avatarWidget,
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                if (time != null) ...[
                  Text(
                    time,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF757575),
                    ),
                  ),
                  const SizedBox(height: 6),
                ],
                if (unreadCount > 0)
                  Container(
                    width: 22,
                    height: 22,
                    decoration: const BoxDecoration(
                      color: Color(0xFFB18CFF),
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '$unreadCount',
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _AdidasLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    final width = size.width;
    final height = size.height;

    final path = Path();

    path.moveTo(width * 0.05, height * 0.85);
    path.lineTo(width * 0.25, height * 0.85);
    path.lineTo(width * 0.45, height * 0.55);
    path.lineTo(width * 0.25, height * 0.55);
    path.close();

    path.moveTo(width * 0.30, height * 0.85);
    path.lineTo(width * 0.50, height * 0.85);
    path.lineTo(width * 0.70, height * 0.35);
    path.lineTo(width * 0.50, height * 0.35);
    path.close();

    path.moveTo(width * 0.55, height * 0.85);
    path.lineTo(width * 0.75, height * 0.85);
    path.lineTo(width * 0.95, height * 0.15);
    path.lineTo(width * 0.75, height * 0.15);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
