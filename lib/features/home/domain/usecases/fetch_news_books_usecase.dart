import 'package:bookly_app/core/errors/failure.dart';
import 'package:bookly_app/core/usecase/usecase.dart';
import 'package:bookly_app/features/home/domain/entities/book_entity.dart';
import 'package:bookly_app/features/home/domain/repositories/home_repo.dart';
import 'package:dartz/dartz.dart';

class FetchNewsBooksUsecase extends UseCase<List<BookEntity>, int> {
  final HomeRepo homeRepo;

  FetchNewsBooksUsecase({required this.homeRepo});

  @override
  Future<Either<Failure, List<BookEntity>>> call([int params = 0]) async {
    return await homeRepo.fetchNewsBooks(pageNumber: params);
  }
}
