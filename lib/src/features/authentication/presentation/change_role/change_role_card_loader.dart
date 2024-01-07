
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:novablue_appointment_app/src/common_widgets/my_shimmer.dart';
import 'package:novablue_appointment_app/src/constants/app_colors.dart';
import 'package:novablue_appointment_app/src/constants/app_sizes.dart';

class ChangeRoleCardLoader extends StatelessWidget {
  const ChangeRoleCardLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return MyShimmer(
      child: Container(
        height: Sizes.s80.h,
        decoration: BoxDecoration(
          color: OtherColors.white,
          borderRadius: BorderRadius.all(Radius.circular(Sizes.s30).r)
        ),
      ),
    );
  }
}
