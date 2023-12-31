
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:novablue_appointment_app/src/common_widgets/my_text.dart';
import 'package:novablue_appointment_app/src/constants/app_sizes.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget  {

  final String? title;
  final Widget? leading;
  final double leadingWidth;
  final double titleSpacing;
  final List<Widget>? actions;
  final PreferredSizeWidget? bottom;

  const MyAppBar({super.key,this.title,this.leading,this.leadingWidth = Sizes.s56,this.titleSpacing = Sizes.s0, this.actions,this.bottom});

  @override
  Size get preferredSize => Size.fromHeight(bottom != null ? kToolbarHeight.h * 2.2 : kToolbarHeight.h);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: preferredSize,
      child: AppBar(
        //backgroundColor: Colors.red,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        elevation: Sizes.s0,
        scrolledUnderElevation: Sizes.s0,
        titleSpacing: titleSpacing.w,
        centerTitle: false,
        leadingWidth: leadingWidth.w,
        leading: leading,
        actions: actions,
        title: MyText(
          type: TextTypes.h4,
          text: title ?? '',
        ),
        bottom: bottom,
        toolbarHeight: kToolbarHeight.h,
      ),
    );
  }
}
