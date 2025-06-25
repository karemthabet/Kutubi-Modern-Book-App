import 'package:bookly_app/core/utils/colors/app_colors.dart';
import 'package:bookly_app/core/utils/styles/app_styles.dart';
import 'package:bookly_app/core/widgets/custom_button.dart';
import 'package:bookly_app/features/home/presentation/widgets/custom_book_details_app_bar.dart';
import 'package:bookly_app/features/home/presentation/widgets/custom_item_container.dart';
import 'package:bookly_app/features/home/presentation/widgets/cutom_featured_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BookPageDetailsBody extends StatelessWidget {
  const BookPageDetailsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.symmetric(horizontal: 33),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const CustomBookDetailsAppBar(),
            SizedBox(
              height: 320.h,
              width: 200.w,
              child: const CustomItemContainer(
                image: "",
              ),
            ),
            SizedBox(height: 30.h),

            Text("The Jungle Book", style: AppStyles.textStyle18),

            Text(
              "Rudyard Kipling",
              style: AppStyles.textStyle18.copyWith(
                color: AppColors.greyColor,
                fontSize: 15.sp,
              ),
            ),
            SizedBox(height: 12.h),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  FontAwesomeIcons.solidStar,
                  color: AppColors.yellowColor,
                  size: 15,
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
                    fontSize: 15,
                  ),
                ),
              ],
            ),

            SizedBox(height: 20.h),

            Row(
              children: [
                const Expanded(
                  child: CustomButton(
                    backgroundColor: AppColors.whiteColor,
                    forgroundColor: AppColors.primaryColor,
                    text: "19.99",
                  ),
                ),
                SizedBox(width: 12.w),
                const Expanded(
                  child: CustomButton(
                    backgroundColor: AppColors.buttonColor,
                    forgroundColor: AppColors.whiteColor,
                    text: "Free preview",
                  ),
                ),
              ],
            ),

            SizedBox(height: 30.h),

            Align(
              alignment: Alignment.centerLeft,
              child: Text("You can also like", style: AppStyles.textStyle18),
            ),

            SizedBox(height: 10.h),

            const CutomFeaturedListView(),

            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }
}
