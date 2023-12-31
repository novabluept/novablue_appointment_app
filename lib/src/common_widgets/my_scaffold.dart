
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:novablue_appointment_app/src/constants/app_colors.dart';
import 'package:novablue_appointment_app/src/constants/app_sizes.dart';
import 'my_progress_indicator.dart';

class MyScaffold extends StatelessWidget {

  final Function(bool)? onPopInvoked;
  final AsyncValue<void>? state;
  final PreferredSizeWidget? appBar;
  final Color? backgroundColor;
  final Widget body;
  final EdgeInsets? edgeInsets;

  const MyScaffold({super.key,this.onPopInvoked,this.state,this.appBar,this.backgroundColor, required this.body, this.edgeInsets});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PopScope(
          onPopInvoked: onPopInvoked,
          child: Scaffold(
            appBar: appBar,
            resizeToAvoidBottomInset: true,
            backgroundColor: backgroundColor ?? OtherColors.white,
            body: SafeArea(
              child: Padding(
                padding: edgeInsets ?? EdgeInsets.symmetric(horizontal: Sizes.s24.w),
                child: body,
              )
            ),
          ),
        ),
        state != null ? state!.isLoading ? MyProgressIndicator() : const SizedBox() : const SizedBox()
      ],
    );
  }
}
