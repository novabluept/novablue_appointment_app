
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:novablue_appointment_app/src/common_widgets/my_text.dart';
import 'package:novablue_appointment_app/src/constants/app_colors.dart';
import '../constants/app_sizes.dart';


class MyAppBar extends StatelessWidget implements PreferredSizeWidget  {

  final String? title;
  final Widget? leading;
  final List<Widget>? actions;

  const MyAppBar({super.key,this.title, this.actions, this.leading});

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(kToolbarHeight.sp),
      child: Container(
        width: double.infinity,
        color: OtherColors.white,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Sizes.s20.w),
          child: AppBar(
            elevation: 0,
            scrolledUnderElevation: 0,
            titleSpacing: -Sizes.s24.w,
            centerTitle: false,
            leading: leading,
            actions: actions,
            title: MyText(
              type: TextTypes.h4,
              text: title ?? '',
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight.h);
}
