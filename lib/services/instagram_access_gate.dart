import 'package:get/get.dart';

import 'auth_api.dart';
import 'instagram_api.dart';

class InstagramAccessGate {
  const InstagramAccessGate._();

  /// Prevents Instagram-dependent tools from opening until the backend confirms
  /// that the current account has a working Instagram connection.
  static Future<bool> requireConnection(String featureName) async {
    try {
      final connection = await InstagramApi.connectionStatus();
      if (connection.connected) return true;

      Get.snackbar(
        'Connect Instagram first',
        '$featureName needs a connected Instagram account.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } on ApiException catch (error) {
      Get.snackbar(
        'Instagram connection check failed',
        error.message,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
    return false;
  }
}
