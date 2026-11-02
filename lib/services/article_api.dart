import 'auth_api.dart';

class ArticleApi {
  static Future<List<Map<String, dynamic>>> list({String search = ''}) async {
    final query = <String>['page=1', 'limit=50'];
    if (search.trim().isNotEmpty) {
      query.add('search=${Uri.encodeQueryComponent(search.trim())}');
    }
    final response = await AuthApi.request(
      'GET',
      '/api/articles?${query.join('&')}',
    );
    final data = response['data'];
    if (data is! List) return const [];
    return data
        .whereType<Map>()
        .map((item) => Map<String, dynamic>.from(item))
        .toList();
  }

  static Future<Map<String, dynamic>> details(int articleId) async {
    final response = await AuthApi.request('GET', '/api/articles/$articleId');
    final data = response['data'];
    if (data is! Map) {
      throw const ApiException('The server returned an invalid article.');
    }
    return Map<String, dynamic>.from(data);
  }

  static Future<bool> setLiked(int articleId, bool liked) async {
    final response = await AuthApi.request(
      liked ? 'POST' : 'DELETE',
      '/api/articles/$articleId/like',
    );
    final data = response['data'];
    return data is Map && data['liked'] == true;
  }

  static Future<int> likeCount(int articleId) async {
    final response = await AuthApi.request(
      'GET',
      '/api/articles/$articleId/likes',
    );
    final data = response['data'];
    return data is Map
        ? int.tryParse(data['total_likes']?.toString() ?? '') ?? 0
        : 0;
  }

  static Future<void> submitFeedback(int articleId, bool helpful) =>
      AuthApi.request('POST', '/api/articles/$articleId/feedback', {
        'is_helpful': helpful,
      });
}
