part of 'news_books_cubit.dart';

sealed class NewsBooksState {}

final class NewsBooksInitial extends NewsBooksState {}
final class NewsBooksLoading extends NewsBooksState {}
final class NewsBooksFailure extends NewsBooksState {
  final String errMessage;
  NewsBooksFailure({  required this.errMessage});
}
final class NewsBooksSuccess extends NewsBooksState {
  final List<BookEntity> books;
  NewsBooksSuccess({required this.books});
}
