part of 'featured_books_cubit.dart';

/// الحالات الممكنة لحالة تحميل الكتب
sealed class FeaturedBooksState  {}

class FeaturedBooksInitial extends FeaturedBooksState {}

/// حالة التحميل لأول مرة
class FeaturedBooksLoading extends FeaturedBooksState {}

/// حالة تحميل صفحة جديدة (pagination)
class FeaturedBooksPaginationLoading extends FeaturedBooksState {
  final List<BookEntity> oldBooks;

  FeaturedBooksPaginationLoading({required this.oldBooks});
}

/// حالة النجاح بتحميل الكتب (سواء أول مرة أو مع pagination)
class FeaturedBooksSuccess extends FeaturedBooksState {
  final List<BookEntity> books;
  final bool hasMoreData;

  FeaturedBooksSuccess({required this.books, required this.hasMoreData});
}

/// فشل تحميل أول مرة
class FeaturedBooksFailure extends FeaturedBooksState {
  final String errMessage;

  FeaturedBooksFailure({required this.errMessage});
}

/// فشل أثناء تحميل صفحة جديدة (pagination)
class FeaturedBooksPaginationFailure extends FeaturedBooksState {
  final List<BookEntity> oldBooks;
  final String errMessage;

  FeaturedBooksPaginationFailure({
    required this.oldBooks,
    required this.errMessage,
  });
}
