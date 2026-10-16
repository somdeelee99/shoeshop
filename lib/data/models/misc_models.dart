import 'product_model.dart';

/// In-app notification entry.
class AppNotificationModel {
  final String id;
  final String title;
  final String body;
  final String type; // order | promo | system
  final DateTime time;
  final bool isRead;

  const AppNotificationModel({
    required this.id,
    required this.title,
    required this.body,
    required this.type,
    required this.time,
    this.isRead = false,
  });

  factory AppNotificationModel.fromJson(Map<String, dynamic> json) =>
      AppNotificationModel(
        id: json['id'] as String? ?? '',
        title: json['title'] as String? ?? '',
        body: json['body'] as String? ?? '',
        type: json['type'] as String? ?? 'system',
        time: DateTime.parse(json['time'] as String),
        isRead: json['is_read'] as bool? ?? false,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'body': body,
        'type': type,
        'time': time.toIso8601String(),
        'is_read': isRead,
      };
}

/// Chat message (customer support).
class ChatMessageModel {
  final String id;
  final String text;
  final bool isFromAdmin;
  final DateTime sentAt;
  final ProductModel? attachment;

  const ChatMessageModel({
    required this.id,
    required this.text,
    required this.isFromAdmin,
    required this.sentAt,
    this.attachment,
  });

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) =>
      ChatMessageModel(
        id: json['id'] as String? ?? '',
        text: json['text'] as String? ?? '',
        isFromAdmin: json['is_from_admin'] as bool? ?? false,
        sentAt: DateTime.parse(json['sent_at'] as String),
        attachment: json['attachment'] != null
            ? ProductModel.fromJson(
                json['attachment'] as Map<String, dynamic>)
            : null,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'text': text,
        'is_from_admin': isFromAdmin,
        'sent_at': sentAt.toIso8601String(),
        'attachment': attachment?.toJson(),
      };
}

/// Payment method (radio list on Payment screen).
class PaymentMethodModel {
  final String id;
  final String title;
  final String subtitle;
  final String icon; // material icon codePoint name
  final bool enabled;

  const PaymentMethodModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.icon,
    this.enabled = true,
  });

  factory PaymentMethodModel.fromJson(Map<String, dynamic> json) =>
      PaymentMethodModel(
        id: json['id'] as String? ?? '',
        title: json['title'] as String? ?? '',
        subtitle: json['subtitle'] as String? ?? '',
        icon: json['icon'] as String? ?? 'credit_card',
        enabled: json['enabled'] as bool? ?? true,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'subtitle': subtitle,
        'icon': icon,
        'enabled': enabled,
      };
}

/// Home carousel banner.
class BannerModel {
  final String id;
  final String title;
  final String subtitle;
  final String buttonText;
  final String imageUrl;

  const BannerModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.buttonText,
    required this.imageUrl,
  });
}
