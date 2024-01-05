
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:novablue_appointment_app/src/constants/app_sizes.dart';

class MyDecoratedTabBar extends StatelessWidget implements PreferredSizeWidget {

  final TabBar tabBar;
  final BoxDecoration decoration;

  MyDecoratedTabBar({required this.tabBar, required this.decoration});

  @override
  Size get preferredSize => tabBar.preferredSize;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          left: Sizes.s24.w,
          right: Sizes.s24.w,
          child: Container(decoration: decoration)
        ),
        tabBar,
      ],
    );
  }
}