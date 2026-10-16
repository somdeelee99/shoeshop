import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../core/constants/app_assets.dart';
import '../../core/constants/app_colors.dart';
import '../../core/utils/formatters.dart';
import '../../data/models/misc_models.dart';
import 'chat_view_model.dart';

/// Screens 21–22 — Chat with Admin: bubbles, product attachment, input bar.
class ChatView extends GetView<ChatViewModel> {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        leading: IconButton(
          onPressed: Get.back,
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
        ),
        title: Row(
          children: [
            CircleAvatar(
              radius: 18.r,
              backgroundImage: const NetworkImage(AppImages.avatar2),
            ),
            SizedBox(width: 10.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Admin',
                    style: TextStyle(
                        fontSize: 15.sp, fontWeight: FontWeight.w700)),
                Row(
                  children: [
                    Container(
                      width: 7.r,
                      height: 7.r,
                      decoration: const BoxDecoration(
                        color: AppColors.success,
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Text('Online',
                        style: TextStyle(
                            fontSize: 10.5.sp,
                            color: AppColors.success)),
                  ],
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.more_vert_rounded)),
        ],
      ),
      body: Obx(
        () => Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: controller.scrollController,
                padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 12.h),
                itemCount: controller.messages.length,
                itemBuilder: (_, index) =>
                    _bubble(controller.messages[index]),
              ),
            ),
            _inputBar(),
          ],
        ),
      ),
    );
  }

  Widget _bubble(ChatMessageModel message) {
    final isAdmin = message.isFromAdmin;
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        mainAxisAlignment:
            isAdmin ? MainAxisAlignment.start : MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (isAdmin) ...[
            CircleAvatar(
              radius: 14.r,
              backgroundImage: const NetworkImage(AppImages.avatar2),
            ),
            SizedBox(width: 8.w),
          ],
          Flexible(
            child: Column(
              crossAxisAlignment: isAdmin
                  ? CrossAxisAlignment.start
                  : CrossAxisAlignment.end,
              children: [
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 9.h),
                  decoration: BoxDecoration(
                    color: isAdmin ? Colors.white : AppColors.primary,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(14.r),
                      topRight: Radius.circular(14.r),
                      bottomLeft: Radius.circular(isAdmin ? 4.r : 14.r),
                      bottomRight: Radius.circular(isAdmin ? 14.r : 4.r),
                    ),
                    border: isAdmin
                        ? Border.all(color: AppColors.border)
                        : null,
                  ),
                  child: Text(
                    message.text,
                    style: TextStyle(
                      fontSize: 12.5.sp,
                      height: 1.4,
                      color: isAdmin
                          ? AppColors.textPrimary
                          : Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 3.h),
                Text(
                  Formatters.timeAgo(message.sentAt).contains('ago')
                      ? Formatters.timeAgo(message.sentAt)
                      : Formatters.timeAgo(message.sentAt),
                  style: TextStyle(
                      fontSize: 9.sp, color: AppColors.textHint),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _inputBar() {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.fromLTRB(12.w, 8.h, 12.w, 10.h),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 12,
              offset: const Offset(0, -3),
            ),
          ],
        ),
        child: Row(
          children: [
            IconButton(
              onPressed: controller.attachProduct,
              icon: Icon(Icons.add_circle_outline_rounded,
                  size: 24.r, color: AppColors.textSecondary),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 14.w),
                decoration: BoxDecoration(
                  color: AppColors.lightGrey,
                  borderRadius: BorderRadius.circular(22.r),
                ),
                child: TextField(
                  controller: controller.messageController,
                  minLines: 1,
                  maxLines: 4,
                  decoration: InputDecoration(
                    hintText: 'Type a message...',
                    hintStyle: TextStyle(
                        fontSize: 12.5.sp, color: AppColors.textHint),
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(vertical: 10.h),
                  ),
                  style: TextStyle(fontSize: 12.5.sp),
                ),
              ),
            ),
            SizedBox(width: 8.w),
            GestureDetector(
              onTap: controller.send,
              child: Container(
                width: 42.r,
                height: 42.r,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.send_rounded,
                    size: 19.r, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
