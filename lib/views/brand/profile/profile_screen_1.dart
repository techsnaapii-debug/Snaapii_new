import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../ai/ai_screen.dart';
import '../chat/chat_screen.dart';
import '../my_campaign/home_screen.dart';
import '../my_campaign/my_campaign_screen.dart';
import '../../../widgets/custom_button.dart';
import 'setting_screen.dart';
import '../../../services/profile_api.dart';
import '../../../services/auth_api.dart';
import '../../../services/home_api.dart';
import '../../../services/instagram_api.dart';

class ProfileScreen1 extends StatefulWidget {
  const ProfileScreen1({super.key});

  @override
  State<ProfileScreen1> createState() => _ProfileScreen1State();
}

class _ProfileScreen1State extends State<ProfileScreen1>
    with WidgetsBindingObserver {
  int _selectedTabIndex = 4;
  int _selectedSubTab = 0;
  String _name = '';
  String _email = '';
  String _phone = '';
  bool _instagramConnected = false;
  Map<String, dynamic> _instagramProfile = const {};
  bool _openingMetaLogin = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _loadProfile();
    _loadInstagramConnection();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed && !_openingMetaLogin) {
      _loadInstagramConnection();
    }
  }

  Future<void> _loadInstagramConnection() async {
    try {
      final status = await InstagramApi.connectionStatus();
      Map<String, dynamic> profile = const {};
      if (status.connected) {
        try {
          final instagram = await HomeApi.creatorInstagramProfile();
          profile = Map<String, dynamic>.from(
            instagram['profile'] as Map? ?? const {},
          );
        } on ApiException {
          // Keep the confirmed connection state even if data is still syncing.
        }
      }
      if (mounted) {
        setState(() {
          _instagramConnected = status.connected;
          _instagramProfile = profile;
        });
      }
    } on ApiException {
      // Keep the connect action available if the status request fails.
    }
  }

  Future<void> _connectInstagram() async {
    if (_openingMetaLogin) return;
    setState(() => _openingMetaLogin = true);
    try {
      await InstagramApi.startConnection();
      if (mounted) {
        Get.snackbar(
          'Continue in Meta',
          'Finish the Instagram login, then return to Snaapii.',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } on ApiException catch (exception) {
      if (mounted) {
        Get.snackbar(
          'Instagram connection',
          exception.message,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } finally {
      if (mounted) setState(() => _openingMetaLogin = false);
    }
  }

  Future<void> _loadProfile() async {
    try {
      final user = await ProfileApi.brandProfile();
      if (!mounted) return;
      setState(() {
        _name = user['name']?.toString().isNotEmpty == true
            ? user['name'].toString()
            : [user['first_name'], user['last_name']]
                  .where((part) => part != null && part.toString().isNotEmpty)
                  .join(' ');
        _email = user['email']?.toString() ?? '';
        _phone = user['mobile_number']?.toString() ?? '';
      });
    } catch (_) {
      // The profile will remain empty instead of showing another account's data.
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.transparent,
      ),
      child: Scaffold(
        backgroundColor: const Color(0xFF9E8EFE),
        resizeToAvoidBottomInset: false,
        body: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: SizedBox.expand(
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 37),

                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 8.0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Text(
                                  'Profile',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 24,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),

                            GestureDetector(
                              onTap: () async {
                                await Get.to(() => const SettingScreen());
                                _loadProfile();
                                _loadInstagramConnection();
                              },
                              child: const Icon(
                                Icons.menu_rounded,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),

                      Expanded(
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(30),
                            ),
                          ),
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.fromLTRB(16, 24, 16, 100),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 72,
                                      height: 72,
                                      decoration: const BoxDecoration(
                                        color: Color(0xFF4A0010),
                                        shape: BoxShape.circle,
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        _name.isEmpty
                                            ? '?'
                                            : _name
                                                  .substring(0, 1)
                                                  .toUpperCase(),
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 13,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                          letterSpacing: 1.2,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(height: 2),
                                          RichText(
                                            text: TextSpan(
                                              children: [
                                                TextSpan(
                                                  text:
                                                      '${_name.isEmpty ? 'Brand' : _name} ',
                                                  style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                const TextSpan(
                                                  text: '(Brand)',
                                                  style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontSize: 13.5,
                                                    fontWeight: FontWeight.w500,
                                                    color: Color(0xFF616161),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(height: 6),
                                          Text(
                                            _email,
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 11.8,
                                              height: 1.35,
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xFF424242),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 24),

                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 14,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF0E8FF),
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                      color: const Color(0xFFE0D4FF),
                                      width: 1,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.language,
                                        color: Colors.black87,
                                        size: 22,
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Text(
                                          _email,
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black87,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 16),

                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF0E8FF),
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                      color: const Color(0xFFE0D4FF),
                                      width: 1,
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Contact Details',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      const Divider(
                                        color: Color(0xFFE0D4FF),
                                        height: 1,
                                        thickness: 1,
                                      ),
                                      const SizedBox(height: 12),
                                      Text(
                                        _phone.isEmpty
                                            ? 'No phone number added'
                                            : _phone,
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xFF757575),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 24),

                                Row(
                                  children: [
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () =>
                                            setState(() => _selectedSubTab = 0),
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 12,
                                          ),
                                          decoration: BoxDecoration(
                                            color: _selectedSubTab == 0
                                                ? const Color(0xFF9E8EFE)
                                                : Colors.white,
                                            borderRadius: BorderRadius.circular(
                                              24,
                                            ),
                                            border: _selectedSubTab == 0
                                                ? null
                                                : Border.all(
                                                    color: const Color(
                                                      0xFFE0E0E0,
                                                    ),
                                                    width: 1,
                                                  ),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.star,
                                                color: _selectedSubTab == 0
                                                    ? Colors.white
                                                    : Colors.black87,
                                                size: 20,
                                              ),
                                              const SizedBox(width: 8),
                                              Text(
                                                'Reviews',
                                                style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  color: _selectedSubTab == 0
                                                      ? Colors.white
                                                      : Colors.black87,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () =>
                                            setState(() => _selectedSubTab = 1),
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 12,
                                          ),
                                          decoration: BoxDecoration(
                                            color: _selectedSubTab == 1
                                                ? const Color(0xFF9E8EFE)
                                                : Colors.white,
                                            borderRadius: BorderRadius.circular(
                                              24,
                                            ),
                                            border: _selectedSubTab == 1
                                                ? null
                                                : Border.all(
                                                    color: const Color(
                                                      0xFFE0E0E0,
                                                    ),
                                                    width: 1,
                                                  ),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                'assets/images/instagram_icon.png',
                                                width: 22,
                                                height: 22,
                                                color: _selectedSubTab == 1
                                                    ? Colors.white
                                                    : null,
                                                errorBuilder:
                                                    (
                                                      context,
                                                      error,
                                                      stackTrace,
                                                    ) => Icon(
                                                      Icons.camera_alt,
                                                      color:
                                                          _selectedSubTab == 1
                                                          ? Colors.white
                                                          : Colors.black87,
                                                      size: 22,
                                                    ),
                                              ),
                                              const SizedBox(width: 8),
                                              Text(
                                                'Instagram',
                                                style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  color: _selectedSubTab == 1
                                                      ? Colors.white
                                                      : Colors.black87,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                _selectedSubTab == 0
                                    ? _buildReviewsView()
                                    : _buildInstagramView(),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    height: 90,
                    child: Container(color: Colors.white),
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

  Widget _buildReviewsView() {
    return Container(
      height: 200,
      alignment: Alignment.center,
      child: const Text(
        'No Review found',
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: Color(0xFF9E9E9E),
        ),
      ),
    );
  }

  Widget _buildInstagramView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 24),

        Center(
          child: SizedBox(
            width: 240,
            height: 240,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 135,
                  height: 235,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3EDFF),
                    borderRadius: BorderRadius.circular(26),
                    border: Border.all(
                      color: const Color(0xFF3B2E4A),
                      width: 3.2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0x268655FE),
                        blurRadius: 18,
                        spreadRadius: 2,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 7),

                      Container(
                        width: 38,
                        height: 9,
                        decoration: BoxDecoration(
                          color: const Color(0xFF1E1A24),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 18.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildPhonePillCard(
                        icon: Icons.bar_chart_rounded,
                        text: 'Better Campaign Results',
                      ),
                      _buildPhonePillCard(
                        icon: Icons.published_with_changes_rounded,
                        text: 'Top Creator Matches',
                      ),
                      _buildPhonePillCard(
                        icon: Icons.bolt_rounded,
                        text: 'High ROI Matches',
                      ),
                      _buildPhonePillCard(
                        icon: Icons.trending_up_rounded,
                        text: 'Grow with Creators',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 28),

        Center(
          child: CustomButton(
            text: _instagramConnected
                ? 'Instagram Connected'
                : _openingMetaLogin
                ? 'Opening Meta...'
                : 'Connect Instagram',
            isGradient: true,
            width: 270,
            onTap: _openingMetaLogin ? () {} : _connectInstagram,
          ),
        ),
        if (_instagramConnected) ...[
          const SizedBox(height: 16),
          _linkedInstagramAccount(),
        ],
        const SizedBox(height: 12),

        const Center(
          child: Text(
            'Protected with Official Meta APIs Security',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Color(0xFF616161),
            ),
          ),
        ),
        const SizedBox(height: 25),
      ],
    );
  }

  Widget _linkedInstagramAccount() {
    final username = _instagramProfile['username']?.toString().trim();
    final accountType = _instagramProfile['account_type']?.toString().trim();
    final imageUrl = HomeApi.mediaUrl(_instagramProfile['profile_picture_url']);
    final hasProfile = username != null && username.isNotEmpty;

    return Container(
      width: 290,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F6FF),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2DCFF)),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: const Color(0xFF9E8EFE),
            backgroundImage: imageUrl == null ? null : NetworkImage(imageUrl),
            child: imageUrl == null
                ? const Icon(Icons.person, color: Colors.white)
                : null,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  hasProfile ? '@$username' : 'Instagram connected',
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF222222),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  accountType == null || accountType.isEmpty
                      ? (hasProfile
                            ? 'Connected account'
                            : 'Account details are syncing')
                      : accountType,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12,
                    color: Color(0xFF616161),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPhonePillCard({required IconData icon, required String text}) {
    return Container(
      width: 220,
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 8.5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(9),
        border: Border.all(color: const Color(0xFFE8E0FE), width: 1.0),
        boxShadow: [
          BoxShadow(
            color: const Color(0x1F8655FE),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, size: 19, color: const Color(0xFF1A1A1A)),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1A1A1A),
              ),
            ),
          ),
        ],
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
              color: const Color(0x669E8EFE),
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
              onTap: () => Get.to(() => const MyCampaignScreen()),
              child: _buildNavIcon(
                'assets/images/create_compaign_icon.png',
                isActive: _selectedTabIndex == 1,
                width: 20,
                height: 20,
              ),
            ),
            GestureDetector(
              onTap: () => Get.to(() => const AiScreen()),
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
              onTap: () => setState(() => _selectedTabIndex = 4),
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
}
