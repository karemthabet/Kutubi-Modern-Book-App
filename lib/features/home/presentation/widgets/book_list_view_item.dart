import 'package:bookly_app/core/utils/colors/app_colors.dart';
import 'package:bookly_app/core/utils/screens/app_screens.dart';
import 'package:bookly_app/core/utils/styles/app_styles.dart';
import 'package:bookly_app/features/home/domain/entities/book_entity.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

class BookListViewItem extends StatelessWidget {
  const BookListViewItem({
    super.key,
 
    required this.book,
  });

 
  final BookEntity book;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => GoRouter.of(context).push(AppScreens.bookScreenDetails,extra: book),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 100.w,
              height: 120.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
                color: Colors.grey[300],
              ),
              clipBehavior: Clip.antiAlias,
              child: CachedNetworkImage(
                imageUrl: book.image !,
                fit: BoxFit.fill,
                placeholder: (context, url) => Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(color: Colors.white),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),

            SizedBox(width: 16.w),

            // ✅ بيانات الكتاب
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    book.title,
                    style: AppStyles.textStyle18.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 6.h),

                  // المؤلف
                  Text(
                    book.authorName!,
                    style: AppStyles.textStyle18.copyWith(
                      color: AppColors.greyColor,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 8.h),

                  // السعر والتقييم والسنة
                 
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
