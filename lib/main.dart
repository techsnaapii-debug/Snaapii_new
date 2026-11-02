import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'services/auth_api.dart';
import 'services/notification_service.dart';
import 'views/brand/my_campaign/home_screen.dart';
import 'views/brand/my_campaign/onboarding_screen.dart';
import 'views/creator/creator_home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.initialize();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
      systemNavigationBarColor: Colors.transparent,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Snaapii',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Poppins',
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF6B4EFF)),
      ),
      home: const _SessionGate(),
    );
  }
}

class _SessionGate extends StatefulWidget {
  const _SessionGate();

  @override
  State<_SessionGate> createState() => _SessionGateState();
}

class _SessionGateState extends State<_SessionGate> {
  final AppLinks _appLinks = AppLinks();
  int? _roleId;
  bool _checkingSession = true;
  StreamSubscription<Uri>? _instagramLinkSubscription;

  @override
  void initState() {
    super.initState();
    _listenForInstagramCallback();
    _restoreSession();
  }

  Future<void> _listenForInstagramCallback() async {
    final initialLink = await _appLinks.getInitialLink();
    if (initialLink != null) {
      _handleInstagramCallback(initialLink);
    }
    _instagramLinkSubscription = _appLinks.uriLinkStream.listen(
      _handleInstagramCallback,
    );
  }

  void _handleInstagramCallback(Uri uri) {
    if (uri.scheme != 'snapii') return;

    if (uri.host == 'instagram-connected') {
      Get.snackbar(
        'Instagram connected',
        'Your Instagram account was connected successfully.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } else if (uri.host == 'instagram-failed') {
      final reason = uri.queryParameters['reason'];
      Get.snackbar(
        'Instagram connection failed',
        reason == null || reason.isEmpty
            ? 'Please try connecting Instagram again.'
            : 'Instagram could not be connected: $reason',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  @override
  void dispose() {
    _instagramLinkSubscription?.cancel();
    super.dispose();
  }

  Future<void> _restoreSession() async {
    var roleId = await AuthApi.restoreSessionRole();
    if (roleId != null) {
      final validOnServer = await AuthApi.validateStoredSession();
      if (!validOnServer) {
        roleId = null;
      } else {
        unawaited(NotificationService.registerCurrentToken());
      }
    }
    if (!mounted) return;
    setState(() {
      _roleId = roleId;
      _checkingSession = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_checkingSession) {
      return const Scaffold(
        backgroundColor: Colors.white,
        body: Center(child: CircularProgressIndicator()),
      );
    }
    if (_roleId == 2) {
      HomeScreen.isCreatorRole = true;
      return const CreatorHomeScreen();
    }
    if (_roleId == 3) {
      HomeScreen.isCreatorRole = false;
      return const HomeScreen(isCreator: false);
    }
    return const OnboardingScreen();
  }
}
