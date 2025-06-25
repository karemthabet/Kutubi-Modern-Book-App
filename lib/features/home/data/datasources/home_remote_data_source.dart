import 'package:bookly_app/core/functions/save_local_data.dart';
import 'package:bookly_app/core/utils/Api/api_services.dart';
import 'package:bookly_app/core/utils/constants/app_constants.dart';
import 'package:bookly_app/features/home/data/models/book/book.dart';
import 'package:bookly_app/features/home/domain/entities/book_entity.dart';

abstract class HomeRemoteDataSource {
  Future<List<BookEntity>> fetchFeaturedBooks();
  Future<List<BookEntity>> fetchNewsBooks();
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final ApiService apiService;

  HomeRemoteDataSourceImpl(this.apiService);
  @override
  Future<List<BookEntity>> fetchFeaturedBooks() async {
    var data = await apiService.get(
      endPoint: "'volumes?Filtering=free-ebooks&q=programming",
    );
    List<BookEntity> books = getBooksList(data);
    saveLocalData(books, AppConstants.featuredBox);

    return books;
  }

  @override
  Future<List<BookEntity>> fetchNewsBooks() async {
    var newsData = await apiService.get(
      endPoint: "volumes?Filtering=free-ebooks&Sorting=newest&q=programming",
    );
    List<BookEntity> newsBooks = getBooksList(newsData);
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
