import 'package:bookly_app/core/utils/assets/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomItemContainer extends StatelessWidget {
  const CustomItemContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: REdgeInsets.symmetric(horizontal: 5),
      width: 120.w, // ✅ عرض العنصر
      height: 200.h, // ✅ ارتفاع العنصر
      decoration: BoxDecoration(
        color: Colors.amberAccent,
        borderRadius: BorderRadius.circular(16.r),
        image: DecorationImage(
          image: const AssetImage(AppAssets.testImage),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
