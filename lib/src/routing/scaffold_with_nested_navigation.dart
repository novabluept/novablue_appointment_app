import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:novablue_appointment_app/src/constants/app_colors.dart';
import 'package:iconly/iconly.dart';

import '../common_widgets/my_text.dart';
import '../constants/app_sizes.dart';

class BottomNavTextStyles {
  static var main = TextStyle(
    fontFamily: FontFamilies.urbanist,
    fontWeight: FontWeights.bold,
    fontSize: Sizes.s10.sp,
  );
}

class ScaffoldWithNestedNavigation extends StatelessWidget {
  const ScaffoldWithNestedNavigation({
    Key? key,
    required this.navigationShell,
  }) : super(key: key ?? const ValueKey('ScaffoldWithNestedNavigation'));
  final StatefulNavigationShell navigationShell;

  void _goBranch(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: navigationShell,
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(horizontal: Sizes.s32.w),
          child: Theme(
            data: ThemeData(
              splashColor: OtherColors.transparent,
              highlightColor: OtherColors.transparent,
              colorScheme: const ColorScheme.light(
                primary: MainColors.primary,
              ),
            ),
            child: SizedBox(
              height: Sizes.s80.h,
              child: BottomNavigationBar(
                elevation: 0,
                iconSize: Sizes.s24.w,
                type: BottomNavigationBarType.fixed,
                selectedLabelStyle: BottomNavTextStyles.main,
                unselectedLabelStyle: BottomNavTextStyles.main,
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(icon: Icon(IconlyLight.home,color: GreyScaleColors.grey500),activeIcon: Icon(IconlyBold.home,color: MainColors.primary),label: 'Home'),
                  BottomNavigationBarItem(icon: Icon(IconlyLight.document,color: GreyScaleColors.grey500),activeIcon: Icon(IconlyBold.document,color: MainColors.primary),label: 'History'),
                  BottomNavigationBarItem(icon: Icon(IconlyLight.profile,color: GreyScaleColors.grey500),activeIcon: Icon(IconlyBold.profile,color: MainColors.primary),label: 'Profile'),
                ],
                currentIndex: navigationShell.currentIndex,
                onTap: (int index) => _goBranch(index),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

