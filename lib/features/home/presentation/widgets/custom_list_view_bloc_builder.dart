import 'dart:developer';
import 'package:bookly_app/core/utils/colors/app_colors.dart';
import 'package:bookly_app/core/utils/styles/app_styles.dart';
import 'package:bookly_app/features/home/presentation/manager/cubit/featured_books_cubit.dart';
import 'package:bookly_app/features/home/presentation/widgets/custom_list_view_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomListViewItemBlocBuilder extends StatelessWidget {
  const CustomListViewItemBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FeaturedBooksCubit, FeaturedBooksState>(
      builder: (context, state) {
        // ✅ في حالة نجاح عادي
        if (state is FeaturedBooksSuccess) {
          return CustomListViewItem(
            bookEntity: state.books,
            hasMoreData: state.hasMoreData,
          );
        }
        // ✅ في حالة تحميل صفحة جديدة
        else if (state is FeaturedBooksPaginationLoading) {
          return Stack(
            children: [
              CustomListViewItem(bookEntity: state.oldBooks, hasMoreData: true),
              Positioned(
                bottom: 0,
                right: 16,
                child: SizedBox(
                  width: 30.w,
                  height: 30.w,
                  child: const CircularProgressIndicator(
                    strokeWidth: 2,
                    color: AppColors.whiteColor,
                  ),
                ),
              ),
            ],
          );
        }
        // ✅ في حالة فشل أثناء Pagination
        else if (state is FeaturedBooksPaginationFailure) {
          return Stack(
            children: [
              CustomListViewItem(bookEntity: state.oldBooks, hasMoreData: true),
              Positioned(
                bottom: 0,
                right: 16,
                child: Icon(Icons.error_outline, color: Colors.red, size: 30.w),
              ),
            ],
          );
        }
        // ✅ في حالة فشل أول تحميل
        else if (state is FeaturedBooksFailure) {
          log(state.errMessage);
          return Center(
            child: Text(
              state.errMessage,
              textAlign: TextAlign.center,
              style: AppStyles.textStyle18.copyWith(
                fontSize: 14.sp,
                color: Colors.redAccent,
              ),
            ),
          );
        }
        // ✅ أول مرة لسه بيحمل
        else {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.whiteColor),
          );
        }
      },
    );
  }
}
