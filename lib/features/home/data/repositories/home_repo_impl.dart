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
  Future<Either<Failure, List<BookEntity>>> fetchFeaturedBooks({
    int pageNumber = 0,
  }) async {
    try {
      final localBooks = homeLocalDataSource.fetchFeaturedBooks(
        pageNumber: pageNumber,
      );
      if (localBooks.isNotEmpty) {
        log('✅ Data fetched from LOCAL (featuredBooks)');
        return right(localBooks);
      }

      final remoteBooks = await homeRemoteDataSource.fetchFeaturedBooks(
        pageNumber: pageNumber,
      );
      log('🌐 Data fetched from REMOTE (featuredBooks)');
      return right(remoteBooks);
    } 
    catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      } else {
        return left(ServerFailure(errMessage: e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, List<BookEntity>>> fetchNewsBooks({
    int pageNumber = 0,
  }) async {
    try {
      final localBooks = homeLocalDataSource.fetchNewsBooks(
        pageNumber: pageNumber,
      );
      if (localBooks.isNotEmpty) {
        log('✅ Data fetched from LOCAL (newsBooks)');
        return right(localBooks);
      }

      final remoteBooks = await homeRemoteDataSource.fetchNewsBooks(
        pageNumber: pageNumber,
      );
      log('🌐 Data fetched from REMOTE (newsBooks)');
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
