import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'auth_api.dart';

class AiReply {
  const AiReply({required this.chatId, required this.reply});

  final String chatId;
  final String reply;
}

class AiHistoryMessage {
  const AiHistoryMessage({required this.role, required this.message});

  final String role;
  final String message;

  bool get isUser => role.toLowerCase() == 'user';
}

class AiApi {
  static const _storage = FlutterSecureStorage();

  static Future<String?> _chatKey() async {
    final user = await AuthApi.readUser();
    final userId = user?['user_id']?.toString();
    return userId == null || userId.isEmpty ? null : 'last_ai_chat_$userId';
  }

  static Future<AiReply> sendMessage({
    required String message,
    String? chatId,
  }) async {
    final result = await AuthApi.request('POST', '/api/ai/chat', {
      'message': message.trim(),
      if (chatId != null && chatId.isNotEmpty) 'chatId': chatId,
    }, const Duration(seconds: 25));
    final data = result['data'];
    if (data is! Map) {
      throw const ApiException('The AI service returned an invalid response.');
    }

    final reply = data['reply']?.toString().trim();
    final returnedChatId = (data['chat_id'] ?? data['chatId'])?.toString();
    if (reply == null ||
        reply.isEmpty ||
        returnedChatId == null ||
        returnedChatId.isEmpty) {
      throw const ApiException(
        'The AI service returned an incomplete response.',
      );
    }
    await _saveLastChatId(returnedChatId);
    return AiReply(chatId: returnedChatId, reply: reply);
  }

  static Future<void> _saveLastChatId(String chatId) async {
    final key = await _chatKey();
    if (key != null) await _storage.write(key: key, value: chatId);
  }

  static Future<String?> lastChatId() async {
    final key = await _chatKey();
    return key == null ? null : _storage.read(key: key);
  }

  static Future<void> clearLastChat() async {
    final key = await _chatKey();
    if (key != null) await _storage.delete(key: key);
  }

  static Future<List<AiHistoryMessage>> history(String chatId) async {
    final result = await AuthApi.request(
      'GET',
      '/api/ai/history/${Uri.encodeComponent(chatId)}',
    );
    final data = result['data'];
    if (data is! List) {
      throw const ApiException(
        'The AI service returned an invalid chat history.',
      );
    }
    return data
        .whereType<Map>()
        .map((item) {
          final message = item['message']?.toString().trim() ?? '';
          final role = item['role']?.toString() ?? 'assistant';
          return AiHistoryMessage(role: role, message: message);
        })
        .where((item) => item.message.isNotEmpty)
        .toList();
  }
}
