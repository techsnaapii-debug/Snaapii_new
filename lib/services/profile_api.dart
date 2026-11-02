import 'auth_api.dart';

class ProfileApi {
  static Future<Map<String, dynamic>> currentUser(int expectedRole) async {
    final user = await AuthApi.readUser();
    if (user == null || user['user_id'] == null) {
      throw const ApiException('Please log in again.');
    }
    final role = int.tryParse(
      (user['rtype_id'] ?? user['usertype_id'])?.toString() ?? '',
    );
    if (role != expectedRole) {
      throw const ApiException(
        'This account does not have access to this profile.',
      );
    }
    return user;
  }

  static Future<Map<String, dynamic>> creatorProfile() async {
    final user = await currentUser(2);
    final result = await AuthApi.request('GET', '/api/creator/profile');
    final data = result['data'];
    if (data is! Map ||
        data['user_id']?.toString() != user['user_id'].toString()) {
      throw const ApiException(
        'The server returned an invalid creator profile.',
      );
    }
    return Map<String, dynamic>.from(data);
  }

  static Future<Map<String, dynamic>> brandProfile() async {
    final user = await currentUser(3);
    // The only live read endpoint for an arbitrary user is admin-only. A
    // Brand must not call it, so use the authenticated account record. It is
    // refreshed locally whenever the profile update endpoint succeeds.
    return Map<String, dynamic>.from(user);
  }

  static Future<void> updateBasic({
    required int expectedRole,
    required String name,
    required String email,
    required String phone,
  }) async {
    final user = await currentUser(expectedRole);
    final trimmedName = name.trim();
    final trimmedEmail = email.trim();
    if (trimmedName.isEmpty || trimmedEmail.isEmpty) {
      throw const ApiException('Name and email are required.');
    }
    if (!RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(trimmedEmail)) {
      throw const ApiException('Enter a valid email address.');
    }
    await AuthApi.request('PUT', '/api/auth/update-profile', {
      'name': trimmedName,
      'email': trimmedEmail,
      'phone': phone.trim(),
    });
    final parts = trimmedName.split(RegExp(r'\s+'));
    await AuthApi.saveUser({
      ...user,
      'name': trimmedName,
      'first_name': parts.first,
      'last_name': parts.length > 1 ? parts.sublist(1).join(' ') : '',
      'email': trimmedEmail,
      'mobile_number': phone.trim(),
    });
  }

  static Future<void> updateCreator({
    required Map<String, dynamic> original,
    required String bio,
    required String state,
    required String city,
    required String dateOfBirth,
    int? categoryId,
    int? genderId,
  }) async {
    await currentUser(2);
    await AuthApi.request('POST', '/api/creator/profile', {
      'category_id': categoryId ?? original['category_id'],
      'gender_id': genderId ?? original['gender_id'],
      'bio': bio.trim(),
      'state': state.trim(),
      'city': city.trim(),
      'date_of_birth': dateOfBirth.isEmpty ? null : dateOfBirth,
      'reels_price': original['reels_price'] ?? 0,
      'story_price': original['story_price'] ?? 0,
      'post_price': original['post_price'] ?? 0,
      'delivery_days': original['delivery_days'] ?? 0,
    });
  }

  static Future<List<Map<String, dynamic>>> categories() async {
    final result = await AuthApi.request('GET', '/api/instagram-categories');
    final data = result['data'];
    if (data is! List) return [];
    return data
        .whereType<Map>()
        .map((item) => Map<String, dynamic>.from(item))
        .toList();
  }

  static Future<List<Map<String, dynamic>>> genders() async {
    final result = await AuthApi.request('GET', '/api/admin/genders/list');
    final data = result['data'];
    if (data is! List) return [];
    return data
        .whereType<Map>()
        .map((item) => Map<String, dynamic>.from(item))
        .toList();
  }
}
