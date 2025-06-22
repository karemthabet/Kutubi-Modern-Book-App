import 'package:bookly_app/core/utils/screens/app_screens.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final router = GoRouter(
    routes: [
      GoRoute(
        path: AppScreens.splashScreen,
        builder: (context, state) => const SplashScreen(),
      ),
    ],
  );
}
