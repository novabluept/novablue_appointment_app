
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconly/iconly.dart';
import 'package:novablue_appointment_app/src/common_widgets/my_text.dart';
import 'package:novablue_appointment_app/src/constants/app_colors.dart';
import 'package:novablue_appointment_app/src/constants/app_sizes.dart';

class BrowseShopsCard extends StatelessWidget {
  const BrowseShopsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Sizes.s331.w,
      height: Sizes.s350.h,
      decoration: BoxDecoration(
        color: GreyScaleColors.grey50,
        borderRadius: BorderRadius.all(Radius.circular(Sizes.s10.r))
      ),
      margin: EdgeInsets.symmetric(horizontal: Sizes.s6.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            IconlyLight.search,
            size: Sizes.s48.w,
            color: MainColors.primary
          ),
          gapH8,
          MyText(
            type: TextTypes.bodyLarge,
            textAlign: TextAlign.center,
            text: 'Want to see more?\n Browse shops',
            color: MainColors.primary,
          ),
        ],
      ),
    );
  }
}
