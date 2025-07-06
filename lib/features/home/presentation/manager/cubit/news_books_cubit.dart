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
  int currentPage = 0;
  bool isLoading = false;

  Future<void> getNewsBooks() async {
    if (isLoading || !hasMoreData) return;
    isLoading = true;

    if (currentPage == 0) {
      emit(NewsBooksLoading());
    } else {
      emit(NewsBooksPaginationLoading(oldBooks: books));
    }

    final result = await fetchNewsBooksUsecase.call(currentPage);

    result.fold(
      (failure) {
        isLoading = false;
        if (currentPage == 0) {
          emit(NewsBooksFailure(errMessage: failure.errMessage));
        } else {
          emit(NewsBooksPaginationFailure(
            oldBooks: books,
            errMessage: failure.errMessage,
          ));
        }
      },
      (newBooks) {
        books.addAll(newBooks);

        if (newBooks.length < 10) hasMoreData = false;
        currentPage++;
        isLoading = false;

        emit(NewsBooksSuccess(books: books, hasMoreData: hasMoreData));
      },
    );
  }
}
