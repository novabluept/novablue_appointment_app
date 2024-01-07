
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:novablue_appointment_app/src/constants/app_sizes.dart';
import 'appointments_history_card.dart';

class AppointmentsHistoryGrid extends StatelessWidget {

  const AppointmentsHistoryGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: Sizes.s24.w,vertical: Sizes.s24.h),
      shrinkWrap: true,
      itemCount: 5,
      separatorBuilder: (BuildContext context, int index) => gapH24,
      itemBuilder: (context, index) {
        //final language = languagesList[index];
        return AppointmentsHistoryCard();
      },
    );
  }
}
