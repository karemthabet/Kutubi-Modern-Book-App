import 'dart:developer';
import 'package:bookly_app/features/home/domain/entities/book_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bookly_app/core/utils/styles/app_styles.dart';
import 'package:bookly_app/features/home/presentation/widgets/custom_list_view_item.dart';
import 'package:bookly_app/features/home/presentation/widgets/custom_list_view_shimmer.dart';
import 'package:bookly_app/features/home/presentation/manager/cubit/featured_books_cubit.dart';

class CustomListViewItemBlocBuilder extends StatelessWidget {
  const CustomListViewItemBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FeaturedBooksCubit, FeaturedBooksState>(
      builder: (context, state) {
        if (state is FeaturedBooksFailure) {
          log(state.errMessage);
          return Center(
            child: Text(
              state.errMessage,
              style: AppStyles.textStyle18.copyWith(
                fontSize: 14.sp,
                color: Colors.red,
              ),
              textAlign: TextAlign.center,
            ),
          );
        }

        // 🔄 2. تحميل أول مرة (initial or loading)
        if (state is FeaturedBooksInitial || state is FeaturedBooksLoading) {
          return const CustomListViewItemShimmer();
        }

        // ✅ 3. نجح التحميل أو جاب صفحة جديدة
        List<BookEntity> books = [];
        bool isLoadingMore = false;
        bool hasPaginationError = false;

        if (state is FeaturedBooksSuccess) {
          books = state.books;
        } else if (state is FeaturedBooksPaginationLoading) {
          books = state.oldBooks;
          isLoadingMore = true;
        } else if (state is FeaturedBooksPaginationFailure) {
          books = state.oldBooks;
          hasPaginationError = true;
        }

        return Column(
          children: [
            // ✅ عرض الكتب
            CustomListViewItem(bookEntity: books, hasMoreData: true),

            // 🔄 لو بنحمّل داتا جديدة
            if (isLoadingMore)
              Padding(
                padding: EdgeInsets.only(top: 12.h),
                child: const CircularProgressIndicator(strokeWidth: 2),
              ),

            // ❌ لو حصل فشل أثناء تحميل pagination
            if (hasPaginationError)
              Padding(
                padding: EdgeInsets.only(top: 12.h),
                child: Text(
                  'Could not load more books. Showing available data. Please check your internet connection.',
                  style: AppStyles.textStyle18.copyWith(
                    fontSize: 14.sp,
                    color: Colors.redAccent,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
          ],
        );
      },
    );
  }
}
