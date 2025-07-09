import 'package:bookly_app/core/utils/colors/app_colors.dart';
import 'package:bookly_app/core/utils/styles/app_styles.dart';
import 'package:bookly_app/core/widgets/custom_button.dart';
import 'package:bookly_app/features/home/domain/entities/book_entity.dart';
import 'package:bookly_app/features/home/presentation/widgets/custom_book_details_app_bar.dart';
import 'package:bookly_app/features/home/presentation/widgets/custom_item_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookPageDetailsBody extends StatelessWidget {
  const BookPageDetailsBody({super.key, required this.book});
  final BookEntity book;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.symmetric(horizontal: 33),
      child: Column(
        children: [
          const CustomBookDetailsAppBar(),
          SizedBox(
            height: 320.h,
            width: 200.w,
            child: CustomItemContainer(image: book.image!,book: book,),
          ),
          SizedBox(height: 30.h),

          Text(
            book.title,
            style: AppStyles.textStyle18,
            textAlign: TextAlign.center,
          ),

          Text(
            book.authorName!,
            style: AppStyles.textStyle18.copyWith(
              color: AppColors.greyColor,
              fontSize: 15.sp,
            ),
          ),
          SizedBox(height: 12.h),

       
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
        ],
      ),
    );
  }
}
