import 'package:bookly_app/core/utils/colors/app_colors.dart';
import 'package:bookly_app/features/search/presentation/manager/cubit/search_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BuildCustomTextFeild extends StatelessWidget {
  const BuildCustomTextFeild({super.key, required this.searchController});
  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.symmetric(vertical: 20),
      child: TextField(
        controller: searchController,
        style: const TextStyle(color: AppColors.whiteColor),
        cursorColor: AppColors.yellowColor,
        decoration: InputDecoration(
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: AppColors.whiteColor),
          ),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: AppColors.whiteColor),
          ),
          hintText: "Search",
          suffixIcon: InkWell(
            onTap: () {
              context.read<SearchCubit>().searchBooks(searchController.text);
            },
            child: const Icon(
              FontAwesomeIcons.magnifyingGlass,
              color: AppColors.whiteColor,
            ),
          ),
        ),
      ),
    );
  }
}
