import 'package:bookly_app/core/utils/colors/app_colors.dart';
import 'package:bookly_app/core/utils/styles/app_styles.dart';
import 'package:bookly_app/features/home/presentation/widgets/book_list_view_item.dart';
import 'package:bookly_app/features/search/presentation/manager/cubit/search_cubit.dart';
import 'package:bookly_app/features/search/presentation/widgets/build_custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchPageBody extends StatefulWidget {
  const SearchPageBody({super.key});

  @override
  State<SearchPageBody> createState() => _SearchPageBodyState();
}

class _SearchPageBodyState extends State<SearchPageBody> {
  late TextEditingController searchController;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BuildCustomTextFeild(searchController: searchController),
          Text("Search Result", style: AppStyles.textStyle18),
          SizedBox(height: 10.h),

          BlocBuilder<SearchCubit, SearchState>(
            builder: (context, state) {
              if (state is SearchFailure) {
                return Center(
                  child: Text(
                    state.errorMessage,
                    style: AppStyles.textStyle18.copyWith(color: Colors.grey),
                  ),
                );
              }
              if (state is SearchSuccess) {
                if (state.books.isEmpty) {
                  return Expanded(
                    child: Text(
                      "🙁 No books found. Try another title.",
                      textAlign: TextAlign.center,
                      style: AppStyles.textStyle18.copyWith(color: Colors.grey),
                    ),
                  );
                }

                return Expanded(
                  child: ListView.builder(
                    itemCount: state.books.length,
                    itemBuilder:
                        (context, index) =>
                            BookListViewItem(book: state.books[index]),
                  ),
                );
              }
              return const Center(
                child: CircularProgressIndicator(color: AppColors.primaryColor),
              );
            },
          ),
        ],
      ),
    );
  }
}
