import 'package:bookly_app/core/utils/styles/app_styles.dart';
import 'package:bookly_app/features/home/presentation/widgets/book_list_view_item.dart';
import 'package:bookly_app/features/search/presentation/widgets/build_custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchPageBody extends StatelessWidget {
  const SearchPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const BuildCustomTextFeild(),
          Text("Search Result", style: AppStyles.textStyle18),
          SizedBox(height: 10.h),

          Expanded(
            child: ListView.separated(
              itemCount: 10,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) => const BookListViewItem(),
            ),
          ),
        ],
      ),
    );
  }
}
