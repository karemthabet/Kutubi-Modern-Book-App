import 'package:bookly_app/core/utils/assets/app_assets.dart';
import 'package:bookly_app/core/utils/screens/app_screens.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashPageBody extends StatefulWidget {
  const SplashPageBody({super.key});

  @override
  State<SplashPageBody> createState() => _SplashPageBodyState();
}

class _SplashPageBodyState extends State<SplashPageBody>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    initAnimation();
    navigateToHome();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return SlideTransition(
            position: _slideAnimation,
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: child,
            ),
          );
        },
        child: Image.asset(AppAssets.logo), 
      ),
    );
  }

  void navigateToHome() {
    Future.delayed(const Duration(seconds: 2), () {
      GoRouter.of(context).pushReplacement(AppScreens.homeScreen);
    });
  }

  void initAnimation() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    _controller.forward();
  }
}
