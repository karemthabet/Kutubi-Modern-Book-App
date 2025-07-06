import 'package:bookly_app/core/utils/assets/app_assets.dart';
import 'package:bookly_app/features/home/domain/entities/book_entity.dart';
import 'package:bookly_app/features/home/presentation/widgets/custom_item_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CutomFeaturedListView extends StatelessWidget {
  const CutomFeaturedListView({super.key, required this.books});
  final List<BookEntity> books;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: books.length,
        itemBuilder:
            (context, index) => CustomItemContainer(
              book: books[index],
              image: books[index].image ?? AppAssets.imageNotFound,
            ),
      ),
    );
  }
}
