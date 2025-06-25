import 'package:bookly_app/core/utils/constants/app_constants.dart';
import 'package:bookly_app/features/home/domain/entities/book_entity.dart';
import 'package:hive/hive.dart';

abstract class HomeLocalDataSource {
  List<BookEntity> fetchFeaturedBooks();
  List<BookEntity> fetchNewsBooks();
}

class HomeLocalDataSourceImpl implements HomeLocalDataSource {
  @override
  List<BookEntity> fetchFeaturedBooks() {
    var box = Hive.box<BookEntity>(AppConstants.featuredBox);
    return box.values.toList();
  }

  @override
  List<BookEntity> fetchNewsBooks() {
    var newsBox = Hive.box<BookEntity>(AppConstants.newsBox);
    return newsBox.values.toList();
  }
}
