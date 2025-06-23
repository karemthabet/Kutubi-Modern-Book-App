import 'package:bookly_app/core/utils/assets/app_assets.dart';
import 'package:bookly_app/core/utils/colors/app_colors.dart';
import 'package:bookly_app/core/utils/screens/app_screens.dart';
import 'package:bookly_app/core/utils/styles/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class BookListViewItem extends StatelessWidget {
  const BookListViewItem({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => GoRouter.of(context).push(AppScreens.bookScreenDetails),
      child: Row(
        children: [
          Container(
            height: 120.h,
            width: 100.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
              color: Colors.amberAccent,
              image: const DecorationImage(
                image: AssetImage(AppAssets.testImage),
                fit: BoxFit.fill,
              ),
            ),
          ),
          SizedBox(width: 25.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 200.w,
                  child: Text(
                    "Harry Potter and the Philosopher's Stone",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppStyles.textStyle18,
                  ),
                ),
                Text(
                  "J.K Rowling",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppStyles.textStyle18,
                ),
                Row(
                  children: [
                    Text(
                      "19.99\$",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppStyles.textStyle18,
                    ),
                    const Spacer(),
                    const Icon(
                      FontAwesomeIcons.solidStar,
                      color: AppColors.yellowColor,
                    ),
                    SizedBox(width: 9.w),
                    Text("4.9", style: AppStyles.textStyle18),
                    SizedBox(width: 13.w),
                    Text(
                      "(2025)",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppStyles.textStyle18.copyWith(
                        color: AppColors.greyColor,
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
