/// Authenticated user + shipping address models.
class UserModel {
  final String id;
  final String fullName;
  final String email;
  final String phone;
  final String avatarUrl;
  final String gender;
  final DateTime memberSince;

  const UserModel({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.avatarUrl,
    this.gender = 'Male',
    required this.memberSince,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'] as String? ?? '',
        fullName: json['full_name'] as String? ?? '',
        email: json['email'] as String? ?? '',
        phone: json['phone'] as String? ?? '',
        avatarUrl: json['avatar_url'] as String? ?? '',
        gender: json['gender'] as String? ?? 'Male',
        memberSince: json['member_since'] != null
            ? DateTime.parse(json['member_since'] as String)
            : DateTime.now(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'full_name': fullName,
        'email': email,
        'phone': phone,
        'avatar_url': avatarUrl,
        'gender': gender,
        'member_since': memberSince.toIso8601String(),
      };

  UserModel copyWith({
    String? fullName,
    String? email,
    String? phone,
    String? avatarUrl,
    String? gender,
  }) =>
      UserModel(
        id: id,
        fullName: fullName ?? this.fullName,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        avatarUrl: avatarUrl ?? this.avatarUrl,
        gender: gender ?? this.gender,
        memberSince: memberSince,
      );
}

class AddressModel {
  final String id;
  final String label; // Home / Office / ...
  final String street;
  final String city;
  final String phone;
  final bool isDefault;

  const AddressModel({
    required this.id,
    required this.label,
    required this.street,
    required this.city,
    required this.phone,
    this.isDefault = false,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
        id: json['id'] as String? ?? '',
        label: json['label'] as String? ?? '',
        street: json['street'] as String? ?? '',
        city: json['city'] as String? ?? '',
        phone: json['phone'] as String? ?? '',
        isDefault: json['is_default'] as bool? ?? false,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'label': label,
        'street': street,
        'city': city,
        'phone': phone,
        'is_default': isDefault,
      };

  AddressModel copyWith({
    String? label,
    String? street,
    String? city,
    String? phone,
    bool? isDefault,
  }) =>
      AddressModel(
        id: id,
        label: label ?? this.label,
        street: street ?? this.street,
        city: city ?? this.city,
        phone: phone ?? this.phone,
        isDefault: isDefault ?? this.isDefault,
      );
}
