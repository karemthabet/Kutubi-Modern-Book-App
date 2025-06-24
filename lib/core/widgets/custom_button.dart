// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bookly_app/core/utils/colors/app_colors.dart';
import 'package:bookly_app/core/utils/styles/app_styles.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    required this.backgroundColor,
    required this.forgroundColor,
  });
  final String text;
  final Color backgroundColor;
  final Color forgroundColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: forgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(10),
          ),

          backgroundColor: backgroundColor,
        ),

        onPressed: () {},
        child: Text(
          text,
          style:
              backgroundColor == AppColors.whiteColor
                  ? AppStyles.textStyle18.copyWith(
                    color: AppColors.primaryColor,
                  )
                  : AppStyles.textStyle18.copyWith(fontSize: 14),
        ),
      ),
    );
  }
}
