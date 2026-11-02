import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../services/auth_api.dart';
import '../../services/home_api.dart';
import '../../services/instagram_api.dart';
import '../../services/profile_api.dart';
import 'creator_setting_screen.dart';

class InstagramScreen extends StatefulWidget {
  const InstagramScreen({super.key});

  @override
  State<InstagramScreen> createState() => _InstagramScreenState();
}

class _InstagramScreenState extends State<InstagramScreen>
    with WidgetsBindingObserver {
  Map<String, dynamic> _creator = const {};
  Map<String, dynamic> _instagram = const {};
  Map<String, dynamic> _stats = const {};
  Map<String, dynamic> _weeklyGrowth = const {};
  List<Map<String, dynamic>> _media = const [];
  bool _loading = true;
  bool _openingMetaLogin = false;
  String? _instagramError;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _loadProfile();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed && !_openingMetaLogin) {
      _loadProfile();
    }
  }

  Future<void> _loadProfile() async {
    if (mounted) setState(() => _loading = true);
    Map<String, dynamic> creator = _creator;
    Map<String, dynamic>? instagram;
    String? error;

    try {
      creator = await ProfileApi.creatorProfile();
    } on ApiException {
      // The Instagram response can still provide a usable account identity.
    }

    try {
      final connection = await InstagramApi.connectionStatus();
      if (!connection.connected) {
        error = connection.reconnectRequired
            ? 'Your Instagram connection has expired. Please reconnect.'
            : 'Connect Instagram to show your live profile, statistics, and media.';
      } else {
        instagram = await HomeApi.creatorInstagramProfile();
        // These current Swagger routes provide the detailed figures that are
        // not guaranteed to be included in the profile summary response.
        final analytics = await InstagramApi.mediaInsights();
        final weeklyGrowth = await InstagramApi.weeklyGrowth();
        instagram = {
          ...instagram,
          'stats': {
            ...(instagram['stats'] as Map? ?? const {}),
            ...analytics.stats,
          },
          'weekly_growth': weeklyGrowth,
          if (analytics.media.isNotEmpty) 'media': analytics.media,
        };
      }
    } on ApiException catch (exception) {
      error = exception.message;
    }

    if (!mounted) return;
    setState(() {
      _creator = creator;
      _instagram = Map<String, dynamic>.from(
        instagram?['profile'] as Map? ?? const {},
      );
      _stats = Map<String, dynamic>.from(
        instagram?['stats'] as Map? ?? const {},
      );
      _weeklyGrowth = Map<String, dynamic>.from(
        instagram?['weekly_growth'] as Map? ?? const {},
      );
      _media = (instagram?['media'] as List? ?? const [])
          .whereType<Map>()
          .map((item) => Map<String, dynamic>.from(item))
          .toList();
      _instagramError = error;
      _loading = false;
    });
  }

  Future<void> _connectInstagram() async {
    if (_openingMetaLogin) return;
    setState(() => _openingMetaLogin = true);
    try {
      await InstagramApi.startConnection();
      if (!mounted) return;
      Get.snackbar(
        'Continue in Meta',
        'Finish the Instagram login, then return to Snaapii.',
        snackPosition: SnackPosition.BOTTOM,
      );
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

  String _text(Object? value, {String fallback = '—'}) {
    final result = value?.toString().trim() ?? '';
    return result.isEmpty || result == 'null' ? fallback : result;
  }

  String _number(Object? value, {String fallback = '—'}) {
    if (value is num) {
      if (value >= 1000000) return '${(value / 1000000).toStringAsFixed(1)}M';
      if (value >= 1000) return '${(value / 1000).toStringAsFixed(1)}K';
      return value.toStringAsFixed(value % 1 == 0 ? 0 : 1);
    }
    return _text(value, fallback: fallback);
  }

  String _percent(Object? value) {
    if (value is num) return '${value.toStringAsFixed(1)}%';
    final text = _text(value);
    return text == '—' || text.endsWith('%') ? text : '$text%';
  }

  String get _name =>
      _text(_instagram['username'], fallback: _text(_creator['name']));

  String get _location {
    final values = [_creator['city'], _creator['state']]
        .map((value) => _text(value, fallback: ''))
        .where((value) => value.isNotEmpty)
        .toSet()
        .toList();
    return values.isEmpty ? 'Location not set' : values.join(', ');
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
        body: SafeArea(
          bottom: false,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: Get.back,
                      icon: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Text(
                      'Profile',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () async {
                        final didUpdate = await Get.to<bool>(
                          () => const CreatorSettingScreen(),
                        );
                        if (didUpdate == true) _loadProfile();
                      },
                      icon: const Icon(
                        Icons.menu_rounded,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(30),
                    ),
                  ),
                  child: _loading
                      ? const Center(child: CircularProgressIndicator())
                      : RefreshIndicator(
                          onRefresh: _loadProfile,
                          child: ListView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            padding: const EdgeInsets.fromLTRB(16, 24, 16, 32),
                            children: [
                              _profileHeader(),
                              const SizedBox(height: 24),
                              _content(),
                            ],
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _profileHeader() {
    final avatar = HomeApi.mediaUrl(_instagram['profile_picture_url']);
    return Row(
      children: [
        CircleAvatar(
          radius: 46,
          backgroundColor: const Color(0xFF9E8EFE),
          backgroundImage: avatar == null ? null : NetworkImage(avatar),
          child: avatar == null
              ? const Icon(Icons.person, size: 48, color: Colors.white)
              : null,
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _name,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                '(${_text(_instagram['account_type'], fallback: 'Creator')})',
                style: const TextStyle(fontSize: 15, color: Color(0xFF616161)),
              ),
              const SizedBox(height: 7),
              Row(
                children: [
                  const Icon(
                    Icons.location_on,
                    size: 18,
                    color: Color(0xFF9E8EFE),
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      _location,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF6B4EFF),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _content() {
    if (_instagramError != null) {
      return Container(
        padding: const EdgeInsets.all(20),
        decoration: _cardDecoration(),
        child: Column(
          children: [
            const Icon(
              Icons.link_off_rounded,
              size: 44,
              color: Color(0xFF9E8EFE),
            ),
            const SizedBox(height: 12),
            const Text(
              'Instagram is not connected',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Text(
              _instagramError!,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Color(0xFF616161)),
            ),
            const SizedBox(height: 12),
            const Text(
              'Connect an Instagram Professional account to show live profile statistics and media here.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Color(0xFF616161)),
            ),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: _openingMetaLogin ? null : _connectInstagram,
              icon: _openingMetaLogin
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.link_rounded),
              label: Text(
                _openingMetaLogin ? 'Opening Meta...' : 'Connect Instagram',
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
        _metricCard([
          [_number(_instagram['followers']), 'Followers'],
          [_number(_stats['avg_views']), 'Average\nViews'],
          [_percent(_weeklyGrowth['growth_percent']), 'Weekly\nGrowth'],
          [_number(_stats['avg_reach']), 'Average\nReach'],
        ]),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 4),
          decoration: _cardDecoration(),
          child: Column(
            children: [
              const Text(
                'Engagement Analytics',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 14),
              _metricRow([
                [_number(_stats['avg_likes']), 'Average\nLikes'],
                [_number(_stats['avg_comments']), 'Average\nComments'],
                [_percent(_stats['engagement_rate']), 'Engagement\nRate'],
                [_number(_stats['avg_views']), 'Average\nViews'],
              ]),
            ],
          ),
        ),
        const SizedBox(height: 26),
        const Row(
          children: [
            Icon(Icons.camera_alt_outlined, color: Color(0xFF6B4EFF)),
            SizedBox(width: 8),
            Text(
              'Instagram',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 14),
        if (_media.isEmpty)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 32),
            child: Text('No Instagram media found.'),
          )
        else
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _media.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: .76,
            ),
            itemBuilder: (_, index) => _mediaTile(_media[index]),
          ),
      ],
    );
  }

  Widget _metricCard(List<List<String>> values) => Container(
    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 4),
    decoration: _cardDecoration(),
    child: _metricRow(values),
  );

  Widget _metricRow(List<List<String>> values) => Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: values
        .map(
          (value) => Expanded(
            child: Column(
              children: [
                Text(
                  value[0],
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  value[1],
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 12.5,
                    color: Color(0xFF616161),
                  ),
                ),
              ],
            ),
          ),
        )
        .toList(),
  );

  BoxDecoration _cardDecoration() => BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(16),
    border: Border.all(color: const Color(0xFFE5E0FF), width: 1.5),
  );

  Widget _mediaTile(Map<String, dynamic> item) {
    final url = HomeApi.mediaUrl(
      item['thumbnail'] ?? item['thumbnail_url'] ?? item['media_url'],
    );
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (url != null)
            Image.network(
              url,
              fit: BoxFit.cover,
              errorBuilder: (_, error, stackTrace) => _mediaFallback(),
            )
          else
            _mediaFallback(),
          if (_text(
                item['media_type'],
                fallback: '',
              ).toUpperCase().contains('VIDEO') ||
              _text(
                item['media_type'],
                fallback: '',
              ).toUpperCase().contains('REEL'))
            const Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: EdgeInsets.all(6),
                child: Icon(Icons.play_circle_fill, color: Colors.white),
              ),
            ),
          if (item['likes'] != null || item['views'] != null)
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                color: Colors.black54,
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 4),
                child: Text(
                  '${_number(item['likes'], fallback: '0')} likes · ${_number(item['views'] ?? item['reach'], fallback: '0')} views',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.white, fontSize: 10),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _mediaFallback() => Container(
    color: const Color(0xFFF0EDFF),
    child: const Icon(
      Icons.image_not_supported_outlined,
      color: Color(0xFF9E8EFE),
    ),
  );
}
