import 'package:bookly_app/features/home/domain/entities/book_entity.dart';
import 'package:bookly_app/features/home/domain/usecases/fetch_news_books_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'news_books_state.dart';

class NewsBooksCubit extends Cubit<NewsBooksState> {
  NewsBooksCubit({required this.fetchNewsBooksUsecase})
    : super(NewsBooksInitial());
  final FetchNewsBooksUsecase fetchNewsBooksUsecase;
  List<BookEntity> books = [];
  bool hasMoreData = true;

  Future<void> getNewsBooks({int pageNumber = 0}) async {
    if (pageNumber == 0) {
      emit(NewsBooksLoading());
    } else {
      emit(NewsBooksPaginationLoading(oldBooks: books));
    }

    final result = await fetchNewsBooksUsecase.call(pageNumber);

    result.fold(
      (failure) {
        if (pageNumber == 0) {
          emit(NewsBooksFailure(errMessage: failure.errMessage));
        } else {
          emit(
            NewsBooksPaginationFailure(
              errMessage: failure.errMessage,
              oldBooks: books,
            ),
          );
        }
      },
      (newBooks) {
        if (newBooks.length < 10) {
          hasMoreData = false;
        }
        books.addAll(newBooks);

        emit(NewsBooksSuccess(books: books, hasMoreData: hasMoreData));
      },
    );
  }
}
