import 'package:bookly_app/core/utils/styles/app_styles.dart';
import 'package:bookly_app/features/home/presentation/manager/cubit/news_books_cubit.dart';
import 'package:bookly_app/features/home/presentation/widgets/book_list_item_shimmer.dart';
import 'package:bookly_app/features/home/presentation/widgets/custom_app_bar.dart';
import 'package:bookly_app/features/home/presentation/widgets/custom_list_view_bloc_builder.dart';
import 'package:bookly_app/features/home/presentation/widgets/book_list_view_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookPageBody extends StatelessWidget {
  const BookPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.symmetric(vertical: 5, horizontal: 6),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomAppBar(),
                const CustomListViewItemBlocBuilder(),
                SizedBox(height: 20.h),
                Text("Computer Books", style: AppStyles.textStyle18),
                SizedBox(height: 10.h),
              ],
            ),
          ),

          BlocBuilder<NewsBooksCubit, NewsBooksState>(
            builder: (context, state) {
              if (state is NewsBooksSuccess) {
                return SliverList.builder(
                  itemCount: state.books.length,
                  itemBuilder: (context, index) {
                    final book = state.books[index];
                    return BookListViewItem(
                      image: book.image!,
                      text: book.title,
                      subText: book.authorName!,
                      rating: book.rating!,
                      price: book.price!,
                    );
                  },
                );
              } else if (state is NewsBooksFailure) {
                return SliverToBoxAdapter(child: Text(state.errMessage));
              } else {
                // ✅ أثناء التحميل
                return SliverList.builder(
                  itemCount: 6,
                  itemBuilder: (context, index) => const BookListItemShimmer(),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
