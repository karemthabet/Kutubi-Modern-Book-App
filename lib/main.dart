import 'package:bookly_app/core/functions/injection.dart';
import 'package:bookly_app/core/utils/constants/app_constants.dart';
import 'package:bookly_app/core/utils/router/app_router.dart';
import 'package:bookly_app/core/utils/theme/app_theme.dart';
import 'package:bookly_app/features/home/data/repositories/home_repo_impl.dart';
import 'package:bookly_app/features/home/domain/entities/book_entity.dart';
import 'package:bookly_app/features/home/domain/usecases/fetch_featured_books_usecase.dart';
import 'package:bookly_app/features/home/domain/usecases/fetch_news_books_usecase.dart';
import 'package:bookly_app/features/home/presentation/manager/cubit/featured_books_cubit.dart';
import 'package:bookly_app/features/home/presentation/manager/cubit/news_books_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(BookEntityAdapter());
  setUpServiceLocator();
  await Hive.openBox<BookEntity>(AppConstants.featuredBox);
  await Hive.openBox<BookEntity>(AppConstants.newsBox);
  runApp(const BooklyApp());
}

class BooklyApp extends StatelessWidget {
  const BooklyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder:
          (context, child) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create:
                    (context) => FeaturedBooksCubit(
                      fetchFeaturedBooksUsecase: FetchFeaturedBooksUsecase(
                        homeRepo: getit.get<HomeRepoImpl>(),
                      ),
                    )..getFeaturedBooks(),
              ),
              BlocProvider(
                create:
                    (context) => NewsBooksCubit(
                      fetchNewsBooksUsecase: FetchNewsBooksUsecase(
                        homeRepo: getit.get<HomeRepoImpl>(),
                      ),
                    )..getNewsBooks(),
              ),
            ],
            child: MaterialApp.router(
              theme: AppTheme.darkTheme,
              debugShowCheckedModeBanner: false,
              routerConfig: AppRouter.router,
            ),
          ),
    );
  }
}
