import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../core/constants/app_colors.dart';
import '../../data/models/user_model.dart';
import '../../widgets/common_ui.dart';
import 'addresses_view_model.dart';

/// Screen 17 — My Addresses: address cards with edit + add new.
class AddressesView extends GetView<AddressesViewModel> {
  const AddressesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: const SimpleAppBar(title: 'My Addresses'),
      body: Obx(
        () => controller.addresses.isEmpty
            ? const EmptyState(
                icon: Icons.location_off_outlined,
                title: 'No addresses yet',
                subtitle: 'Add an address to speed up checkout.',
              )
            : ListView.separated(
                padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 24.h),
                itemCount: controller.addresses.length + 1,
                separatorBuilder: (_, __) => SizedBox(height: 10.h),
                itemBuilder: (_, index) {
                  if (index == controller.addresses.length) {
                    return GestureDetector(
                      onTap: controller.openAddSheet,
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 15.h),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14.r),
                          border: Border.all(
                              color: AppColors.primary.withOpacity(0.4)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add_rounded,
                                size: 18.r, color: AppColors.primary),
                            SizedBox(width: 6.w),
                            Text('Add New Address',
                                style: TextStyle(
                                    fontSize: 12.5.sp,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.primary)),
                          ],
                        ),
                      ),
                    );
                  }
                  return _addressCard(controller.addresses[index], index);
                },
              ),
      ),
    );
  }

  Widget _addressCard(AddressModel address, int index) {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(
          color: address.isDefault
              ? AppColors.primary
              : AppColors.border,
          width: address.isDefault ? 1.5 : 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            address.isDefault
                ? Icons.radio_button_on_rounded
                : Icons.radio_button_off_rounded,
            size: 20.r,
            color:
                address.isDefault ? AppColors.primary : AppColors.textHint,
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: GestureDetector(
              onTap: () => controller.select(index),
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
                      GestureDetector(
                        onTap: () => controller.openEditSheet(address),
                        child: Text('Edit',
                            style: TextStyle(
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w700,
                                color: AppColors.primary)),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    '${address.street}, ${address.city}',
                    style: TextStyle(
                        fontSize: 11.5.sp,
                        color: AppColors.textSecondary),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    address.phone,
                    style: TextStyle(
                        fontSize: 11.5.sp,
                        color: AppColors.textSecondary),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
