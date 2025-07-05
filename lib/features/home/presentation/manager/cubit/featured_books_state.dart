part of 'featured_books_cubit.dart';

// ✅ الحالات كلها لـ FeaturedBooksCubit
sealed class FeaturedBooksState {}

final class FeaturedBooksInitial extends FeaturedBooksState {}

final class FeaturedBooksLoading extends FeaturedBooksState {}

final class FeaturedBooksPaginationLoading extends FeaturedBooksState {
  final List<BookEntity> oldBooks;

  FeaturedBooksPaginationLoading({required this.oldBooks});
}

final class FeaturedBooksSuccess extends FeaturedBooksState {
  final List<BookEntity> books;
  final bool hasMoreData;

  FeaturedBooksSuccess({required this.books, required this.hasMoreData});
}

final class FeaturedBooksFailure extends FeaturedBooksState {
  final String errMessage;

  FeaturedBooksFailure({required this.errMessage});
}

// ✅ الحالة الجديدة: لو حصل فشل أثناء pagination
final class FeaturedBooksPaginationFailure extends FeaturedBooksState {
  final List<BookEntity> oldBooks;
  final String errMessage;

  FeaturedBooksPaginationFailure({
    required this.oldBooks,
    required this.errMessage,
  });
}
