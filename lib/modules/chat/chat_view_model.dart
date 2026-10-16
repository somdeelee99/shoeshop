import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/models/misc_models.dart';
import '../../data/repositories/chat_repository.dart';

/// Customer-support chat state.
class ChatViewModel extends GetxController {
  final ChatRepository _chatRepository = ChatRepository();

  final TextEditingController messageController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  RxList<ChatMessageModel> get messages => _chatRepository.messages;
  final RxBool isSending = false.obs;

  @override
  void onInit() {
    super.onInit();
    _chatRepository.fetchHistory();
    ever(messages, (_) => _scrollToBottom());
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 280),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Future<void> send() async {
    final text = messageController.text.trim();
    if (text.isEmpty) return;
    messageController.clear();
    isSending.value = true;
    await _chatRepository.send(text);
    isSending.value = false;
    _scrollToBottom();
  }

  void attachProduct() {
    Get.snackbar('Attach', 'Product picker opens here.',
        snackPosition: SnackPosition.BOTTOM);
  }

  @override
  void onClose() {
    messageController.dispose();
    scrollController.dispose();
    super.onClose();
  }
}
