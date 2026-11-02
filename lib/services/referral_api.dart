import 'auth_api.dart';

class ReferralApi {
  /// Returns the authenticated user's referral records. The backend currently
  /// does not document a response schema, so the screen accepts either a list
  /// directly or a list nested in a map.
  static Future<List<Map<String, dynamic>>> getMyReferrals() async {
    final response = await AuthApi.request('GET', '/api/referral');
    final data = response['data'];
    final records = data is List
        ? data
        : data is Map && data['referrals'] is List
        ? data['referrals'] as List
        : const <dynamic>[];

    return records
        .whereType<Map>()
        .map((record) => Map<String, dynamic>.from(record))
        .toList();
  }

  /// Creates a referral code for the logged-in creator. The backend decides
  /// who may create codes and returns its own validation message otherwise.
  static Future<Map<String, dynamic>> create() async {
    final response = await AuthApi.request('POST', '/api/referral/create');
    final data = response['data'];
    return data is Map<String, dynamic>
        ? data
        : data is Map
        ? Map<String, dynamic>.from(data)
        : <String, dynamic>{};
  }
}
