
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:novablue_appointment_app/src/constants/app_colors.dart';

import '../constants/app_sizes.dart';

class MyScaffold extends StatelessWidget {

  final PreferredSizeWidget? appBar;
  final Widget body;
  final EdgeInsets? edgeInsets;

  const MyScaffold({super.key,this.appBar, required this.body, this.edgeInsets});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      resizeToAvoidBottomInset: true,
      backgroundColor: OtherColors.white,
      body: SafeArea(
        child: Container(
          padding: edgeInsets ?? EdgeInsets.symmetric(horizontal: Sizes.s24.w),
          child: body,
        ),
      ),
    );
  }
}
