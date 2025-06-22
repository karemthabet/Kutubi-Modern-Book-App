import 'package:bookly_app/core/utils/screens/app_screens.dart';
import 'package:bookly_app/features/home/presentation/pages/home_page.dart';
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
        path: AppScreens.homeScreen,
        builder: (context, state) => const HomePage(),
      ),
    ],
  );
}
