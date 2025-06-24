class BookEntity {
  final String? bookId;
  final String? image;

  final String? title;
  final String? authorName;
  final num? rating;
  final num? price;

  BookEntity({
    this.title,
    this.authorName,
    this.rating,
    this.price,
    this.image,
    this.bookId,
  });
}
