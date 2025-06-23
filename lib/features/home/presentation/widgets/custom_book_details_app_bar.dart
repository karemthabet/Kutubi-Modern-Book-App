import 'package:bookly_app/core/utils/colors/app_colors.dart';
import 'package:flutter/material.dart';

class CustomBookDetailsAppBar extends StatelessWidget {
  const CustomBookDetailsAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () {},
        icon: Icon(Icons.close, color: AppColors.whiteColor),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.add_shopping_cart_outlined,
            color: AppColors.whiteColor,
          ),
        ),
      ],
    );
  }
}
