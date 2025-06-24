import 'package:bookly_app/features/home/presentation/widgets/book_page_details_body.dart';
import 'package:flutter/material.dart';

class BookPageDetails extends StatelessWidget {
  const BookPageDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(child: Scaffold(body: BookPageDetailsBody()));
  }
}
