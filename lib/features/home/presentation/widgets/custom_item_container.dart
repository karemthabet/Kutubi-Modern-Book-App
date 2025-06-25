import 'package:bookly_app/core/utils/assets/app_assets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomItemContainer extends StatelessWidget {
  final String image;

  const CustomItemContainer({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: REdgeInsets.symmetric(horizontal: 5),
      width: 120.w,
      height: 200.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        color: Colors.grey[200],
      ),
      clipBehavior: Clip.antiAlias, 
      child: CachedNetworkImage(
        imageUrl: image,
        fit: BoxFit.fill,
        placeholder:
            (context, url) => const Center(
              child: CircularProgressIndicator(color: Colors.blue),
            ),
        errorWidget:
            (context, url, error) =>
                Image.asset(AppAssets.imageNotFound, fit: BoxFit.cover),
      ),
    );
  }
}
