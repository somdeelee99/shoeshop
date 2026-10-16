import 'package:get/get.dart';

import '../../core/routes/app_routes.dart';
import '../../data/models/order_model.dart';
import '../../data/repositories/order_repository.dart';

/// Order history with status tabs.
class OrdersViewModel extends GetxController {
  final OrderRepository _orderRepository = Get.find<OrderRepository>();

  final RxList<OrderModel> orders = <OrderModel>[].obs;
  final RxString selectedTab = 'All'.obs;
  final RxBool isLoading = true.obs;

  final List<String> tabs = ['All', 'Processing', 'Shipping', 'Completed'];

  @override
  void onInit() {
    super.onInit();
    load();
    ever(_orderRepository.orders, (_) => applyTab());
  }

  Future<void> load() async {
    isLoading.value = true;
    final data = await _orderRepository.getOrders();
    orders.assignAll(data);
    applyTab();
    isLoading.value = false;
  }

  void selectTab(String tab) {
    selectedTab.value = tab;
    applyTab();
  }

  void applyTab() {
    final tab = selectedTab.value;
    if (tab == 'All') {
      orders.assignAll(_orderRepository.orders);
    } else {
      orders.assignAll(
        _orderRepository.orders
            .where((o) => o.status.label == tab)
            .toList(),
      );
    }
  }

  void openOrder(OrderModel order) {
    Get.toNamed(AppRoutes.orderDetail, arguments: order);
  }
}
