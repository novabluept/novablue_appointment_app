
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:novablue_appointment_app/src/common_widgets/my_app_bar.dart';
import 'package:novablue_appointment_app/src/common_widgets/my_decorated_tab_bar.dart';
import 'package:novablue_appointment_app/src/common_widgets/my_scaffold.dart';
import 'package:novablue_appointment_app/src/common_widgets/my_text.dart';
import 'package:novablue_appointment_app/src/constants/app_colors.dart';
import 'package:novablue_appointment_app/src/constants/app_sizes.dart';
import 'package:novablue_appointment_app/src/features/authentication/presentation/profile/profile_screen_controller.dart';
import 'package:novablue_appointment_app/src/localization/app_localizations_context.dart';
import 'package:novablue_appointment_app/src/utils/dialogs.dart';
import 'package:novablue_appointment_app/src/utils/formatters.dart';
import 'appointments_history_grid.dart';

class AppointmentsHistoryScreen extends ConsumerStatefulWidget {
  const AppointmentsHistoryScreen({super.key});

  @override
  _AppointmentsHistoryState createState() => _AppointmentsHistoryState();
}

class _AppointmentsHistoryState extends ConsumerState<AppointmentsHistoryScreen> {

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<void>>(
      profileScreenControllerProvider,
          (_, state) => state.showDialogError(context: context),
    );
    final state = ref.watch(profileScreenControllerProvider);
    return DefaultTabController(
      length: 3,
      child: MyScaffold(
        state: state,
        edgeInsets: EdgeInsets.zero,
        appBar: MyAppBar(
          title: context.loc.history.capitalize(),
          leading: Padding(
            padding: EdgeInsets.only(right: Sizes.s4.w),
            child: Align(
              alignment: Alignment.centerRight,
              child: SvgPicture.asset(
                width: Sizes.s28.w,
                height: Sizes.s28.w,
                'images/logos/medica_icon.svg'
              )
            ),
          ),
          titleSpacing: Sizes.s16,
          bottom: MyDecoratedTabBar(
            tabBar: TabBar(
              padding: EdgeInsets.symmetric(horizontal: Sizes.s24.w),
              labelStyle: TextStyle(
                fontFamily: 'Urbanist',
                fontSize: Sizes.s18.sp,
                fontWeight: FontWeights.semiBold,
              ),
              labelPadding: EdgeInsets.zero,
              unselectedLabelColor: GreyScaleColors.grey500,
              indicator: UnderlineTabIndicator(
                borderSide: BorderSide(width: Sizes.s4.w,color: MainColors.primary),
                borderRadius: BorderRadius.all(Radius.circular(30))
              ),
              indicatorSize: TabBarIndicatorSize.tab,
              overlayColor: MaterialStateProperty.all(OtherColors.transparent),
              splashBorderRadius: BorderRadius.circular(Sizes.s100).r,
              tabs: [
                Tab(
                  text: context.loc.upcoming.capitalize(),
                  iconMargin : EdgeInsets.only(bottom: Sizes.s10.h)
                ),
                Tab(
                  text: context.loc.completed.capitalize(),
                  iconMargin : EdgeInsets.only(bottom: Sizes.s10.h)
                ),
                Tab(
                  text: context.loc.cancelled.capitalize(),
                  iconMargin : EdgeInsets.only(bottom: Sizes.s10.h)
                ),
              ],
            ),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: GreyScaleColors.grey200,
                  width: Sizes.s4.h,
                ),
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            AppointmentsHistoryGrid(),
            AppointmentsHistoryGrid(),
            AppointmentsHistoryGrid(),
          ],
        ),
      ),
    );
  }
}