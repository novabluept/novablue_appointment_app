
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:novablue_appointment_app/src/constants/app_colors.dart';
import '../constants/app_sizes.dart';
import 'my_progress_indicator.dart';

class MyScaffold extends StatelessWidget {

  final Future<bool> Function()? onWillPop;
  final AsyncValue<void> state;
  final PreferredSizeWidget? appBar;
  final Widget body;
  final EdgeInsets? edgeInsets;

  const MyScaffold({super.key,this.onWillPop,required this.state,this.appBar, required this.body, this.edgeInsets});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        appBar: appBar,
        resizeToAvoidBottomInset: true,
        backgroundColor: OtherColors.white,
        body: SafeArea(
          child: Stack(
            children: [
              Container(
                padding: edgeInsets ?? EdgeInsets.symmetric(horizontal: Sizes.s24.w),
                child: body,
              ),
              state.isLoading ? MyProgressIndicator() : Container()
            ],
          )
        ),
      ),
    );
  }
}
