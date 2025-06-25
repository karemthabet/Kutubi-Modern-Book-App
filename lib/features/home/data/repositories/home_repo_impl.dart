import 'dart:developer';

import 'package:bookly_app/core/errors/failure.dart';
import 'package:bookly_app/features/home/data/datasources/home_local_data_source.dart';
import 'package:bookly_app/features/home/data/datasources/home_remote_data_source.dart';
import 'package:bookly_app/features/home/domain/entities/book_entity.dart';
import 'package:bookly_app/features/home/domain/repositories/home_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class HomeRepoImpl extends HomeRepo {
  final HomeLocalDataSource homeLocalDataSource;
  final HomeRemoteDataSource homeRemoteDataSource;

  HomeRepoImpl({
    required this.homeLocalDataSource,
    required this.homeRemoteDataSource,
  });

  @override
  Future<Either<Failure, List<BookEntity>>> fetchFeaturedBooks() {
    return _handleRequest(
      homeLocalDataSource.fetchFeaturedBooks,
      homeRemoteDataSource.fetchFeaturedBooks,
    );
  }

  @override
  Future<Either<Failure, List<BookEntity>>> fetchNewsBooks() {
    return _handleRequest(
      homeLocalDataSource.fetchNewsBooks,
      homeRemoteDataSource.fetchNewsBooks,
    );
  }

  /// General method for handling local-then-remote logic with error catching
  Future<Either<Failure, List<BookEntity>>> _handleRequest(
    List<BookEntity> Function() getLocal,
    Future<List<BookEntity>> Function() getRemote,
  ) async {
    try {
      // جرب تجيب الداتا من الكاش الأول
      List<BookEntity> localBooks = [];
      try {
        localBooks = getLocal();
      } catch (e) {
        log('⚠️ Local cache error (ignored): $e');
      }

      if (localBooks.isNotEmpty) {
        log("📦 Fetched from local cache");
        return right(localBooks);
      }

      // لو الكاش فاضي، هات من السيرفر
      final remoteBooks = await getRemote();
      log("🌐 Fetched from remote");
      return right(remoteBooks);
    } catch (e, stack) {
      log('❌ Error in HomeRepoImpl: $e', stackTrace: stack);

      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      } else {
        return left(ServerFailure(errMessage: e.toString()));
      }
    }
  }
}
