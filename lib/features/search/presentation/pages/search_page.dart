import 'package:bookly_app/features/search/presentation/widgets/search_page_body.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(child: Scaffold(body: SearchPageBody()));
  }
}
