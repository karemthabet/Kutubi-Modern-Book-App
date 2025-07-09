import 'package:bookly_app/core/injection.dart';
import 'package:bookly_app/features/search/domain/repo/search_repo.dart';
import 'package:bookly_app/features/search/domain/use_case/search_by_name_use_case.dart';
import 'package:bookly_app/features/search/presentation/manager/cubit/search_cubit.dart';
import 'package:bookly_app/features/search/presentation/widgets/search_page_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocProvider(
          create:
              (context) => SearchCubit(
                searchByNameUseCase: SearchByNameUseCase(
                  searchRepo: getit<SearchRepo>(),
                ),
              ),
          child: const SearchPageBody(),
        ),
      ),
    );
  }
}
// This page serves as the main entry point for the search feature,