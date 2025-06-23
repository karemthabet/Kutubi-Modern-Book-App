import 'package:bookly_app/features/home/presentation/widgets/best_Seller_list_view_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BestSellerListView extends StatelessWidget {
  const BestSellerListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => SizedBox(height: 10.h),
      physics: NeverScrollableScrollPhysics(),
     shrinkWrap: true,
      itemCount: 10,

      itemBuilder: (context, index) {
        return BestSellerListViewItem();
      },
    );
  }
}
