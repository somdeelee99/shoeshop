import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/utils/validators.dart';
import '../../widgets/app_button.dart';
import '../../widgets/app_text_field.dart';
import '../../widgets/common_ui.dart';
import 'payment_view_model.dart';

/// Screen 12 — Payment: method radios, card form, pay CTA.
class PaymentView extends GetView<PaymentViewModel> {
  const PaymentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: const SimpleAppBar(title: 'Payment'),
      body: Obx(
        () => ListView(
          padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 24.h),
          children: [
            _stepBar(),
            SizedBox(height: 20.h),
            Text('Select Payment Method', style: AppTextStyles.title),
            SizedBox(height: 12.h),
            for (int i = 0; i < controller.methods.length; i++)
              Padding(
                padding: EdgeInsets.only(bottom: 10.h),
                child: _methodTile(i),
              ),
            if (controller.isCardMethod) ...[
              SizedBox(height: 10.h),
              _cardForm(),
            ],
            SizedBox(height: 20.h),
            // Amount
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14.r),
                border: Border.all(color: AppColors.border),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total Amount', style: AppTextStyles.bodyGrey),
                  Text(
                    '\$${controller.amountLabel}',
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w800,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
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
        child: Obx(
          () => AppButton(
            label: 'Pay \$${controller.amountLabel}',
            loading: controller.isLoading.value,
            onPressed: controller.pay,
          ),
        ),
      ),
    );
  }

  Widget _stepBar() {
    return Row(
      children: [
        _step(1, 'Shipping', false),
        Expanded(
            child: Container(height: 2, color: AppColors.primary)),
        _step(2, 'Payment', true),
        Expanded(
            child: Container(height: 2, color: AppColors.border)),
        _step(3, 'Review', false),
      ],
    );
  }

  Widget _step(int index, String label, bool active) {
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
          child: Text('$index',
              style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w800,
                  color: active ? Colors.white : AppColors.textHint)),
        ),
        SizedBox(height: 4.h),
        Text(label,
            style: TextStyle(
                fontSize: 10.sp,
                fontWeight: FontWeight.w600,
                color: active ? AppColors.textPrimary : AppColors.textHint)),
      ],
    );
  }

  Widget _methodTile(int index) {
    final method = controller.methods[index];
    final selected = controller.selectedMethod.value == index;
    return GestureDetector(
      onTap: () => controller.selectMethod(index),
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
            Icon(method['icon'] as IconData,
                size: 22.r, color: AppColors.textPrimary),
            SizedBox(width: 10.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(method['title'] as String,
                      style: TextStyle(
                          fontSize: 13.sp, fontWeight: FontWeight.w700)),
                  Text(method['subtitle'] as String,
                      style: TextStyle(
                          fontSize: 10.5.sp,
                          color: AppColors.textSecondary)),
                ],
              ),
            ),
            if (index == 0)
              Row(
                children: [
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1A1F71),
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    child: Text('VISA',
                        style: TextStyle(
                            fontSize: 8.sp,
                            fontWeight: FontWeight.w800,
                            color: Colors.white)),
                  ),
                  SizedBox(width: 4.w),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEB001B),
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    child: Text('MC',
                        style: TextStyle(
                            fontSize: 8.sp,
                            fontWeight: FontWeight.w800,
                            color: Colors.white)),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _cardForm() {
    return Form(
      key: controller.cardFormKey,
      child: Container(
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Card Number',
                style: TextStyle(
                    fontSize: 11.sp, fontWeight: FontWeight.w600)),
            SizedBox(height: 6.h),
            AppTextField(
              controller: controller.cardNumber,
              hint: '1234 5678 9012 3456',
              keyboardType: TextInputType.number,
              validator: Validators.cardNumber,
            ),
            SizedBox(height: 12.h),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Expiry Date',
                          style: TextStyle(
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w600)),
                      SizedBox(height: 6.h),
                      AppTextField(
                        controller: controller.expiry,
                        hint: 'MM/YY',
                        keyboardType: TextInputType.datetime,
                        validator: Validators.expiry,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('CVV',
                          style: TextStyle(
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w600)),
                      SizedBox(height: 6.h),
                      AppTextField(
                        controller: controller.cvv,
                        hint: '123',
                        keyboardType: TextInputType.number,
                        validator: Validators.cvv,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            Text('Cardholder Name',
                style: TextStyle(
                    fontSize: 11.sp, fontWeight: FontWeight.w600)),
            SizedBox(height: 6.h),
            AppTextField(
              controller: controller.cardHolder,
              hint: 'SOMDEE LEE',
              validator: (v) => Validators.required(v, 'Cardholder name'),
            ),
            SizedBox(height: 10.h),
            Row(
              children: [
                SizedBox(
                  width: 22.r,
                  height: 22.r,
                  child: Checkbox(
                    value: controller.saveCard.value,
                    onChanged: controller.toggleSaveCard,
                  ),
                ),
                SizedBox(width: 8.w),
                Text('Save card for next time',
                    style: TextStyle(fontSize: 11.5.sp)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
