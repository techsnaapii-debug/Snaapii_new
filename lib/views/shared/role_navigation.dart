import 'package:get/get.dart';

import '../../services/auth_api.dart';
import '../brand/profile/profile_screen_1.dart';
import '../creator/creator_profile_screen.dart';

class RoleNavigation {
  static Future<void> openCurrentProfile() async {
    final user = await AuthApi.readUser();
    final roleId = int.tryParse(
      (user?['rtype_id'] ?? user?['usertype_id'])?.toString() ?? '',
    );
    if (roleId == 2) {
      Get.to(() => const CreatorProfileScreen());
    } else if (roleId == 3) {
      Get.to(() => const ProfileScreen1());
    }
  }
}
