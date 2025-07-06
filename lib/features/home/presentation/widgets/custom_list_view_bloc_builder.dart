import 'dart:developer';
import 'package:bookly_app/features/home/domain/entities/book_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bookly_app/core/utils/styles/app_styles.dart';
import 'package:bookly_app/features/home/presentation/widgets/custom_list_view_item.dart';
import 'package:bookly_app/features/home/presentation/widgets/custom_list_view_shimmer.dart';
import 'package:bookly_app/features/home/presentation/manager/cubit/featured_books_cubit.dart';

class CustomListViewItemBlocBuilder extends StatefulWidget {
  const CustomListViewItemBlocBuilder({super.key});

  @override
  State<CustomListViewItemBlocBuilder> createState() =>
      _CustomListViewItemBlocBuilderState();
}

class _CustomListViewItemBlocBuilderState
    extends State<CustomListViewItemBlocBuilder> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  /// 📦 عند الاقتراب من نهاية الـ ListView نطلب صفحة جديدة
  void _onScroll() {
    final threshold = _scrollController.position.maxScrollExtent * 0.8;

    if (_scrollController.position.pixels >= threshold) {
      context.read<FeaturedBooksCubit>().getFeaturedBooks();
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FeaturedBooksCubit, FeaturedBooksState>(
      builder: (context, state) {
        // ❌ فشل التحميل الأول
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

        // 🔄 تحميل أول مرة
        if (state is FeaturedBooksInitial || state is FeaturedBooksLoading) {
          return const CustomListViewItemShimmer();
        }

        // ✅ نجاح التحميل أو pagination
        List<BookEntity> books = [];
        bool isLoadingMore = false;
        bool hasPaginationError = false;

        // 📚 نحدد الكتب حسب نوع الحالة
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
            CustomListViewItem(books: books, controller: _scrollController),

            // 🔄 Spinner أسفل الكتب أثناء تحميل صفحة جديدة
            if (isLoadingMore)
              Padding(
                padding: EdgeInsets.only(top: 12.h),
                child: const CircularProgressIndicator(strokeWidth: 2),
              ),

            // ❌ رسالة خطأ في حالة فشل pagination
            if (hasPaginationError)
              Padding(
                padding: EdgeInsets.only(top: 12.h),
                child: Text(
                  'Could not load more books, please check your connection and try again.',
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
