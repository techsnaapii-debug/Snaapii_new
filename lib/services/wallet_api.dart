import 'auth_api.dart';

class WalletApi {
  static Future<Map<String, dynamic>> _currentUser(int roleId) async {
    final user = await AuthApi.readUser();
    if (user == null || user['user_id'] == null) {
      throw const ApiException('Please log in again.');
    }
    if (int.tryParse(
          (user['rtype_id'] ?? user['usertype_id'])?.toString() ?? '',
        ) !=
        roleId) {
      throw const ApiException('This account cannot access this wallet.');
    }
    return user;
  }

  static Future<Map<String, dynamic>> brandWallet() async {
    final user = await _currentUser(3);
    final result = await AuthApi.request(
      'GET',
      '/api/brand-wallet?brand_user_id=${Uri.encodeQueryComponent(user['user_id'].toString())}',
    );
    final data = result['data'];
    if (data is! Map) {
      throw const ApiException('The server returned an invalid wallet.');
    }
    return Map<String, dynamic>.from(data);
  }

  static Future<Map<String, dynamic>> creatorWallet() async {
    await _currentUser(2);
    final result = await AuthApi.request('GET', '/api/collab/wallet');
    final data = result['data'];
    if (data is! Map) {
      throw const ApiException('The server returned an invalid wallet.');
    }
    return Map<String, dynamic>.from(data);
  }

  static Future<List<Map<String, dynamic>>> payoutAccounts() async {
    await _currentUser(2);
    final result = await AuthApi.request('GET', '/api/creator/payout-accounts');
    final data = result['data'];
    final records = data is List
        ? data
        : data is Map && data['accounts'] is List
        ? data['accounts'] as List
        : const <dynamic>[];
    return records
        .whereType<Map>()
        .map((item) => Map<String, dynamic>.from(item))
        .toList();
  }

  static Future<Map<String, dynamic>> addBankAccount({
    required String accountNumber,
    required String ifsc,
    required String holderName,
  }) async {
    await _currentUser(2);
    final result =
        await AuthApi.request('POST', '/api/creator/payout-account', {
          'account_type': 'bank',
          'bank_account_number': accountNumber,
          'bank_ifsc': ifsc,
          'account_holder_name': holderName,
        });
    return _dataMap(result);
  }

  static Future<Map<String, dynamic>> addUpiAccount(String upiId) async {
    await _currentUser(2);
    final result = await AuthApi.request(
      'POST',
      '/api/creator/payout-account',
      {'account_type': 'upi', 'upi_id': upiId},
    );
    return _dataMap(result);
  }

  static Future<void> withdraw({
    required num amount,
    required int payoutAccountId,
  }) async {
    await _currentUser(2);
    await AuthApi.request('POST', '/api/creator/withdraw', {
      'amount': amount,
      'payout_account_id': payoutAccountId,
    });
  }

  static Future<Map<String, dynamic>> createBrandTopUp(num amount) async {
    await _currentUser(3);
    final result = await AuthApi.request(
      'POST',
      '/api/brand-wallet/add-money',
      {'amount': amount},
    );
    return _dataMap(result);
  }

  static Map<String, dynamic> _dataMap(Map<String, dynamic> response) {
    final data = response['data'];
    return data is Map ? Map<String, dynamic>.from(data) : <String, dynamic>{};
  }
}
