import 'dart:developer';

import 'package:bookly_app/core/utils/constants/app_constants.dart';
import 'package:bookly_app/features/home/domain/entities/book_entity.dart';
import 'package:hive/hive.dart';

abstract class HomeLocalDataSource {
  List<BookEntity> fetchFeaturedBooks({int pageNumber = 0});
  List<BookEntity> fetchNewsBooks({int pageNumber = 0});
}

class HomeLocalDataSourceImpl implements HomeLocalDataSource {
  @override
  List<BookEntity> fetchFeaturedBooks({int pageNumber = 0}) {
    final startIndex = pageNumber * 10;
    final endIndex = (pageNumber + 1) * 10;
    var box = Hive.box<BookEntity>(AppConstants.featuredBox);
    int length = box.values.length;
    if (startIndex >= length || endIndex > length) return [];
    var books = box.values.toList().sublist(startIndex, endIndex);
    log('📦 Local Featured Books Count: ${books.length}');
    return books;
  }

  @override
  List<BookEntity> fetchNewsBooks({int pageNumber = 0}) {
    final startIndex = pageNumber * 10;
    final endIndex = (pageNumber + 1) * 10;
    var newsBox = Hive.box<BookEntity>(AppConstants.newsBox);
    int length = newsBox.values.length;
    if (startIndex >= length || endIndex > length) return [];
    var books = newsBox.values.toList().sublist(startIndex, endIndex);
    log('📦 Local News Books Count: ${books.length}');
    return books;
  }
}
