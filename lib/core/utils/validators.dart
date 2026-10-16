/// Form validators for auth & profile forms.
class Validators {
  Validators._();

  static String? emailOrPhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your email or phone number';
    }
    final v = value.trim();
    final isEmail = RegExp(r'^[\w\.\-+]+@[\w\-]+\.[\w\.\-]+$').hasMatch(v);
    final isPhone = RegExp(r'^\+?[0-9\s\-]{8,15}$').hasMatch(v);
    if (!isEmail && !isPhone) {
      return 'Enter a valid email or phone number';
    }
    return null;
  }

  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your email';
    }
    if (!RegExp(r'^[\w\.\-+]+@[\w\-]+\.[\w\.\-]+$').hasMatch(value.trim())) {
      return 'Enter a valid email address';
    }
    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) return 'Please enter your password';
    if (value.length < 6) return 'Password must be at least 6 characters';
    return null;
  }

  static String? required(String? value, [String field = 'This field']) {
    if (value == null || value.trim().isEmpty) return '$field is required';
    return null;
  }

  static String? phone(String? value) {
    if (value == null || value.trim().isEmpty)
      return 'Please enter phone number';
    if (!RegExp(r'^\+?[0-9\s\-]{8,15}$').hasMatch(value.trim())) {
      return 'Enter a valid phone number';
    }
    return null;
  }

  static String? cardNumber(String? value) {
    final v = (value ?? '').replaceAll(' ', '');
    if (v.isEmpty) return 'Please enter card number';
    if (v.length < 16) return 'Card number must be 16 digits';
    return null;
  }

  static String? expiry(String? value) {
    if (value == null || value.trim().isEmpty) return 'Required';
    if (!RegExp(r'^(0[1-9]|1[0-2])\s?/\s?\d{2}$').hasMatch(value.trim())) {
      return 'Use MM/YY';
    }
    return null;
  }

  static String? cvv(String? value) {
    if (value == null || value.trim().isEmpty) return 'Required';
    if (value.trim().length < 3) return 'CVV must be 3 digits';
    return null;
  }
}
