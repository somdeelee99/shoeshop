import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/utils/formatters.dart';
import '../../data/models/cart_model.dart';
import '../../widgets/app_button.dart';
import '../../widgets/cached_image.dart';
import '../../widgets/common_ui.dart';
import '../../widgets/qty_stepper.dart';
import 'cart_view_model.dart';

/// Screen 10 — Cart: item list, promo code, totals, checkout CTA.
class CartView extends GetView<CartViewModel> {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: SimpleAppBar(
        title: 'My Cart',
        actions: [
          Obx(
            () => controller.selectedIds.isEmpty
                ? const SizedBox.shrink()
                : IconButton(
                    onPressed: controller.deleteSelected,
                    icon: const Icon(Icons.delete_outline_rounded,
                        color: AppColors.primary),
                  ),
          ),
        ],
      ),
      body: Obx(
        () => controller.items.isEmpty
            ? const EmptyState(
                icon: Icons.shopping_cart_outlined,
                title: 'Your cart is empty',
                subtitle: 'Looks like you have not added anything yet.',
              )
            : ListView(
                padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 16.h),
                children: [
                  // Select all + delete
                  Row(
                    children: [
                      _checkBox(
                        controller.selectAll.value,
                        controller.toggleSelectAll,
                      ),
                      SizedBox(width: 8.w),
                      Text('Select All',
                          style: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w700)),
                      const Spacer(),
                      GestureDetector(
                        onTap: controller.deleteSelected,
                        child: Row(
                          children: [
                            Icon(Icons.delete_outline_rounded,
                                size: 18.r, color: AppColors.primary),
                            SizedBox(width: 4.w),
                            Text('Delete',
                                style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.primary)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  for (final item in controller.items) ...[
                    _cartTile(item),
                    SizedBox(height: 10.h),
                  ],
                  SizedBox(height: 6.h),
                  _promoField(),
                  SizedBox(height: 14.h),
                  _summary(),
                ],
              ),
      ),
      bottomNavigationBar: Obx(
        () => controller.items.isEmpty
            ? const SizedBox.shrink()
            : Container(
                padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 20.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.06),
                      blurRadius: 14,
                      offset: const Offset(0, -4),
                    ),
                  ],
                ),
                child: AppButton(
                  label: 'Checkout  🛍',
                  onPressed: controller.checkout,
                ),
              ),
      ),
    );
  }

  Widget _cartTile(CartItemModel item) {
    final selected = controller.isSelected(item);
    return Container(
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(
          color: selected ? AppColors.primary.withOpacity(0.5) : AppColors.border,
        ),
      ),
      child: Row(
        children: [
          _checkBox(selected, () => controller.toggleItem(item)),
          SizedBox(width: 8.w),
          AppCachedImage(
            url: item.product.imageUrl,
            width: 64.w,
            height: 64.w,
            radius: 10,
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.product.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 13.sp, fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 2.h),
                Text(
                  '${item.product.brand} · ${item.product.category}',
                  style: TextStyle(
                      fontSize: 10.sp, color: AppColors.textSecondary),
                ),
                SizedBox(height: 2.h),
                Text(
                  'Size: ${item.size.toStringAsFixed(0)}',
                  style: TextStyle(
                      fontSize: 10.sp, color: AppColors.textSecondary),
                ),
                SizedBox(height: 6.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      Formatters.price(item.product.price),
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w800,
                        color: AppColors.primary,
                      ),
                    ),
                    QtyStepper(
                      value: item.quantity,
                      onChanged: (value) {
                        if (value > item.quantity) {
                          controller.increase(item);
                        } else {
                          controller.decrease(item);
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _checkBox(bool checked, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 20.r,
        height: 20.r,
        decoration: BoxDecoration(
          color: checked ? AppColors.primary : Colors.white,
          borderRadius: BorderRadius.circular(5.r),
          border: Border.all(
            color: checked ? AppColors.primary : AppColors.textHint,
            width: 1.4,
          ),
        ),
        child: checked
            ? Icon(Icons.check_rounded, size: 14.r, color: Colors.white)
            : null,
      ),
    );
  }

  Widget _promoField() {
    final controller2 = TextEditingController();
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          const Icon(Icons.local_offer_outlined,
              size: 18, color: AppColors.textHint),
          SizedBox(width: 8.w),
          Expanded(
            child: TextField(
              controller: controller2,
              decoration: InputDecoration(
                hintText: 'Enter promo code',
                hintStyle: TextStyle(
                    fontSize: 12.sp, color: AppColors.textHint),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                isDense: true,
                filled: true,
                fillColor: Colors.white,
                contentPadding: EdgeInsets.zero,
              ),
              style: TextStyle(fontSize: 12.sp),
            ),
          ),
          GestureDetector(
            onTap: () => controller.applyPromo(controller2.text),
            child: Text('Apply',
                style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w800,
                    color: AppColors.primary)),
          ),
        ],
      ),
    );
  }

  Widget _summary() {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          _row('Subtotal', Formatters.price(controller.subtotal)),
          SizedBox(height: 6.h),
          _row('Shipping', Formatters.price(controller.shippingFee)),
          if (controller.promoDiscount.value > 0) ...[
            SizedBox(height: 6.h),
            _row('Promo (${controller.promoCode.value})',
                '-${Formatters.price(controller.promoDiscount.value)}',
                highlight: AppColors.success),
          ],
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: const Divider(color: AppColors.divider),
          ),
          _row('Total', Formatters.price(controller.total), bold: true),
        ],
      ),
    );
  }

  Widget _row(String label, String value,
      {bool bold = false, Color? highlight}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: bold
                ? AppTextStyles.title
                : AppTextStyles.bodyGrey),
        Text(
          value,
          style: TextStyle(
            fontSize: bold ? 16.sp : 13.sp,
            fontWeight: bold ? FontWeight.w800 : FontWeight.w700,
            color: highlight ??
                (bold ? AppColors.primary : AppColors.textPrimary),
          ),
        ),
      ],
    );
  }
}
