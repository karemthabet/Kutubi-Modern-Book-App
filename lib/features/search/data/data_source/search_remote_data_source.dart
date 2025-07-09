import 'dart:developer';

import 'package:bookly_app/core/utils/Api/api_services.dart';
import 'package:bookly_app/features/home/data/models/book/book.dart';
import 'package:bookly_app/features/home/domain/entities/book_entity.dart';

abstract class SearchRemoteDataSource {
  Future<List<BookEntity>> searchByName({required String query});
}

class SearchRemoteDataSourceImpl implements SearchRemoteDataSource {
  final ApiService apiService;

  SearchRemoteDataSourceImpl({required this.apiService});

  @override
  Future<List<BookEntity>> searchByName({required String query}) async {
    log('🌍 Searching books by name from API...');
    var data = await apiService.get(
      endPoint: "volumes?Filtering=free-ebooks&q=$query",
    );
    List<BookEntity> books = getBooksList(data);
    return books;
  }

  List<BookEntity> getBooksList(Map<String, dynamic> data) {
    List<BookEntity> books = [];

    if (data['items'] != null && data['items'] is List) {
      for (var item in data['items']) {
        books.add(BookModel.fromJson(item));
      }
    }

    return books;
  }
}
