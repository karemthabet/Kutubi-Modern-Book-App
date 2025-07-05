import 'package:bookly_app/core/utils/assets/app_assets.dart';
import 'package:bookly_app/features/home/domain/entities/book_entity.dart';
import 'package:bookly_app/features/home/presentation/manager/cubit/featured_books_cubit.dart';
import 'package:bookly_app/features/home/presentation/widgets/custom_item_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomListViewItem extends StatefulWidget {
  final List<BookEntity> bookEntity;
  final bool hasMoreData;

  const CustomListViewItem({
    super.key,
    required this.bookEntity,
    required this.hasMoreData,
  });

  @override
  State<CustomListViewItem> createState() => _CustomListViewItemState();
}

class _CustomListViewItemState extends State<CustomListViewItem> {
  late ScrollController scrollController;
  int nextPage = 1;
  bool isLoadingMore = false;

  @override
  void initState() {
    scrollController = ScrollController();
    scrollController.addListener(_onScroll);
    super.initState();
  }

  void _onScroll() {
    final threshold = scrollController.position.maxScrollExtent * 0.7;

    if (scrollController.position.pixels >= threshold &&
        !isLoadingMore &&
        widget.hasMoreData) {
      isLoadingMore = true;

      context
          .read<FeaturedBooksCubit>()
          .getFeaturedBooks(pageNumber: nextPage++)
          .then((_) {
            // بعد ما الريكوست يخلص رجع isLoadingMore = false
            isLoadingMore = false;
          });
    }
  }

  @override
  void dispose() {
    scrollController.removeListener(_onScroll);
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220.h,
      child: ListView.builder(
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        itemCount: widget.bookEntity.length,
        itemBuilder: (context, index) {
          return CustomItemContainer(
            image: widget.bookEntity[index].image ?? AppAssets.imageNotFound,
          );
        },
      ),
    );
  }
}
