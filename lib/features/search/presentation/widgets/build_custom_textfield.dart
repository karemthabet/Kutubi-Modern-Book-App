import 'package:bookly_app/core/utils/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BuildCustomTextFeild extends StatelessWidget {
  const BuildCustomTextFeild({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.symmetric(vertical: 20),
      child: const TextField(
        style: TextStyle(color: AppColors.whiteColor),
        cursorColor: AppColors.yellowColor,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: AppColors.whiteColor),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: AppColors.whiteColor),
          ),
          hintText: "Search",
          suffixIcon: Icon(
            FontAwesomeIcons.magnifyingGlass,
            color: AppColors.whiteColor,
          ),
        ),
      ),
    );
  }
}
