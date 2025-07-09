import 'package:bookly_app/features/home/domain/entities/book_entity.dart';
import 'package:bookly_app/features/search/domain/use_case/search_by_name_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit({required  this.searchByNameUseCase}) : super(SearchInitial());
  final SearchByNameUseCase searchByNameUseCase;

  void searchBooks(String query) async {
    emit(SearchLoading());
    final result = await searchByNameUseCase.call(query);
    result.fold(
      (failure) => emit(SearchFailure(errorMessage: failure.errMessage)),
      (books) => emit(SearchSuccess(books: books)),
    );
  }
}
