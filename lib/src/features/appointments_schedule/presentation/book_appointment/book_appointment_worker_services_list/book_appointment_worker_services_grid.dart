

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:novablue_appointment_app/src/constants/app_sizes.dart';

class BookAppointmentWorkerServicesGrid extends StatefulWidget {
  const BookAppointmentWorkerServicesGrid({super.key});

  @override
  State<BookAppointmentWorkerServicesGrid> createState() => _BookAppointmentWorkerServicesGridState();
}

class _BookAppointmentWorkerServicesGridState extends State<BookAppointmentWorkerServicesGrid> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(vertical: Sizes.s24.h),
      shrinkWrap: true,
      itemCount: 10,
      separatorBuilder: (BuildContext context, int index) => gapH24,
      itemBuilder: (context,index) {
        //final shop = index != shops.length ? shops[index] : null;
        return Container(color: Colors.red,height: 40);
      },
    );
  }
}
