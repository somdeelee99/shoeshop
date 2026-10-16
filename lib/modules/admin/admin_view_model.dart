import 'package:get/get.dart';

import '../../data/mock/mock_data.dart';

/// Admin dashboard state (web/app): KPIs, sales chart, recent orders.
class AdminViewModel extends GetxController {
  final RxInt selectedNav = 0.obs;

  final List<String> navItems = [
    'Dashboard',
    'Products',
    'Orders',
    'Customers',
    'Inventory',
    'Transactions',
    'Settings',
  ];

  Map<String, dynamic> get stats => MockData.adminStats;
  List<Map<String, dynamic>> get sales => MockData.salesOverview;
  List<Map<String, dynamic>> get recentOrders => MockData.recentOrders;

  double get maxSales => sales
      .map((e) => (e['value'] as num).toDouble())
      .reduce((a, b) => a > b ? a : b);

  void selectNav(int index) => selectedNav.value = index;

  String statusColor(String status) {
    switch (status) {
      case 'Completed':
        return '0xFF22C55E';
      case 'Shipping':
        return '0xFF3B82F6';
      default:
        return '0xFFF97316';
    }
  }
}
