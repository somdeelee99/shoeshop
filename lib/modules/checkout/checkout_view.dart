import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/utils/formatters.dart';
import '../../widgets/app_button.dart';
import '../../widgets/common_ui.dart';
import 'checkout_view_model.dart';

/// Screen 11 — Checkout: step indicator, address picker, shipping method.
class CheckoutView extends GetView<CheckoutViewModel> {
  const CheckoutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: const SimpleAppBar(title: 'Checkout'),
      body: Obx(
        () => ListView(
          padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 24.h),
          children: [
            _stepBar(),
            SizedBox(height: 20.h),
            _sectionTitle('Shipping Address'),
            SizedBox(height: 12.h),
            if (controller.addresses.isEmpty)
              _addressCard(controller.selectedAddress, true, () {})
            else
              for (int i = 0; i < controller.addresses.length; i++)
                Padding(
                  padding: EdgeInsets.only(bottom: 10.h),
                  child: _addressCard(
                    controller.addresses[i],
                    controller.selectedAddressIndex.value == i,
                    () => controller.selectAddress(i),
                  ),
                ),
            // Add new
            GestureDetector(
              onTap: controller.addNewAddress,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 14.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14.r),
                  border:
                      Border.all(color: AppColors.primary.withOpacity(0.4)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add_rounded,
                        size: 18.r, color: AppColors.primary),
                    SizedBox(width: 6.w),
                    Text('Add New Address',
                        style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primary)),
                  ],
                ),
              ),
            ),
            SizedBox(height: 22.h),
            _sectionTitle('Shipping Method'),
            SizedBox(height: 12.h),
            for (int i = 0; i < controller.shippingMethods.length; i++)
              Padding(
                padding: EdgeInsets.only(bottom: 10.h),
                child: _shippingTile(i),
              ),
            SizedBox(height: 18.h),
            _priceSummary(),
          ],
        ),
      ),
      bottomNavigationBar: Container(
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
          label: 'Continue to Payment',
          onPressed: controller.continueToPayment,
        ),
      ),
    );
  }

  Widget _stepBar() {
    return Row(
      children: [
        for (int i = 0; i < controller.steps.length; i++) ...[
          Obx(
            () => _stepCircle(
              index: i + 1,
              label: controller.steps[i],
              active: controller.currentStep.value >= i,
            ),
          ),
          if (i < controller.steps.length - 1)
            Expanded(
              child: Container(
                height: 2,
                color: controller.currentStep.value > i
                    ? AppColors.primary
                    : AppColors.border,
              ),
            ),
        ],
      ],
    );
  }

  Widget _stepCircle({
    required int index,
    required String label,
    required bool active,
  }) {
    return Column(
      children: [
        Container(
          width: 30.r,
          height: 30.r,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: active ? AppColors.primary : Colors.white,
            shape: BoxShape.circle,
            border: Border.all(
              color: active ? AppColors.primary : AppColors.border,
              width: 1.5,
            ),
          ),
          child: Text(
            '$index',
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w800,
              color: active ? Colors.white : AppColors.textHint,
            ),
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          label,
          style: TextStyle(
            fontSize: 10.sp,
            fontWeight: FontWeight.w600,
            color: active ? AppColors.textPrimary : AppColors.textHint,
          ),
        ),
      ],
    );
  }

  Widget _sectionTitle(String text) =>
      Text(text, style: AppTextStyles.title);

  Widget _addressCard(dynamic address, bool selected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(
            color:
                selected ? AppColors.primary : AppColors.border,
            width: selected ? 1.6 : 1,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              selected
                  ? Icons.radio_button_on_rounded
                  : Icons.radio_button_off_rounded,
              size: 20.r,
              color: selected ? AppColors.primary : AppColors.textHint,
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(address.label,
                          style: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w800)),
                      const Spacer(),
                      Text('Edit',
                          style: TextStyle(
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w700,
                              color: AppColors.primary)),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    '${address.street}, ${address.city}',
                    style: TextStyle(
                        fontSize: 11.sp,
                        color: AppColors.textSecondary),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    address.phone,
                    style: TextStyle(
                        fontSize: 11.sp,
                        color: AppColors.textSecondary),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _shippingTile(int index) {
    final method = controller.shippingMethods[index];
    final selected = controller.selectedShipping.value == index;
    return GestureDetector(
      onTap: () => controller.selectShipping(index),
      child: Container(
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(
            color: selected ? AppColors.primary : AppColors.border,
            width: selected ? 1.6 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              selected
                  ? Icons.radio_button_on_rounded
                  : Icons.radio_button_off_rounded,
              size: 20.r,
              color: selected ? AppColors.primary : AppColors.textHint,
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(method['name'] as String,
                      style: TextStyle(
                          fontSize: 13.sp, fontWeight: FontWeight.w700)),
                  SizedBox(height: 2.h),
                  Text(method['eta'] as String,
                      style: TextStyle(
                          fontSize: 11.sp,
                          color: AppColors.textSecondary)),
                ],
              ),
            ),
            Text(
              Formatters.price((method['fee'] as num).toDouble()),
              style: TextStyle(
                  fontSize: 13.sp, fontWeight: FontWeight.w800),
            ),
          ],
        ),
      ),
    );
  }

  Widget _priceSummary() {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          _line('Subtotal', Formatters.price(controller.subtotal)),
          SizedBox(height: 6.h),
          _line('Shipping', Formatters.price(controller.shippingFee)),
          const Divider(height: 18),
          _line('Total', Formatters.price(controller.total), bold: true),
        ],
      ),
    );
  }

  Widget _line(String label, String value, {bool bold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: bold ? AppTextStyles.title : AppTextStyles.bodyGrey),
        Text(
          value,
          style: TextStyle(
            fontSize: bold ? 16.sp : 13.sp,
            fontWeight: bold ? FontWeight.w800 : FontWeight.w700,
            color: bold ? AppColors.primary : AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}
