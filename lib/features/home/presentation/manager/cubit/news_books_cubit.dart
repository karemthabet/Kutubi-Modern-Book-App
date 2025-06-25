import 'package:bloc/bloc.dart';
import 'package:bookly_app/features/home/domain/entities/book_entity.dart';
import 'package:bookly_app/features/home/domain/usecases/fetch_news_books_usecase.dart';

part 'news_books_state.dart';

class NewsBooksCubit extends Cubit<NewsBooksState> {
  NewsBooksCubit({ required this.fetchNewsBooksUsecase}) : super(NewsBooksInitial());
  final FetchNewsBooksUsecase fetchNewsBooksUsecase ;
  Future<void> getNewsBooks() async {
    emit(NewsBooksLoading());
    var result = await fetchNewsBooksUsecase.call();
    result.fold(
      (failure) => emit(NewsBooksFailure(errMessage: failure.errMessage)),
      (books) => emit(NewsBooksSuccess(books: books)),
    );
  }
}
