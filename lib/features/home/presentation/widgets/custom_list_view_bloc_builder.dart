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
        if (state is FeaturedBooksSuccess) {
          return CustomListViewItem(bookEntity: state.books);
        } else if (state is FeaturedBooksFailure) {
          return Text(state.errMessage,style: AppStyles.textStyle18.copyWith(fontSize: 14.sp));
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
