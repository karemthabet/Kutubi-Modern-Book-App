import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class BookListItemShimmer extends StatelessWidget {
  const BookListItemShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              height: 120.h,
              width: 100.w,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
              ),
            ),
          ),
          SizedBox(width: 16.w),

          // ✅ shimmer للنصوص
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // العنوان
                shimmerLine(width: 200.w, height: 16.h),
                SizedBox(height: 6.h),

                // المؤلف
                shimmerLine(width: 150.w, height: 14.h),
                SizedBox(height: 8.h),

                // السعر والتقييم والسنة
                Row(
                  children: [
                    shimmerLine(width: 40.w, height: 12.h),
                    const Spacer(),
                    shimmerLine(width: 14.w, height: 12.h),
                    SizedBox(width: 10.w),
                    shimmerLine(width: 30.w, height: 12.h),
                    SizedBox(width: 10.w),
                    shimmerLine(width: 40.w, height: 12.h),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget shimmerLine({required double width, required double height}) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: width,
        height: height,
        color: Colors.white,
      ),
    );
  }
}
