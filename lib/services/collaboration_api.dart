import 'auth_api.dart';

class CollaborationApi {
  static Future<List<Map<String, dynamic>>> deals() async {
    final response = await AuthApi.request('GET', '/api/collab/deals');
    return _list(response['data']);
  }

  static Future<Map<String, dynamic>> deal(int dealId) async {
    final response = await AuthApi.request('GET', '/api/collab/deal/$dealId');
    return _map(response['data'], 'deal details');
  }

  static Future<List<Map<String, dynamic>>> messages(int dealId) async {
    final response = await AuthApi.request(
      'GET',
      '/api/collab/chat/$dealId?offset=0&limit=100',
    );
    return _list(response['data']);
  }

  static Future<void> sendMessage(int dealId, String content) =>
      AuthApi.request('POST', '/api/collab/chat/$dealId', {'content': content});

  static Future<void> applyToCampaign({
    required int campaignId,
    required num amount,
    String? message,
  }) async {
    await AuthApi.request('POST', '/api/collab/apply', {
      'campaign_id': campaignId,
      'amount': amount,
      if (message != null && message.trim().isNotEmpty)
        'message': message.trim(),
    });
  }

  static Future<void> makeOffer({
    required int dealId,
    required num amount,
    String? message,
  }) => AuthApi.request('POST', '/api/collab/offer', {
    'deal_id': dealId,
    'amount': amount,
    if (message != null && message.trim().isNotEmpty) 'message': message.trim(),
  });

  static Future<void> acceptOffer(int dealId) =>
      AuthApi.request('POST', '/api/collab/accept', {'deal_id': dealId});

  static Future<Map<String, dynamic>> initiatePayment(int dealId) async {
    final response = await AuthApi.request(
      'POST',
      '/api/collab/payment/initiate',
      {'deal_id': dealId},
    );
    return _map(response['data'], 'payment order');
  }

  static Future<void> submitLinks(int dealId, List<String> links) =>
      AuthApi.request('POST', '/api/collab/links/$dealId', {'links': links});

  static Future<void> approveLinks(int dealId) =>
      AuthApi.request('POST', '/api/collab/approve/$dealId');

  static Future<void> disapproveLinks(int dealId, {String? reason}) =>
      AuthApi.request('POST', '/api/collab/disapprove/$dealId', {
        if (reason != null && reason.trim().isNotEmpty) 'reason': reason.trim(),
      });

  static List<Map<String, dynamic>> _list(Object? value) {
    if (value is! List) return const [];
    return value
        .whereType<Map>()
        .map((item) => Map<String, dynamic>.from(item))
        .toList();
  }

  static Map<String, dynamic> _map(Object? value, String name) {
    if (value is! Map) {
      throw ApiException('The server returned invalid $name.');
    }
    return Map<String, dynamic>.from(value);
  }
}
