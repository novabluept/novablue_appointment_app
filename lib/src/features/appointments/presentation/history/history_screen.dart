
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:novablue_appointment_app/src/common_widgets/my_app_bar.dart';
import 'package:novablue_appointment_app/src/common_widgets/my_scaffold.dart';
import 'package:novablue_appointment_app/src/common_widgets/my_text.dart';
import 'package:novablue_appointment_app/src/constants/app_colors.dart';
import 'package:novablue_appointment_app/src/constants/app_sizes.dart';
import 'package:novablue_appointment_app/src/features/authentication/presentation/profile/profile_screen_controller.dart';
import 'package:novablue_appointment_app/src/localization/app_localizations_context.dart';
import 'package:novablue_appointment_app/src/utils/dialogs.dart';
import 'package:novablue_appointment_app/src/utils/formatters.dart';
import 'my_history_item.dart';

class HistoryScreen extends ConsumerStatefulWidget {
  const HistoryScreen({super.key});

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends ConsumerState<HistoryScreen> {

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
        appBar: MyAppBar(
          title: context.loc.history.capitalize(),
          leading: SvgPicture.asset(
            'images/main/logo_medica.svg',
          ),
          leadingWidth: Sizes.s28,
          titleSpacing: Sizes.s16,
          bottom: TabBar(
            labelStyle: TextStyle(
              fontFamily: 'Urbanist',
              fontSize: Sizes.s18.sp,
              fontWeight: FontWeights.semiBold,
            ),
            labelColor: MainColors.primary,
            unselectedLabelColor: GreyScaleColors.grey500,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorColor: MainColors.primary,
            indicatorWeight: 4.h,
            overlayColor: MaterialStateProperty.all(OtherColors.transparent),
            splashBorderRadius: BorderRadius.circular(100).r,
            tabs: const [
              Tab(text: 'Upcoming'),
              Tab(text: 'Completed'),
              Tab(text: 'Cancelled')
            ],
          )
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              gapH24,
              MyHistoryItem(),
            ],
          )
        ),
      ),
    );
  }
}