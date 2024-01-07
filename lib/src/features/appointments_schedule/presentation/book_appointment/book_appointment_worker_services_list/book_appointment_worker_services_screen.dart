
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';
import 'package:novablue_appointment_app/src/common_widgets/my_app_bar.dart';
import 'package:novablue_appointment_app/src/common_widgets/my_scaffold.dart';
import 'package:novablue_appointment_app/src/constants/app_colors.dart';
import 'package:novablue_appointment_app/src/constants/app_sizes.dart';

class BookAppointmentWorkerServicesScreen extends ConsumerStatefulWidget {

  final String workerId;

  const BookAppointmentWorkerServicesScreen({super.key,required this.workerId});

  @override
  _BookAppointmentWorkerServicesScreenState createState() => _BookAppointmentWorkerServicesScreenState();
}

class _BookAppointmentWorkerServicesScreenState extends ConsumerState<BookAppointmentWorkerServicesScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      appBar: MyAppBar(
        title: 'Escolher Serviço',
        leading: IconButton(
          icon: Icon(IconlyLight.arrow_left, size: Sizes.s20.w, color: OtherColors.black),
          onPressed: (){
            context.pop();
          },
        )
      ),
      body: Container()
    );
  }
}