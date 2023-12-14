
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:novablue_appointment_app/src/common_widgets/my_text.dart';
import 'package:novablue_appointment_app/src/constants/app_colors.dart';
import 'package:iconly/iconly.dart';
import 'package:novablue_appointment_app/src/constants/app_sizes.dart';
import 'package:novablue_appointment_app/src/features/authentication/data/auth_repository.dart';
import 'package:novablue_appointment_app/src/features/authentication/domain/user_role_company_supabase.dart';
import 'package:novablue_appointment_app/src/localization/app_localizations_context.dart';
import 'package:novablue_appointment_app/src/routing/scaffold_with_nested_navigation_provider.dart';
import 'package:novablue_appointment_app/src/utils/formatters.dart';
import 'app_routing.dart';

class BottomNavTextStyles {
  static var main = TextStyle(
    fontFamily: FontFamilies.urbanist,
    fontWeight: FontWeights.bold,
    fontSize: Sizes.s10.sp,
  );
}

class ScaffoldWithNestedNavigation extends ConsumerStatefulWidget {
  final navigationShell;

  const ScaffoldWithNestedNavigation({
    Key? key,
    required this.navigationShell,
  }) : super(key: key ?? const ValueKey('ScaffoldWithNestedNavigation'));

  @override
  _ScaffoldWithNestedNavigationState createState() => _ScaffoldWithNestedNavigationState();
}

class _ScaffoldWithNestedNavigationState extends ConsumerState<ScaffoldWithNestedNavigation> {

  void _goBranch(UserRoleCompanySupabase? currentUserRoleCompany,int index) {

    if(ref.read(isBottomLoadingProvider.notifier).state){
      return;
    }

    ref.read(currentIndexProvider.notifier).state = index;

    if(currentUserRoleCompany?.roleEn == UserRoles.worker.roleEn){
      switch(index){
        case 0:
          context.goNamed(AppRoute.home.name);
          break;
        case 1:
          context.goNamed(AppRoute.history.name);
          break;
        case 2:
          context.goNamed(AppRoute.profile.name);
          break;
      }
    }else if(currentUserRoleCompany?.roleEn == UserRoles.admin.roleEn){
      switch(index){
        case 0:
          context.goNamed(AppRoute.home.name);
          break;
        case 1:
          context.goNamed(AppRoute.history.name);
          break;
        case 2:
          context.goNamed(AppRoute.profile.name);
          break;
      }
    }else{
      switch(index){
        case 0:
          context.goNamed(AppRoute.home.name);
          break;
        case 1:
          context.goNamed(AppRoute.history.name);
          break;
        case 2:
          context.goNamed(AppRoute.profile.name);
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var currentUserRoleCompany = ref.watch(currentUserRoleCompanyProvider);
    var currentIndex = ref.watch(currentIndexProvider);

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: widget.navigationShell,
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
                backgroundColor: OtherColors.white,
                elevation: 0,
                iconSize: Sizes.s24.w,
                type: BottomNavigationBarType.fixed,
                selectedLabelStyle: BottomNavTextStyles.main,
                unselectedLabelStyle: BottomNavTextStyles.main,
                items: _bottomNavigationBarItems(context,currentUserRoleCompany),
                currentIndex: currentIndex,
                onTap: (int index) => _goBranch(currentUserRoleCompany,index),
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<BottomNavigationBarItem> _bottomNavigationBarItems(BuildContext context,UserRoleCompanySupabase? currentUserRoleCompany){
    if(currentUserRoleCompany?.roleEn == UserRoles.worker.roleEn){
      return [
        BottomNavigationBarItem(
          icon: Icon(IconlyLight.home,color: GreyScaleColors.grey500),
          activeIcon: Icon(IconlyBold.home,color: MainColors.primary),
          label: context.loc.home.capitalize()
        ),
        BottomNavigationBarItem(
          icon: Icon(IconlyLight.document,color: GreyScaleColors.grey500),
          activeIcon: Icon(IconlyBold.document,color: MainColors.primary),
          label: context.loc.history.capitalize()
        ),
        BottomNavigationBarItem(
          icon: Icon(IconlyLight.profile,color: GreyScaleColors.grey500),
          activeIcon: Icon(IconlyBold.profile,color: MainColors.primary),
          label: context.loc.profile.capitalize()
        ),
      ];
    }else if(currentUserRoleCompany?.roleEn == UserRoles.admin.roleEn){
      return [
        BottomNavigationBarItem(
          icon: Icon(IconlyLight.home,color: GreyScaleColors.grey500),
          activeIcon: Icon(IconlyBold.home,color: MainColors.primary),
          label: context.loc.home.capitalize()
        ),
        BottomNavigationBarItem(
          icon: Icon(IconlyLight.document,color: GreyScaleColors.grey500),
          activeIcon: Icon(IconlyBold.document,color: MainColors.primary),
          label: context.loc.history.capitalize()
        ),
        BottomNavigationBarItem(
          icon: Icon(IconlyLight.profile,color: GreyScaleColors.grey500),
          activeIcon: Icon(IconlyBold.profile,color: MainColors.primary),
          label: context.loc.profile.capitalize()
        ),
      ];
    }else{
      return [
        BottomNavigationBarItem(
          icon: Icon(IconlyLight.home,color: GreyScaleColors.grey500),
          activeIcon: Icon(IconlyBold.home,color: MainColors.primary),
          label: context.loc.home.capitalize()
        ),
        BottomNavigationBarItem(
          icon: Icon(IconlyLight.document,color: GreyScaleColors.grey500),
          activeIcon: Icon(IconlyBold.document,color: MainColors.primary),
          label: context.loc.history.capitalize()
        ),
        BottomNavigationBarItem(
          icon: Icon(IconlyLight.profile,color: GreyScaleColors.grey500),
          activeIcon: Icon(IconlyBold.profile,color: MainColors.primary),
          label: context.loc.profile.capitalize()
        ),
      ];
    }
  }
}





/*class ScaffoldWithNestedNavigation extends StatelessWidget {
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
                backgroundColor: OtherColors.white,
                elevation: 0,
                iconSize: Sizes.s24.w,
                type: BottomNavigationBarType.fixed,
                selectedLabelStyle: BottomNavTextStyles.main,
                unselectedLabelStyle: BottomNavTextStyles.main,
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                      icon: Icon(IconlyLight.home,color: GreyScaleColors.grey500),
                      activeIcon: Icon(IconlyBold.home,color: MainColors.primary),
                      label: context.loc.home.capitalize()
                  ),
                  BottomNavigationBarItem(
                      icon: Icon(IconlyLight.document,color: GreyScaleColors.grey500),
                      activeIcon: Icon(IconlyBold.document,color: MainColors.primary),
                      label: context.loc.history.capitalize()
                  ),
                  BottomNavigationBarItem(
                      icon: Icon(IconlyLight.profile,color: GreyScaleColors.grey500),
                      activeIcon: Icon(IconlyBold.profile,color: MainColors.primary),
                      label: context.loc.profile.capitalize()
                  ),
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
}*/

