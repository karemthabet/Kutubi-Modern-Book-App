import 'dart:developer';

import 'package:bookly_app/core/errors/failure.dart';
import 'package:bookly_app/features/home/domain/entities/book_entity.dart';
import 'package:bookly_app/features/search/data/data_source/search_remote_data_source.dart';
import 'package:bookly_app/features/search/domain/repo/search_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class SearchRepoImpl implements SearchRepo {
  final SearchRemoteDataSource remoteDataSource;

  SearchRepoImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<BookEntity>>> searchByName({
    required String query,
  }) async {
    try {
      final remoteBooks = await remoteDataSource.searchByName(query: query);
      log('🌐 Data fetched from REMOTE (featuredBooks)');
      return right(remoteBooks);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      } else {
        return left(ServerFailure(errMessage: e.toString()));
      }
    }
  }
}
