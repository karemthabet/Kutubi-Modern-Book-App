import 'package:bookly_app/features/home/presentation/widgets/book_page_body.dart';
import 'package:flutter/material.dart';

class BookPage extends StatelessWidget {
  const BookPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body:  BookPageBody(),
    );
  }
}