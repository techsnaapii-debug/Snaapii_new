import 'auth_api.dart';

class SearchApi {
  static Future<List<Map<String, dynamic>>> campaigns(String query) async {
    final encoded = Uri.encodeQueryComponent(query.trim());
    final result = await AuthApi.request(
      'GET',
      '/api/search/campaigns?q=$encoded&page=1&limit=20',
    );
    final data = result['data'];
    if (data is! List) return const [];
    return data
        .whereType<Map>()
        .map((item) => Map<String, dynamic>.from(item))
        .toList();
  }
}
