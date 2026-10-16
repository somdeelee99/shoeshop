import 'package:intl/intl.dart';

import '../constants/app_constants.dart';

/// Currency & date formatting helpers (intl).
class Formatters {
  Formatters._();

  static final NumberFormat _currency = NumberFormat.currency(
    symbol: AppConstants.currencySymbol,
    decimalDigits: 0,
  );

  static final DateFormat _orderDate = DateFormat('MMM d, yyyy');
  static final DateFormat _fullDate = DateFormat('MMM d, yyyy · HH:mm');

  static String price(num value) => _currency.format(value);

  static String discount(int percent) => '-$percent%';

  static String orderDate(DateTime date) => _orderDate.format(date);

  static String fullDate(DateTime date) => _fullDate.format(date);

  static String timeAgo(DateTime date) {
    final diff = DateTime.now().difference(date);
    if (diff.inMinutes < 1) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes} minutes ago';
    if (diff.inHours < 24) return '${diff.inHours} hours ago';
    if (diff.inDays == 1) return '1 day ago';
    if (diff.inDays < 7) return '${diff.inDays} days ago';
    return _orderDate.format(date);
  }

  static String orderStatusTime(DateTime date) => '${_orderDate.format(date)}\n'
      '${DateFormat('HH:mm').format(date)}';
}
