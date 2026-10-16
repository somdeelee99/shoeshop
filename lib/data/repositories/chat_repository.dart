import 'package:get/get.dart';

import '../mock/mock_data.dart';
import '../models/misc_models.dart';
import '../models/product_model.dart';
import '../providers/api_endpoints.dart';
import '../providers/api_provider.dart';

/// Customer-support chat repository.
class ChatRepository {
  final RxList<ChatMessageModel> messages = <ChatMessageModel>[].obs;

  ChatRepository() {
    messages.assignAll(MockData.chatMessages);
  }

  Future<List<ChatMessageModel>> fetchHistory() async {
    if (ApiProvider.useMock) {
      await Future<void>.delayed(const Duration(milliseconds: 400));
      return messages;
    }
    final response = await ApiProvider.get(ApiEndpoints.chat);
    return (response.data['data'] as List<dynamic>)
        .map((e) => ChatMessageModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<ChatMessageModel> send(String text,
      {ProductModel? attachment}) async {
    final message = ChatMessageModel(
      id: 'm-${DateTime.now().microsecondsSinceEpoch}',
      text: text,
      isFromAdmin: false,
      sentAt: DateTime.now(),
      attachment: attachment,
    );
    messages.add(message);

    if (!ApiProvider.useMock) {
      await ApiProvider.post(ApiEndpoints.chat, data: message.toJson());
      return message;
    }

    // Simulated auto-reply from admin (demo only).
    await Future<void>.delayed(const Duration(milliseconds: 1400));
    messages.add(
      ChatMessageModel(
        id: 'a-${DateTime.now().microsecondsSinceEpoch}',
        text: 'Thanks for your message! Our team will get back to you '
            'shortly.',
        isFromAdmin: true,
        sentAt: DateTime.now(),
      ),
    );
    return message;
  }
}
