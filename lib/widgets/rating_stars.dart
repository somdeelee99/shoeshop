import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/constants/app_colors.dart';
import '../core/constants/app_text_styles.dart';

/// Compact "★ 4.8 (320)" rating row.
class RatingStars extends StatelessWidget {
  final double rating;
  final int reviewCount;
  final bool showCount;

  const RatingStars({
    super.key,
    required this.rating,
    this.reviewCount = 0,
    this.showCount = true,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.star_rounded, size: 14.r, color: AppColors.star),
        SizedBox(width: 3.w),
        Text(
          rating.toStringAsFixed(1),
          style: AppTextStyles.captionBold.copyWith(fontSize: 11.sp),
        ),
        if (showCount && reviewCount > 0) ...[
          SizedBox(width: 3.w),
          Text(
            '($reviewCount)',
            style: AppTextStyles.small.copyWith(fontSize: 10.sp),
          ),
        ],
      ],
    );
  }
}
