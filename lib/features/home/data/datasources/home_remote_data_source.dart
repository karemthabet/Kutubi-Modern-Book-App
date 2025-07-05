import 'dart:developer';

import 'package:bookly_app/core/functions/save_local_data.dart';
import 'package:bookly_app/core/utils/Api/api_services.dart';
import 'package:bookly_app/core/utils/constants/app_constants.dart';
import 'package:bookly_app/features/home/data/models/book/book.dart';
import 'package:bookly_app/features/home/domain/entities/book_entity.dart';

abstract class HomeRemoteDataSource {
  Future<List<BookEntity>> fetchFeaturedBooks({int pageNumber = 0});
  Future<List<BookEntity>> fetchNewsBooks();
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final ApiService apiService;

  HomeRemoteDataSourceImpl({required this.apiService});

  @override
  Future<List<BookEntity>> fetchFeaturedBooks({int pageNumber = 0}) async {
    log('🌍 Fetching featured books from API...');
    var data = await apiService.get(
      endPoint:
          "volumes?Filtering=free-ebooks&q=programming&startIndex=${pageNumber * 10}",
    );
    List<BookEntity> books = getBooksList(data);
    log('✅ Remote Featured Books Count: ${books.length}');
    saveLocalData(books, AppConstants.featuredBox);
    return books;
  }

  @override
  Future<List<BookEntity>> fetchNewsBooks() async {
    log('🌍 Fetching news books from API...');
    var newsData = await apiService.get(
      endPoint: "volumes?Filtering=free-ebooks&Sorting=newest&q=programming",
    );
    List<BookEntity> newsBooks = getBooksList(newsData);
    log('✅ Remote News Books Count: ${newsBooks.length}');
    saveLocalData(newsBooks, AppConstants.newsBox);
    return newsBooks;
  }

  List<BookEntity> getBooksList(Map<String, dynamic> data) {
    List<BookEntity> books = [];
    for (var item in data['items']) {
      books.add(BookModel.fromJson(item));
    }
    return books;
  }
}
