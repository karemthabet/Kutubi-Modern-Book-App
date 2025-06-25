import 'package:bookly_app/core/utils/screens/app_screens.dart';
import 'package:bookly_app/features/home/presentation/pages/book_page.dart';
import 'package:bookly_app/features/home/presentation/pages/book_page_details.dart';
import 'package:bookly_app/features/search/presentation/pages/search_page.dart';
import 'package:bookly_app/features/splash/presentation/pages/splash_page.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final router = GoRouter(
    routes: [
      GoRoute(
        path: AppScreens.splashScreen,
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: AppScreens.searchScreen,
        builder: (context, state) => const SearchPage(),
      ),
      GoRoute(
        path: AppScreens.bookScreen,
        builder: (context, state) => const BookPage(),
      ),
      GoRoute(
        path: AppScreens.bookScreenDetails,
        builder: (context, state) => const BookPageDetails(),
      ),
    ],
  );
}
