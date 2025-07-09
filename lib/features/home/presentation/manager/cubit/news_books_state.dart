part of 'news_books_cubit.dart';

sealed class NewsBooksState {}

final class NewsBooksInitial extends NewsBooksState {}

final class NewsBooksLoading extends NewsBooksState {}

final class NewsBooksSuccess extends NewsBooksState {
  final List<BookEntity> books;
  final bool hasMoreData;
  NewsBooksSuccess({required this.books, required this.hasMoreData});
}

final class NewsBooksFailure extends NewsBooksState {
  final String errMessage;
  NewsBooksFailure({required this.errMessage});
}

final class NewsBooksPaginationLoading extends NewsBooksState {
  final List<BookEntity> oldBooks;
  NewsBooksPaginationLoading({required this.oldBooks});
}

final class NewsBooksPaginationFailure extends NewsBooksState {
  final String errMessage;
  final List<BookEntity> oldBooks;
  NewsBooksPaginationFailure({
    required this.oldBooks,
    required this.errMessage,
  });
}
