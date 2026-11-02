import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../services/home_api.dart';
import 'go_live_screen.dart';

class CreateAutomationScreen extends StatefulWidget {
  const CreateAutomationScreen({super.key});

  @override
  State<CreateAutomationScreen> createState() => _CreateAutomationScreenState();
}

class _CreateAutomationScreenState extends State<CreateAutomationScreen> {
  int _currentStep = 1;
  bool _allPostReel = false;
  int _selectedPostIndex = 0;
  List<Map<String, dynamic>> _instagramMedia = const [];
  Map<String, dynamic> _instagramProfile = const {};
  bool _isLoadingInstagramMedia = true;
  String? _instagramMediaError;
  final TextEditingController _nameController = TextEditingController();

  bool _anyComment = false;
  bool _replyPublicly = true;
  final TextEditingController _keywordsController = TextEditingController();
  final FocusNode _keywordsFocusNode = FocusNode();
  final List<String> _autoReplies = [
    'Thanks! Just sent it to your DM 🚀',
    'Check your inbox ✨',
    'Done ✅ Sent you the details in DM',
    'Your message is waiting in DM 👀',
    'Just shared everything with you 😊',
  ];

  File? _selectedStep3Image;
  final ImagePicker _imagePicker = ImagePicker();
  bool _openingMessage = false;
  bool _askToFollowBeforeDm = false;
  String _openingButtonText = 'Sent me the link';
  String _visitProfileText = 'Visit Profile';
  String _followingText = "I'm Following ✅";
  final TextEditingController _step3MessageController = TextEditingController();
  final TextEditingController _followPrompt1Controller = TextEditingController(
    text:
        "Before I send the details 🙃\nPlease follow the profile first, then tap\n“I’m Following” below to continue ✨",
  );
  final TextEditingController _followPrompt2Controller = TextEditingController(
    text:
        "It looks like the profile hasn't been followed yet 🙃\nFollow the account first to unlock your access 🚀",
  );

  @override
  void initState() {
    super.initState();
    _loadInstagramMedia();
    _loadInstagramProfile();
  }

  Future<void> _loadInstagramProfile() async {
    try {
      final data = await HomeApi.creatorInstagramProfile();
      final profile = data['profile'];
      if (!mounted || profile is! Map) return;
      setState(() => _instagramProfile = Map<String, dynamic>.from(profile));
    } catch (_) {
      // The selected-media preview remains usable when profile details fail.
    }
  }

  Future<void> _loadInstagramMedia() async {
    setState(() {
      _isLoadingInstagramMedia = true;
      _instagramMediaError = null;
    });
    try {
      final media = await HomeApi.creatorInstagramMedia();
      final selectableMedia = media.where((item) {
        final type = item['media_type']?.toString().toUpperCase() ?? '';
        return type == 'IMAGE' ||
            type == 'VIDEO' ||
            type == 'REELS' ||
            type == 'CAROUSEL_ALBUM';
      }).toList();
      if (!mounted) return;
      setState(() {
        _instagramMedia = selectableMedia;
        if (_selectedPostIndex == 0 && selectableMedia.isNotEmpty) {
          _selectedPostIndex = 1;
        }
        _isLoadingInstagramMedia = false;
      });
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _instagramMediaError = error.toString();
        _isLoadingInstagramMedia = false;
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _keywordsController.dispose();
    _keywordsFocusNode.dispose();
    _step3MessageController.dispose();
    _followPrompt1Controller.dispose();
    _followPrompt2Controller.dispose();
    super.dispose();
  }

  Future<void> _pickStep3Image(ImageSource source) async {
    try {
      final XFile? file = await _imagePicker.pickImage(
        source: source,
        imageQuality: 85,
      );
      if (file != null) {
        setState(() {
          _selectedStep3Image = File(file.path);
        });
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
    }
  }

  void _showImagePickerModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 36,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE5E7EB),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const Text(
                  'Upload Image',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Choose an image to send in your automated DM',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12,
                    color: Color(0xFF6B7280),
                  ),
                ),
                const SizedBox(height: 18),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    _pickStep3Image(ImageSource.gallery);
                  },
                  borderRadius: BorderRadius.circular(14),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF9FAFB),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: const Color(0xFFE5E7EB),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF3E8FF),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            Icons.photo_library_rounded,
                            color: Color(0xFF8B5CF6),
                            size: 22,
                          ),
                        ),
                        const SizedBox(width: 14),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Choose from Gallery',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                              ),
                              Text(
                                'Select photo from your photo library',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 11,
                                  color: Color(0xFF9CA3AF),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 14,
                          color: Color(0xFF9CA3AF),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    _pickStep3Image(ImageSource.camera);
                  },
                  borderRadius: BorderRadius.circular(14),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF9FAFB),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: const Color(0xFFE5E7EB),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: const Color(0xFFEDE9FE),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            Icons.camera_alt_rounded,
                            color: Color(0xFF6B4EFF),
                            size: 22,
                          ),
                        ),
                        const SizedBox(width: 14),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Take a Photo',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                              ),
                              Text(
                                'Use camera to capture new photo',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 11,
                                  color: Color(0xFF9CA3AF),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 14,
                          color: Color(0xFF9CA3AF),
                        ),
                      ],
                    ),
                  ),
                ),
                if (_selectedStep3Image != null) ...[
                  const SizedBox(height: 10),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      setState(() {
                        _selectedStep3Image = null;
                      });
                    },
                    borderRadius: BorderRadius.circular(14),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFEF2F2),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: const Color(0xFFFEE2E2),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFEE2E2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(
                              Icons.delete_outline_rounded,
                              color: Color(0xFFEF4444),
                              size: 22,
                            ),
                          ),
                          const SizedBox(width: 14),
                          const Expanded(
                            child: Text(
                              'Remove Selected Image',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFFEF4444),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
                const SizedBox(height: 12),
              ],
            ),
          ),
        );
      },
    );
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
        body: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 480),
              child: Column(
                children: [
                  const SizedBox(height: 8),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (_currentStep == 2) ...[
                          const Text(
                            'Reply to',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 2),
                          const Text(
                            'choose which comments should get an automatic reply',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 10,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 6),
                        ],
                        if (_currentStep == 3) ...[
                          const Text(
                            'Send a DM',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 6),
                        ],
                        Text(
                          'Step $_currentStep Of 3',
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF9D6BFF),
                          ),
                        ),
                        const SizedBox(height: 8),

                        Row(
                          children: [
                            _buildStepCircle(1),
                            Expanded(child: _buildStepLine(1)),
                            _buildStepCircle(2),
                            Expanded(child: _buildStepLine(2)),
                            _buildStepCircle(3),
                          ],
                        ),
                      ],
                    ),
                  ),

                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 12.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (_currentStep == 1) _buildStep1Body(),
                          if (_currentStep == 2) _buildStep2Body(),
                          if (_currentStep >= 3) _buildStep3Body(),
                        ],
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
                    child: _buildBottomButtons(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStep1Body() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: SizedBox(
            width: 180,
            height: 270,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(28),
                border: Border.all(color: const Color(0xFFC4B5FD), width: 2),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF6B4EFF).withValues(alpha: 0.08),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(26),
                child: Stack(
                  children: [
                    Positioned.fill(child: _buildSelectedMediaPreview()),

                    Positioned(top: 8, left: 10, child: _buildMediaTypeLabel()),

                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      height: 90,
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
                      right: 6,
                      bottom: 12,
                      child: _buildMediaMetrics(),
                    ),

                    Positioned(
                      left: 8,
                      bottom: 10,
                      right: 40,
                      child: _buildMediaAccount(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),

        _buildPaginationDots(activeIndex: 0),
        const SizedBox(height: 16),

        const Text(
          'Select a Post or Reel',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 10),

        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFE2D9FF), width: 1.2),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'All Post/ Reel',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
              Transform.scale(
                scale: 0.8,
                child: Switch(
                  value: _allPostReel,
                  activeThumbColor: const Color(0xFF6B4EFF),
                  inactiveThumbColor: Colors.grey.shade400,
                  inactiveTrackColor: Colors.grey.shade200,
                  onChanged: (value) {
                    setState(() {
                      _allPostReel = value;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        if (_isLoadingInstagramMedia)
          const Center(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: CircularProgressIndicator(),
            ),
          )
        else if (_instagramMedia.isNotEmpty)
          SizedBox(
            height: 140,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: _instagramMedia.length,
              separatorBuilder: (context, index) => const SizedBox(width: 10),
              itemBuilder: (context, index) => SizedBox(
                width: 94,
                child: GestureDetector(
                  onTap: () => setState(() => _selectedPostIndex = index + 1),
                  child: _buildPostCard(
                    index: index + 1,
                    child: _buildInstagramMediaTile(
                      _instagramMedia[index],
                      index + 1,
                    ),
                  ),
                ),
              ),
            ),
          )
        else ...[
          if (_instagramMediaError != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(
                'Instagram media could not be loaded. Please try again.',
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ),
          Center(
            child: Column(
              children: [
                const Text(
                  'No posts or reels are available from this Instagram account.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const SizedBox(height: 8),
                TextButton.icon(
                  onPressed: _loadInstagramMedia,
                  icon: const Icon(Icons.refresh, size: 18),
                  label: const Text('Refresh'),
                ),
              ],
            ),
          ),
        ],
        const SizedBox(height: 20),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              'Name your Automation',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            Row(
              children: [
                Text(
                  'View More ',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                Icon(Icons.keyboard_arrow_down, size: 16, color: Colors.grey),
              ],
            ),
          ],
        ),
        const SizedBox(height: 10),

        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFE2D9FF), width: 1.2),
          ),
          child: TextField(
            controller: _nameController,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 13,
              color: Colors.black87,
            ),
            decoration: const InputDecoration(
              hintText: 'Eg. Shoe Collection Automaton',
              hintStyle: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 13,
                color: Color(0xFFBDBDBD),
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
      ],
    );
  }

  Widget _buildStep2Body() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: SizedBox(
            width: 180,
            height: 270,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(28),
                border: Border.all(color: const Color(0xFFC4B5FD), width: 2),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF6B4EFF).withValues(alpha: 0.08),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(26),
                child: Column(
                  children: [
                    Expanded(
                      flex: 9,
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: Image.asset(
                              'assets/images/girl_image.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            top: 6,
                            left: 10,
                            right: 10,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text(
                                  '10:20',
                                  style: TextStyle(
                                    fontSize: 8,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.signal_cellular_4_bar,
                                      size: 8,
                                      color: Colors.white,
                                    ),
                                    SizedBox(width: 2),
                                    Icon(
                                      Icons.wifi,
                                      size: 8,
                                      color: Colors.white,
                                    ),
                                    SizedBox(width: 2),
                                    Icon(
                                      Icons.battery_full,
                                      size: 8,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    Expanded(
                      flex: 11,
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(16),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 18,
                                  height: 18,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: AssetImage(
                                        'assets/images/user_avatar.png',
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: const [
                                          Text(
                                            'Riya',
                                            style: TextStyle(
                                              fontSize: 8.5,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black87,
                                            ),
                                          ),
                                          SizedBox(width: 4),
                                          Text(
                                            '1m',
                                            style: TextStyle(
                                              fontSize: 7.5,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Text(
                                        'Link',
                                        style: TextStyle(
                                          fontSize: 7.5,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Icon(
                                  Icons.favorite_border,
                                  size: 11,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),

                            Padding(
                              padding: const EdgeInsets.only(left: 12.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 16,
                                    height: 16,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        image: AssetImage(
                                          'assets/images/user_avatar.png',
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: const [
                                            Text(
                                              'Riya',
                                              style: TextStyle(
                                                fontSize: 8.5,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black87,
                                              ),
                                            ),
                                            SizedBox(width: 4),
                                            Text(
                                              '1m',
                                              style: TextStyle(
                                                fontSize: 7.5,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ],
                                        ),
                                        RichText(
                                          text: const TextSpan(
                                            children: [
                                              TextSpan(
                                                text: '@Riya ',
                                                style: TextStyle(
                                                  fontSize: 7.5,
                                                  fontWeight: FontWeight.w600,
                                                  color: Color(0xFF6B4EFF),
                                                ),
                                              ),
                                              TextSpan(
                                                text: 'Check Your DM',
                                                style: TextStyle(
                                                  fontSize: 7.5,
                                                  color: Colors.black87,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Icon(
                                    Icons.favorite_border,
                                    size: 11,
                                    color: Colors.grey,
                                  ),
                                ],
                              ),
                            ),
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
        const SizedBox(height: 8),

        _buildPaginationDots(activeIndex: 1),
        const SizedBox(height: 18),

        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFE2D9FF), width: 1.2),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Any Comment',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
              Transform.scale(
                scale: 0.8,
                child: Switch(
                  value: _anyComment,
                  activeThumbColor: const Color(0xFF6B4EFF),
                  inactiveThumbColor: Colors.grey.shade400,
                  inactiveTrackColor: Colors.grey.shade200,
                  onChanged: (value) {
                    setState(() {
                      _anyComment = value;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        const Text(
          'Specific Keywords',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 10),

        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFE2D9FF), width: 1.2),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _keywordsController,
                  focusNode: _keywordsFocusNode,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 13,
                    color: Colors.black87,
                  ),
                  decoration: const InputDecoration(
                    hintText: 'Type Here',
                    hintStyle: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 13,
                      color: Color(0xFFBDBDBD),
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(right: 14.0),
                child: Icon(
                  Icons.add_circle_outline,
                  color: Color(0xFFBA8FFF),
                  size: 27,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        GestureDetector(
          onTap: () => _showAutoPublicRepliesBottomSheet(context),
          behavior: HitTestBehavior.opaque,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFE2D9FF), width: 1.2),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Reply publicly to comments',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
                Transform.scale(
                  scale: 0.8,
                  child: Switch(
                    value: _replyPublicly,
                    activeThumbColor: Colors.white,
                    activeTrackColor: const Color(0xFF6B4EFF),
                    inactiveThumbColor: Colors.grey.shade400,
                    inactiveTrackColor: Colors.grey.shade200,
                    thumbIcon: WidgetStateProperty.resolveWith<Icon?>((states) {
                      if (states.contains(WidgetState.selected)) {
                        return const Icon(
                          Icons.check,
                          color: Color(0xFF6B4EFF),
                          size: 22,
                        );
                      }
                      return null;
                    }),
                    onChanged: (value) {
                      setState(() {
                        _replyPublicly = value;
                      });
                      _showAutoPublicRepliesBottomSheet(context);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
      ],
    );
  }

  Widget _buildStep3Body() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Container(
            width: 230,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: const Color(0xFFBA8FFF), width: 1.5),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(22.5),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14.0,
                      vertical: 6.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          '10:20',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 9,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        Row(
                          children: const [
                            Icon(
                              Icons.signal_cellular_alt,
                              size: 10,
                              color: Colors.black,
                            ),
                            SizedBox(width: 3),
                            Icon(Icons.wifi, size: 10, color: Colors.black),
                            SizedBox(width: 3),
                            Icon(
                              Icons.battery_full,
                              size: 10,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 4.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const CircleAvatar(
                              radius: 9,
                              backgroundImage: AssetImage(
                                'assets/images/user_avatar.png',
                              ),
                            ),
                            const SizedBox(width: 5),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(7),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF5F5F5),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Hey there!\nThanks a lot for reaching out really excited to see your interest. You're just one step away from getting everything you need. Tap below and I'll send the details right now",
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 6.5,
                                        color: Colors.black87,
                                        height: 1.25,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Center(
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 3,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withValues(
                                                alpha: 0.05,
                                              ),
                                              blurRadius: 2,
                                            ),
                                          ],
                                        ),
                                        child: const Text(
                                          'Send me the link',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 6.5,
                                            fontWeight: FontWeight.w500,
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
                        const SizedBox(height: 4),

                        Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 3.5,
                            ),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFF8B5CF6), Color(0xFF6366F1)],
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Text(
                              'Send me the link',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 6.5,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),

                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const CircleAvatar(
                              radius: 9,
                              backgroundImage: AssetImage(
                                'assets/images/user_avatar.png',
                              ),
                            ),
                            const SizedBox(width: 5),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(7),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF5F5F5),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Before I send you the details\n\nPlease follow the profile first,then tap "I\'m following" below to continue',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 6.5,
                                        color: Colors.black87,
                                        height: 1.25,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Center(
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10,
                                          vertical: 3,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                        ),
                                        child: const Text(
                                          'Visit Profile',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 6.5,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black87,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 3),
                                    Center(
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10,
                                          vertical: 3,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                        ),
                                        child: const Text(
                                          "I'm following",
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 6.5,
                                            fontWeight: FontWeight.w500,
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
                        const SizedBox(height: 4),

                        Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 3.5,
                            ),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFF8B5CF6), Color(0xFF6366F1)],
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Text(
                              "I'm following",
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 6.5,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),

                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const CircleAvatar(
                              radius: 9,
                              backgroundImage: AssetImage(
                                'assets/images/user_avatar.png',
                              ),
                            ),
                            const SizedBox(width: 5),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF5F5F5),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(6),
                                      child: _selectedStep3Image != null
                                          ? Image.file(
                                              _selectedStep3Image!,
                                              width: 32,
                                              height: 32,
                                              fit: BoxFit.cover,
                                            )
                                          : Image.asset(
                                              'assets/images/girl_image.png',
                                              width: 32,
                                              height: 32,
                                              fit: BoxFit.cover,
                                            ),
                                    ),
                                    const SizedBox(width: 6),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Hey\nThanks for texting, Here\nis the link',
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 6.5,
                                              color: Colors.black87,
                                              height: 1.2,
                                            ),
                                          ),
                                          const SizedBox(height: 3),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 8,
                                              vertical: 2,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              border: Border.all(
                                                color: const Color(0xFFE5E7EB),
                                                width: 0.8,
                                              ),
                                            ),
                                            child: const Text(
                                              'Click Here',
                                              style: TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 6.5,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black87,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),

                        Container(
                          height: 24,
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: const Color(0xFFE5E7EB),
                              width: 0.8,
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 14,
                                height: 14,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFF6B4EFF),
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.camera_alt,
                                    size: 8,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 4),
                              const Text(
                                'Message....',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 6.5,
                                  color: Colors.grey,
                                ),
                              ),
                              const Spacer(),
                              const Icon(
                                Icons.image_outlined,
                                size: 10,
                                color: Colors.grey,
                              ),
                              const SizedBox(width: 4),
                              const Icon(
                                Icons.chat_bubble_outline,
                                size: 10,
                                color: Colors.grey,
                              ),
                              const SizedBox(width: 4),
                              const Icon(
                                Icons.add_circle_outline,
                                size: 10,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 6),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),

        _buildPaginationDots(activeIndex: 2),
        const SizedBox(height: 16),

        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE2D9FF), width: 1.2),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(14, 14, 14, 8),
                child: _selectedStep3Image == null
                    ? GestureDetector(
                        onTap: () => _showImagePickerModal(context),
                        behavior: HitTestBehavior.opaque,
                        child: CustomPaint(
                          painter: DashedBorderPainter(
                            color: const Color(0xFFD1D5DB),
                            strokeWidth: 1.2,
                            dashWidth: 5.0,
                            dashGap: 4.0,
                            radius: 12.0,
                          ),
                          child: Container(
                            width: double.infinity,
                            height: 48,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(
                                  Icons.image_outlined,
                                  size: 18,
                                  color: Color(0xFF757575),
                                ),
                                SizedBox(width: 8),
                                Text(
                                  'Select / Drop an Image',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 14,
                                    color: Color(0xFF757575),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF9F5FF),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: const Color(0xFFBA8FFF),
                            width: 1.2,
                          ),
                        ),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.file(
                                _selectedStep3Image!,
                                width: 44,
                                height: 44,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Text(
                                    'Image Selected',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    _selectedStep3Image!.path
                                        .split(Platform.pathSeparator)
                                        .last,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 11,
                                      color: Color(0xFF6B7280),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () => _showImagePickerModal(context),
                              behavior: HitTestBehavior.opaque,
                              child: Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFEDE9FE),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Icon(
                                  Icons.edit_outlined,
                                  size: 18,
                                  color: Color(0xFF6B4EFF),
                                ),
                              ),
                            ),
                            const SizedBox(width: 6),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedStep3Image = null;
                                });
                              },
                              behavior: HitTestBehavior.opaque,
                              child: Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFEE2E2),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Icon(
                                  Icons.close,
                                  size: 18,
                                  color: Color(0xFFEF4444),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextField(
                  controller: _step3MessageController,
                  maxLines: 2,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 13,
                    color: Colors.black87,
                  ),
                  decoration: const InputDecoration(
                    hintText: 'Enter your message here...',
                    hintStyle: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 13,
                      color: Color(0xFFBDBDBD),
                    ),
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.only(top: 4, bottom: 2),
                  ),
                ),
              ),

              const Padding(
                padding: EdgeInsets.only(
                  left: 16.0,
                  right: 16.0,
                  top: 0.0,
                  bottom: 4.0,
                ),
                child: Text(
                  '0/1000',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 10.5,
                    color: Color(0xFFBDBDBD),
                  ),
                ),
              ),

              const Divider(color: Color(0xFFF3F4F6), height: 1, thickness: 1),

              GestureDetector(
                onTap: () => _showAddLinkBottomSheet(context),
                behavior: HitTestBehavior.opaque,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.add_circle_outline,
                        color: Color(0xFFBA8FFF),
                        size: 19,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Add Link',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        GestureDetector(
          onTap: () => _showOpeningMessageBottomSheet(context),
          behavior: HitTestBehavior.opaque,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: const Color(0xFFE0E0E0), width: 1.2),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Openning Message',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF424242),
                  ),
                ),
                Transform.scale(
                  scale: 0.8,
                  child: Switch(
                    value: _openingMessage,
                    activeThumbColor: Colors.white,
                    activeTrackColor: const Color(0xFF6B4EFF),
                    inactiveThumbColor: Colors.white,
                    inactiveTrackColor: const Color(0xFFE0E0E0),
                    thumbIcon: WidgetStateProperty.resolveWith<Icon?>((states) {
                      if (!states.contains(WidgetState.selected)) {
                        return const Icon(
                          Icons.close,
                          color: Color(0xFF9E9E9E),
                          size: 20,
                        );
                      }
                      return const Icon(
                        Icons.check,
                        color: Color(0xFF6B4EFF),
                        size: 20,
                      );
                    }),
                    onChanged: (value) {
                      setState(() {
                        _openingMessage = value;
                      });
                      _showOpeningMessageBottomSheet(context);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),

        GestureDetector(
          onTap: () => _showAskToFollowBeforeDmBottomSheet(context),
          behavior: HitTestBehavior.opaque,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: const Color(0xFFE0E0E0), width: 1.2),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Ask to follow before DM',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF424242),
                  ),
                ),
                Transform.scale(
                  scale: 0.8,
                  child: Switch(
                    value: _askToFollowBeforeDm,
                    activeThumbColor: Colors.white,
                    activeTrackColor: const Color(0xFF6B4EFF),
                    inactiveThumbColor: Colors.white,
                    inactiveTrackColor: const Color(0xFFE0E0E0),
                    thumbIcon: WidgetStateProperty.resolveWith<Icon?>((states) {
                      if (!states.contains(WidgetState.selected)) {
                        return const Icon(
                          Icons.close,
                          color: Color(0xFF9E9E9E),
                          size: 20,
                        );
                      }
                      return const Icon(
                        Icons.check,
                        color: Color(0xFF6B4EFF),
                        size: 20,
                      );
                    }),
                    onChanged: (value) {
                      setState(() {
                        _askToFollowBeforeDm = value;
                      });
                      _showAskToFollowBeforeDmBottomSheet(context);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildBottomButtons() {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 48,
            child: OutlinedButton(
              onPressed: () {
                if (_currentStep > 1) {
                  setState(() => _currentStep--);
                } else {
                  Get.back();
                }
              },
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Color(0xFFBA8FFF), width: 1.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              child: const Text(
                'Back',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 14),

        Expanded(
          child: GestureDetector(
            onTap: () {
              if (_currentStep == 1 &&
                  !_allPostReel &&
                  _selectedPostIndex == 0) {
                Get.snackbar(
                  'Select a post or reel',
                  'Choose an Instagram post or reel before continuing.',
                  snackPosition: SnackPosition.BOTTOM,
                );
                return;
              }
              if (_currentStep < 3) {
                setState(() => _currentStep++);
              } else {
                Get.to(
                  () => GoLiveScreen(
                    selectedImage: _selectedStep3Image,
                    selectedMedia:
                        _selectedPostIndex > 0 &&
                            _selectedPostIndex <= _instagramMedia.length
                        ? _instagramMedia[_selectedPostIndex - 1]
                        : null,
                    instagramProfile: _instagramProfile,
                    automationTitle: 'Comment Automation',
                  ),
                );
              }
            },
            behavior: HitTestBehavior.opaque,
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                gradient: const LinearGradient(
                  colors: [Color(0xFF8B5CF6), Color(0xFF6366F1)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF6B4EFF).withValues(alpha: 0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  _currentStep == 3 ? 'Create Automation' : 'Next',
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
        ),
      ],
    );
  }

  Widget _buildStepCircle(int stepNumber) {
    final isCompletedOrCurrent = stepNumber <= _currentStep;
    return Container(
      width: 26,
      height: 26,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isCompletedOrCurrent ? const Color(0xFF8B5CF6) : Colors.white,
        border: Border.all(color: const Color(0xFFBA8FFF), width: 1.5),
      ),
      child: Center(
        child: Text(
          '$stepNumber',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: isCompletedOrCurrent
                ? Colors.white
                : const Color(0xFFBA8FFF),
          ),
        ),
      ),
    );
  }

  Widget _buildStepLine(int fromStep) {
    final isCompleted = fromStep < _currentStep;
    return Container(
      height: 3,
      color: isCompleted ? const Color(0xFF8B5CF6) : const Color(0xFFE9D5FF),
    );
  }

  Widget _buildPaginationDots({required int activeIndex}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) {
        final isActive = index == activeIndex;
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 3),
          height: 6,
          width: isActive ? 10 : 6,
          decoration: BoxDecoration(
            color: isActive ? const Color(0xFF6B4EFF) : const Color(0xFFE9D5FF),
            borderRadius: BorderRadius.circular(3),
          ),
        );
      }),
    );
  }

  Widget _buildPostCard({required int index, required Widget child}) {
    final isSelected = _selectedPostIndex == index;
    return Container(
      height: 140,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isSelected ? const Color(0xFF8B5CF6) : Colors.transparent,
          width: 2,
        ),
      ),
      child: child,
    );
  }

  Map<String, dynamic>? get _selectedMedia {
    final index = _selectedPostIndex - 1;
    if (index < 0 || index >= _instagramMedia.length) return null;
    return _instagramMedia[index];
  }

  Widget _buildMediaTypeLabel() {
    final type = _selectedMedia?['media_type']?.toString().toUpperCase();
    if (type == null || type.isEmpty) return const SizedBox.shrink();
    final label = type == 'VIDEO' || type == 'REELS' ? 'REEL' : 'POST';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      decoration: BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 8,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildMediaMetrics() {
    final media = _selectedMedia;
    if (media == null) return const SizedBox.shrink();
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildMediaMetric(Icons.favorite_border, media['likes']),
        const SizedBox(height: 8),
        _buildMediaMetric(Icons.chat_bubble_outline, media['comments']),
      ],
    );
  }

  Widget _buildMediaMetric(IconData icon, Object? value) {
    final display = value?.toString();
    if (display == null || display.isEmpty) return const SizedBox.shrink();
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 15),
        const SizedBox(height: 1),
        Text(
          display,
          style: const TextStyle(
            fontSize: 7.5,
            fontWeight: FontWeight.w500,
            color: Colors.white,
            shadows: [Shadow(color: Colors.black45, blurRadius: 2)],
          ),
        ),
      ],
    );
  }

  Widget _buildMediaAccount() {
    final username = _instagramProfile['username']?.toString().trim();
    if (username == null || username.isEmpty) return const SizedBox.shrink();
    final avatarUrl = HomeApi.mediaUrl(
      _instagramProfile['profile_picture_url'],
    );
    return Row(
      children: [
        ClipOval(
          child: avatarUrl == null
              ? Container(
                  width: 18,
                  height: 18,
                  color: const Color(0xFF6B4EFF),
                  child: const Icon(
                    Icons.person,
                    size: 12,
                    color: Colors.white,
                  ),
                )
              : Image.network(
                  avatarUrl,
                  width: 18,
                  height: 18,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: 18,
                    height: 18,
                    color: const Color(0xFF6B4EFF),
                    child: const Icon(
                      Icons.person,
                      size: 12,
                      color: Colors.white,
                    ),
                  ),
                ),
        ),
        const SizedBox(width: 4),
        Flexible(
          child: Text(
            username,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.w600,
              color: Colors.white,
              shadows: [Shadow(color: Colors.black45, blurRadius: 2)],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSelectedMediaPreview() {
    final media = _selectedMedia;
    if (media == null) {
      return const ColoredBox(
        color: Colors.black,
        child: Center(
          child: Text(
            'Select a post\nor reel below',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
        ),
      );
    }

    final imageUrl = HomeApi.mediaUrl(
      media['thumbnail_url'] ?? media['thumbnail'] ?? media['media_url'],
    );
    if (imageUrl == null) {
      return const ColoredBox(color: Colors.black);
    }
    return Image.network(
      imageUrl,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) =>
          const ColoredBox(color: Colors.black),
    );
  }

  Widget _buildInstagramMediaTile(Map<String, dynamic> media, int index) {
    final imageUrl = HomeApi.mediaUrl(
      media['thumbnail_url'] ?? media['thumbnail'] ?? media['media_url'],
    );
    final type = media['media_type']?.toString().toLowerCase() ?? '';
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (imageUrl != null)
            Image.network(
              imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  const ColoredBox(color: Colors.black),
            )
          else
            const ColoredBox(color: Colors.black),
          if (type.contains('video') || type.contains('reel'))
            const Center(
              child: Icon(
                Icons.play_circle_fill,
                color: Colors.white,
                size: 28,
              ),
            ),
          Positioned(
            top: 6,
            right: 6,
            child: _buildRadioIcon(_selectedPostIndex == index),
          ),
        ],
      ),
    );
  }

  Widget _buildRadioIcon(bool isSelected) {
    return Container(
      width: 18,
      height: 18,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isSelected ? const Color(0xFF8B5CF6) : Colors.transparent,
        border: Border.all(
          color: isSelected ? const Color(0xFF8B5CF6) : Colors.white,
          width: 1.5,
        ),
      ),
      child: isSelected
          ? const Center(
              child: Icon(Icons.circle, size: 8, color: Colors.white),
            )
          : null,
    );
  }

  void _showAutoPublicRepliesBottomSheet(BuildContext context) {
    final TextEditingController newReplyInputController =
        TextEditingController();
    bool isAddingReply = false;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.85,
              ),
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 20,
                bottom: MediaQuery.of(context).viewInsets.bottom + 20,
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),

                  const Text(
                    'Auto Public Replies',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),

                  const Text(
                    'Use multiple reply styles to keep comment replies engaging and less repetitive',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 11.5,
                      color: Colors.grey,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 20),

                  Flexible(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: List.generate(_autoReplies.length, (index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 12,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(
                                  color: const Color(0xFFE2D9FF),
                                  width: 1.2,
                                ),
                              ),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.message_rounded,
                                    color: Color(0xFF555555),
                                    size: 18,
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      _autoReplies[index],
                                      style: const TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  GestureDetector(
                                    onTap: () {
                                      setModalState(() {
                                        _autoReplies.removeAt(index);
                                      });
                                      setState(() {});
                                    },
                                    child: const Icon(
                                      Icons.delete,
                                      color: Color(0xFF555555),
                                      size: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),

                  if (!isAddingReply)
                    GestureDetector(
                      onTap: () {
                        setModalState(() {
                          isAddingReply = true;
                        });
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF9FAFB),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: const Color(0xFFE0E0E0),
                            width: 1.2,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.add_circle_outline,
                              color: Color(0xFF616161),
                              size: 20,
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Add Reply',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  else
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Add Reply',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          height: 75,
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: const Color(0xFFE2D9FF),
                              width: 1.2,
                            ),
                          ),
                          child: Center(
                            child: TextField(
                              controller: newReplyInputController,
                              autofocus: true,
                              maxLines: 2,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 13,
                                color: Colors.black87,
                              ),
                              decoration: const InputDecoration(
                                hintText: 'Enter here...',
                                hintStyle: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 13,
                                  color: Color(0xFFBDBDBD),
                                ),
                                border: InputBorder.none,
                                isDense: true,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                  const SizedBox(height: 20),

                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: Container(
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
                      child: ElevatedButton(
                        onPressed: () {
                          final newText = newReplyInputController.text.trim();
                          if (newText.isNotEmpty) {
                            _autoReplies.add(newText);
                            setState(() {});
                          }
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        child: const Text(
                          'Save',
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
                  const SizedBox(height: 10),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _showAskToFollowBeforeDmBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDmSheetState) {
            return Container(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 20,
                bottom: MediaQuery.of(context).viewInsets.bottom + 24,
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Ask to follow before DM',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 18),

                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(
                          color: const Color(0xFFD1D5DB),
                          width: 1.2,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextField(
                            controller: _followPrompt1Controller,
                            maxLines: null,
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 12.5,
                              fontWeight: FontWeight.w500,
                              color: Colors.black87,
                              height: 1.35,
                            ),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                              hintText: 'Enter follow prompt message...',
                            ),
                          ),
                          const SizedBox(height: 14),

                          GestureDetector(
                            onTap: () {
                              _showEditButtonBottomSheet(
                                context,
                                _visitProfileText,
                                (newText) {
                                  setState(() {
                                    _visitProfileText = newText;
                                  });
                                  setDmSheetState(() {});
                                },
                              );
                            },
                            behavior: HitTestBehavior.opaque,
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: const Color(0xFFD1D5DB),
                                  width: 1.1,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    _visitProfileText,
                                    style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 13.5,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  const Icon(
                                    Icons.edit_outlined,
                                    color: Color(0xFF757575),
                                    size: 20,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),

                          GestureDetector(
                            onTap: () {
                              _showEditButtonBottomSheet(
                                context,
                                _followingText,
                                (newText) {
                                  setState(() {
                                    _followingText = newText;
                                  });
                                  setDmSheetState(() {});
                                },
                              );
                            },
                            behavior: HitTestBehavior.opaque,
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: const Color(0xFFD1D5DB),
                                  width: 1.1,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    _followingText,
                                    style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 13.5,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  const Icon(
                                    Icons.edit_outlined,
                                    color: Color(0xFF757575),
                                    size: 20,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),

                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(
                          color: const Color(0xFFD1D5DB),
                          width: 1.2,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextField(
                            controller: _followPrompt2Controller,
                            maxLines: null,
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 12.5,
                              fontWeight: FontWeight.w500,
                              color: Colors.black87,
                              height: 1.35,
                            ),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                              hintText: 'Enter follow prompt message...',
                            ),
                          ),
                          const SizedBox(height: 14),

                          GestureDetector(
                            onTap: () {
                              _showEditButtonBottomSheet(
                                context,
                                _visitProfileText,
                                (newText) {
                                  setState(() {
                                    _visitProfileText = newText;
                                  });
                                  setDmSheetState(() {});
                                },
                              );
                            },
                            behavior: HitTestBehavior.opaque,
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: const Color(0xFFD1D5DB),
                                  width: 1.1,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    _visitProfileText,
                                    style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 13.5,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  const Icon(
                                    Icons.edit_outlined,
                                    color: Color(0xFF757575),
                                    size: 20,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),

                          GestureDetector(
                            onTap: () {
                              _showEditButtonBottomSheet(
                                context,
                                _followingText,
                                (newText) {
                                  setState(() {
                                    _followingText = newText;
                                  });
                                  setDmSheetState(() {});
                                },
                              );
                            },
                            behavior: HitTestBehavior.opaque,
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: const Color(0xFFD1D5DB),
                                  width: 1.1,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    _followingText,
                                    style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 13.5,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  const Icon(
                                    Icons.edit_outlined,
                                    color: Color(0xFF757575),
                                    size: 20,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: Container(
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
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _askToFollowBeforeDm = true;
                            });
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          child: const Text(
                            'Save & Continue',
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
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _showEditButtonBottomSheet(
    BuildContext context,
    String currentText,
    Function(String) onSave,
  ) {
    final TextEditingController btnTextController = TextEditingController(
      text: currentText,
    );

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom + 24,
          ),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Edit button',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    behavior: HitTestBehavior.opaque,
                    child: const Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Icon(Icons.close, color: Colors.black, size: 22),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),

              const Text(
                'This is a postback button that lets users tap to send a quick reply without typing',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 12,
                  color: Color(0xFF6B7280),
                  height: 1.35,
                ),
              ),
              const SizedBox(height: 16),

              Container(
                height: 48,
                padding: const EdgeInsets.symmetric(horizontal: 14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: const Color(0xFFD1D5DB),
                    width: 1.2,
                  ),
                ),
                child: Row(
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Text(
                          'T',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          '+',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 14),

                    Expanded(
                      child: TextField(
                        controller: btnTextController,
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 13.5,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                    ),
                    const Icon(
                      Icons.edit_outlined,
                      color: Color(0xFF757575),
                      size: 20,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),

              ValueListenableBuilder<TextEditingValue>(
                valueListenable: btnTextController,
                builder: (context, value, child) {
                  return Text(
                    '${value.text.length}/60',
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 11,
                      color: Color(0xFFBDBDBD),
                    ),
                  );
                },
              ),
              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    gradient: const LinearGradient(
                      colors: [Color(0xFF8B5CF6), Color(0xFF6366F1)],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF6B4EFF).withValues(alpha: 0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      final newText = btnTextController.text.trim();
                      if (newText.isNotEmpty) {
                        onSave(newText);
                      }
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: const Text(
                      'Save',
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
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }

  void _showOpeningMessageBottomSheet(BuildContext context) {
    final TextEditingController
    openingMessageController = TextEditingController(
      text:
          "Hey there 👋✨\nThanks a lot for reaching out — really excited to see your interest 😊\nYou're just one step away from getting everything you need.Tap below and I'll send the details right over 🚀",
    );
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setOpeningModalState) {
            return Container(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 20,
                bottom: MediaQuery.of(context).viewInsets.bottom + 24,
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Openning Message',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        behavior: HitTestBehavior.opaque,
                        child: const Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Icon(
                            Icons.close,
                            color: Colors.black,
                            size: 22,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: const Color(0xFFE0E0E0),
                        width: 1.2,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextField(
                          controller: openingMessageController,
                          maxLines: null,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 12.5,
                            color: Colors.black87,
                            height: 1.4,
                          ),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            isDense: true,
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                        const SizedBox(height: 14),

                        ValueListenableBuilder<TextEditingValue>(
                          valueListenable: openingMessageController,
                          builder: (context, value, child) {
                            return Text(
                              '${value.text.length}/1000',
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 11,
                                color: Color(0xFFBDBDBD),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 14),

                        GestureDetector(
                          onTap: () => _showEditMessageBottomSheet(
                            context,
                            setOpeningModalState,
                          ),
                          behavior: HitTestBehavior.opaque,
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: const Color(0xFFE0E0E0),
                                width: 1.2,
                              ),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 18,
                                  height: 18,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: const Color(0xFFBA8FFF),
                                      width: 2,
                                    ),
                                  ),
                                  child: Center(
                                    child: Container(
                                      width: 8,
                                      height: 8,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color(0xFF8B5CF6),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    _openingButtonText,
                                    style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 13.5,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                const Icon(
                                  Icons.edit_outlined,
                                  color: Color(0xFF757575),
                                  size: 22,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: Container(
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
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _openingMessage = true;
                          });
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        child: const Text(
                          'Save & Continue',
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
                  const SizedBox(height: 10),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _showEditMessageBottomSheet(
    BuildContext context,
    StateSetter setOpeningModalState,
  ) {
    final TextEditingController editMsgController = TextEditingController(
      text: _openingButtonText,
    );

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom + 24,
          ),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Edit Message',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    behavior: HitTestBehavior.opaque,
                    child: const Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Icon(Icons.close, color: Colors.black, size: 22),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              Container(
                height: 48,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: const Color(0xFFD1D5DB),
                    width: 1.2,
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: editMsgController,
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 13.5,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                    ),
                    const Icon(
                      Icons.edit_outlined,
                      color: Color(0xFF757575),
                      size: 20,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 2),
                    width: 14,
                    height: 14,
                    decoration: BoxDecoration(
                      color: const Color(0xFF8B5CF6),
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: const Center(
                      child: Text(
                        'i',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Text(
                      'This is a postback button that lets users tap to send a quick reply without typing',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 11.5,
                        color: Color(0xFF757575),
                        height: 1.3,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    gradient: const LinearGradient(
                      colors: [Color(0xFF8B5CF6), Color(0xFF6366F1)],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF6B4EFF).withValues(alpha: 0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      final newText = editMsgController.text.trim();
                      if (newText.isNotEmpty) {
                        setState(() {
                          _openingButtonText = newText;
                          _openingMessage = true;
                        });
                        setOpeningModalState(() {});
                      }
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: const Text(
                      'Save Message',
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
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }

  void _showAddLinkBottomSheet(BuildContext context) {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController linkController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          ),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Add Link',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    behavior: HitTestBehavior.opaque,
                    child: const Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Icon(Icons.close, color: Colors.black, size: 22),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              Container(
                height: 48,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: const Color(0xFFD1D5DB),
                    width: 1.2,
                  ),
                ),
                child: Row(
                  children: [
                    const Text(
                      'Enter Title',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 13,
                        color: Color(0xFF9E9E9E),
                      ),
                    ),
                    const SizedBox(width: 24),
                    Expanded(
                      child: TextField(
                        controller: titleController,
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 13,
                          color: Colors.black87,
                        ),
                        decoration: const InputDecoration(
                          hintText: 'Open Link',
                          hintStyle: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 13,
                            color: Color(0xFFBDBDBD),
                          ),
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              Container(
                height: 48,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: const Color(0xFFD1D5DB),
                    width: 1.2,
                  ),
                ),
                child: Row(
                  children: [
                    const Text(
                      'Enter Link',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 13,
                        color: Color(0xFF9E9E9E),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: TextField(
                        controller: linkController,
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 13,
                          color: Colors.black87,
                        ),
                        decoration: const InputDecoration(
                          hintText: 'https://www.gucci.comGucci',
                          hintStyle: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 13,
                            color: Color(0xFFBDBDBD),
                          ),
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    gradient: const LinearGradient(
                      colors: [Color(0xFF8B5CF6), Color(0xFF6366F1)],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF6B4EFF).withValues(alpha: 0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: const Text(
                      'Save',
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
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }
}

class DashedBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double dashWidth;
  final double dashGap;
  final double radius;

  DashedBorderPainter({
    this.color = const Color(0xFFD1D5DB),
    this.strokeWidth = 1.2,
    this.dashWidth = 5.0,
    this.dashGap = 4.0,
    this.radius = 12.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final Path path = Path();
    path.addRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height),
        Radius.circular(radius),
      ),
    );

    final Path dashedPath = Path();
    for (final ui.PathMetric metric in path.computeMetrics()) {
      double distance = 0.0;
      while (distance < metric.length) {
        final double len = (distance + dashWidth < metric.length)
            ? dashWidth
            : metric.length - distance;
        dashedPath.addPath(
          metric.extractPath(distance, distance + len),
          Offset.zero,
        );
        distance += dashWidth + dashGap;
      }
    }
    canvas.drawPath(dashedPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
