import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bookly_app/features/home/domain/entities/book_entity.dart';
import 'package:bookly_app/features/home/presentation/manager/cubit/news_books_cubit.dart';
import 'package:bookly_app/features/home/presentation/widgets/book_list_view_item.dart';
import 'package:bookly_app/features/home/presentation/widgets/book_list_item_shimmer.dart';
import 'package:bookly_app/core/utils/styles/app_styles.dart';

class NewsBooksSliverListWithPagination extends StatefulWidget {
  final ScrollController controller;

  const NewsBooksSliverListWithPagination({
    super.key,
    required this.controller,
  });

  @override
  State<NewsBooksSliverListWithPagination> createState() =>
      _NewsBooksSliverListWithPaginationState();
}

class _NewsBooksSliverListWithPaginationState
    extends State<NewsBooksSliverListWithPagination> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onScroll);
  }

  void _onScroll() {
    final threshold = widget.controller.position.maxScrollExtent * 0.8;

    if (widget.controller.position.pixels >= threshold) {
      context.read<NewsBooksCubit>().getNewsBooks();
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onScroll);
    widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsBooksCubit, NewsBooksState>(
      builder: (context, state) {
        List<BookEntity> books = [];
        bool hasPaginationError = false;

        if (state is NewsBooksSuccess) {
          books = state.books;
        } else if (state is NewsBooksPaginationLoading) {
          books = state.oldBooks;
        } else if (state is NewsBooksPaginationFailure) {
          books = state.oldBooks;
          hasPaginationError = true;
        } else if (state is NewsBooksFailure) {
          return SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 24.h),
              child: Center(
                child: Text(
                  state.errMessage,
                  style: AppStyles.textStyle18.copyWith(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          );
        } else {
          return SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => const BookListItemShimmer(),
              childCount: 6,
            ),
          );
        }

        return SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            if (index < books.length) {
              final book = books[index];
              return BookListViewItem(
                book: book,
              
              );
            } else {
              if (hasPaginationError) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  child: Center(
                    child: Text(
                      'Could not load more books, please check your connection and try again.',
                      style: AppStyles.textStyle18.copyWith(color: Colors.red),
                    ),
                  ),
                );
              } else {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  child: const Center(
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                );
              }
            }
          }, childCount: books.length + 1),
        );
      },
    );
  }
}
