import 'package:bookly_app/core/utils/assets/app_assets.dart';
import 'package:bookly_app/features/home/domain/entities/book_entity.dart';
import 'package:bookly_app/features/home/presentation/widgets/custom_item_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// ✅ Widget مسؤول عن رسم الـ ListView بشكل أفقي لعرض الكتب

class CustomListViewItem extends StatelessWidget {
  final List<BookEntity> books;
  final ScrollController controller;

  const CustomListViewItem({
    super.key,
    required this.books,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220.h,
      child: ListView.builder(
        key: const PageStorageKey('featured-books-scroll'), // لحفظ مكان التمرير
        controller: controller, // نمرر الكنترولر عشان نتابع التمرير
        scrollDirection: Axis.horizontal,
        itemCount: books.length,
        itemBuilder: (context, index) {
          return CustomItemContainer(
            image: books[index].image ?? AppAssets.imageNotFound,
          );
        },
      ),
    );
  }
}
