import 'package:bookly_app/core/utils/styles/app_styles.dart';
import 'package:bookly_app/features/home/presentation/manager/cubit/news_books_cubit.dart';
import 'package:bookly_app/features/home/presentation/widgets/book_list_item_shimmer.dart';
import 'package:bookly_app/features/home/presentation/widgets/book_list_view_item.dart';
import 'package:bookly_app/features/home/presentation/widgets/custom_app_bar.dart';
import 'package:bookly_app/features/home/presentation/widgets/custom_list_view_bloc_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookPageBody extends StatefulWidget {
  const BookPageBody({super.key});

  @override
  State<BookPageBody> createState() => _BookPageBodyState();
}

class _BookPageBodyState extends State<BookPageBody> {
  late ScrollController _scrollController;
  int _nextPage = 1;
  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
  }

  void _onScroll() {
    final cubit = context.read<NewsBooksCubit>();
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent * 0.7 &&
        !_isLoadingMore &&
        cubit.hasMoreData) {
      _isLoadingMore = true;
      cubit.getNewsBooks(pageNumber: _nextPage++).then((_) {
        _isLoadingMore = false;
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.symmetric(vertical: 5, horizontal: 6),
      child: CustomScrollView(
        controller: _scrollController,
        slivers: [
          // ✅ التوب بار + الهيدر
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomAppBar(),
                const CustomListViewItemBlocBuilder(),
                SizedBox(height: 20.h),
                Text("Sports Books", style: AppStyles.textStyle18),
                SizedBox(height: 10.h),
              ],
            ),
          ),

          // ✅ بناء القائمة بناءً على حالة Bloc
          BlocBuilder<NewsBooksCubit, NewsBooksState>(
            builder: (context, state) {
              // ✅ الحالة: تحميل ناجح
              if (state is NewsBooksSuccess) {
                return SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final book = state.books[index];
                    return BookListViewItem(
                      image: book.image!,
                      text: book.title,
                      subText: book.authorName!,
                      rating: book.rating!,
                      price: book.price!,
                    );
                  }, childCount: state.books.length),
                );
              } else if (state is NewsBooksPaginationFailure) {
                return SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    if (index < state.oldBooks.length) {
                      final book = state.oldBooks[index];
                      return BookListViewItem(
                        image: book.image!,
                        text: book.title,
                        subText: book.authorName!,
                        rating: book.rating!,
                        price: book.price!,
                      );
                    } else {
                      // ✅ نعرض error icon بدل الشيمر
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 20.h),
                        child: Center(
                          child: Column(
                            children: [
                              const Icon(
                                Icons.error,
                                color: Colors.red,
                                size: 30,
                              ),
                              SizedBox(height: 8.h),
                              Text(
                                "فشل تحميل المزيد: ${state.errMessage}",
                                style: AppStyles.textStyle18.copyWith(
                                  color: Colors.red,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                  }, childCount: state.oldBooks.length + 1),
                );
              }
              // ✅ الحالة: فشل في التحميل
              else if (state is NewsBooksFailure) {
                return SliverToBoxAdapter(
                  child: Center(
                    child: Text(
                      state.errMessage,
                      style: AppStyles.textStyle18.copyWith(color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              }
              // ✅ الحالة: أول تحميل (شيمر)
              else {
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => const BookListItemShimmer(),
                    childCount: 6,
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
