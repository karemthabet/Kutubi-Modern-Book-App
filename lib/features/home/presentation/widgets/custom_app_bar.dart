import 'dart:developer';

import 'package:bookly_app/core/utils/assets/app_assets.dart';
import 'package:bookly_app/core/utils/colors/app_colors.dart';
import 'package:bookly_app/core/utils/constants/app_constants.dart';
import 'package:bookly_app/core/utils/screens/app_screens.dart';
import 'package:bookly_app/features/home/domain/entities/book_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.symmetric(vertical: 25),
      child: Row(
        children: [
          Image.asset(AppAssets.logo, height: 45.h, width: 130.w),
          const Spacer(),
          ElevatedButton(
            onPressed: () async {
              log("🔍 Button Pressed");
              final box1 = Hive.box<BookEntity>(AppConstants.featuredBox);
              final box2 = Hive.box<BookEntity>(AppConstants.newsBox);
              log(
                "✅ Cache cleared! Featured Books Count: ${box1.values.length} ",
              );
              log("✅ Cache cleared! News Books Count: ${box2.values.length} ");
              await box1.clear();
              await box2.clear();
            },

            child: const Text("Clear Cache"),
          ),

          IconButton(
            onPressed: () {
              GoRouter.of(context).push(AppScreens.searchScreen);
            },
            icon: const Icon(
              FontAwesomeIcons.magnifyingGlass,
              color: AppColors.whiteColor,
            ),
          ),
        ],
      ),
    );
  }
}
