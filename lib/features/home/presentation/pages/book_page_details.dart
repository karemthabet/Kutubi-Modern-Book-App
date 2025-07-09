import 'package:bookly_app/features/home/domain/entities/book_entity.dart';
import 'package:bookly_app/features/home/presentation/widgets/book_page_details_body.dart';
import 'package:flutter/material.dart';

class BookPageDetails extends StatelessWidget {
  const BookPageDetails({super.key, required this.book});
  final BookEntity book;

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(body: BookPageDetailsBody(book: book)));
  }
}
