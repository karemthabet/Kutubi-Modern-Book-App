import 'package:bookly_app/core/utils/assets/app_assets.dart';
import 'package:bookly_app/features/home/domain/entities/book_entity.dart';
import 'package:bookly_app/features/home/presentation/widgets/custom_item_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomListViewItem extends StatelessWidget {
  final List<BookEntity> bookEntity;

  const CustomListViewItem({super.key, required this.bookEntity});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: bookEntity.length,
        itemBuilder: (context, index) {
          return CustomItemContainer(
            image:
                bookEntity[index].image ??
                AppAssets.imageNotFound,
          );
        },
      ),
    );
  }
}
