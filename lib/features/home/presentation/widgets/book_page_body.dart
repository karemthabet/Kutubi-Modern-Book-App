import 'package:bookly_app/features/home/presentation/widgets/news_books_list_view_with_pagination.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bookly_app/core/utils/styles/app_styles.dart';
import 'package:bookly_app/features/home/presentation/widgets/custom_app_bar.dart';
import 'package:bookly_app/features/home/presentation/widgets/custom_list_view_bloc_builder.dart';

class BookPageBody extends StatelessWidget {
  BookPageBody({super.key});

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.symmetric(horizontal: 6, vertical: 5),
      child: CustomScrollView(
        controller: _scrollController,
        slivers: [
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
          NewsBooksSliverListWithPagination(controller: _scrollController),
        ],
      ),
    );
  }
}
