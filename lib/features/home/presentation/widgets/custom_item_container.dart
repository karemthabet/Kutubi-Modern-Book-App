import 'package:bookly_app/core/utils/assets/app_assets.dart';
import 'package:bookly_app/core/utils/screens/app_screens.dart';
import 'package:bookly_app/features/home/domain/entities/book_entity.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

class CustomItemContainer extends StatelessWidget {
  final String image;
  final BookEntity book;

  const CustomItemContainer({super.key, required this.image, required this.book});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        GoRouter.of(context).push(AppScreens.bookScreenDetails,extra: book);
      },
      child: Container(
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
              (context, url) => Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(color: Colors.white),
              ),

          errorWidget:
              (context, url, error) =>
                  Image.asset(AppAssets.imageNotFound, fit: BoxFit.fill),
        ),
      ),
    );
  }
}
