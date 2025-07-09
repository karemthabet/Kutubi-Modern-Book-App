import 'package:bookly_app/core/errors/failure.dart';
import 'package:bookly_app/core/usecase/usecase.dart';
import 'package:bookly_app/features/home/domain/entities/book_entity.dart';
import 'package:bookly_app/features/search/domain/repo/search_repo.dart';
import 'package:dartz/dartz.dart' show Either;

class SearchByNameUseCase extends UseCase<List<BookEntity>, String> {
  final SearchRepo searchRepo;

  SearchByNameUseCase({required this.searchRepo});

  @override
  Future<Either<Failure, List<BookEntity>>> call([String query = ""]) async {
    return await searchRepo.searchByName(query: query);
  }
}
