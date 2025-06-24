import 'package:bookly_app/core/errors/failure.dart';
import 'package:bookly_app/core/usecase/usecase.dart';
import 'package:bookly_app/features/home/domain/entities/book_entity.dart';
import 'package:bookly_app/features/home/domain/repositories/home_repo.dart';
import 'package:dartz/dartz.dart';

class FetchFeaturedBooksUsecase extends UseCase<List<BookEntity>, NoParams> {
  final HomeRepo homeRepo;

  FetchFeaturedBooksUsecase({required this.homeRepo});

  @override
  Future<Either<Failure, List<BookEntity>>> call([NoParams? params]) {
    return homeRepo.fetchFeaturedBooks();
  }
}
