import 'package:bookly_app/features/home/domain/entities/book_entity.dart';
import 'package:bookly_app/features/home/domain/usecases/fetch_featured_books_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'featured_books_state.dart';

class FeaturedBooksCubit extends Cubit<FeaturedBooksState> {
  FeaturedBooksCubit({required this.fetchFeaturedBooksUsecase})
      : super(FeaturedBooksInitial());

  final FetchFeaturedBooksUsecase fetchFeaturedBooksUsecase;

  List<BookEntity> books = []; // ✅ نخزن الكتب المحمّلة
  bool hasMoreData = true;     // ✅ نعرف لو فيه صفحات تانية

  Future<void> getFeaturedBooks({int pageNumber = 0}) async {
    if (pageNumber == 0) {
      emit(FeaturedBooksLoading()); // ✅ أول تحميل
    } else {
      emit(FeaturedBooksPaginationLoading(oldBooks: books)); // ✅ تحميل صفحة جديدة
    }

    final result = await fetchFeaturedBooksUsecase.call(pageNumber);

    result.fold(
      (failure) {
        // ✅ لو فشلنا في تحميل الصفحة
        if (pageNumber == 0) {
          emit(FeaturedBooksFailure(errMessage: failure.errMessage));
        } else {
          emit(FeaturedBooksPaginationFailure(
            oldBooks: books,
            errMessage: failure.errMessage,
          ));
        }
      },
      (newBooks) {
        if (newBooks.length < 10) hasMoreData = false; // ✅ آخر صفحة

        books.addAll(newBooks); // ✅ نضيف الجديد على القديم
        emit(FeaturedBooksSuccess(books: books, hasMoreData: hasMoreData));
      },
    );
  }

}
