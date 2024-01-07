
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';
import 'package:novablue_appointment_app/src/common_widgets/my_app_bar.dart';
import 'package:novablue_appointment_app/src/common_widgets/my_scaffold.dart';
import 'package:novablue_appointment_app/src/constants/app_colors.dart';
import 'package:novablue_appointment_app/src/constants/app_sizes.dart';
import 'book_appointment_workers_list_grid.dart';

class BookAppointmentWorkersListScreen extends ConsumerStatefulWidget {

  final String shopId;
  final String shopName;

  const BookAppointmentWorkersListScreen({super.key,required this.shopId, required String this.shopName});

  @override
  _BookAppointmentWorkersListScreenState createState() => _BookAppointmentWorkersListScreenState();
}

class _BookAppointmentWorkersListScreenState extends ConsumerState<BookAppointmentWorkersListScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      appBar: MyAppBar(
        title: 'Escolher Profissional',
        leading: IconButton(
          icon: Icon(IconlyLight.arrow_left, size: Sizes.s20.w, color: OtherColors.black),
          onPressed: (){
            context.pop();
          },
        )
      ),
      body: BookAppointmentWorkersListGrid(shopId: widget.shopId,shopName: widget.shopName)
    );
  }
}