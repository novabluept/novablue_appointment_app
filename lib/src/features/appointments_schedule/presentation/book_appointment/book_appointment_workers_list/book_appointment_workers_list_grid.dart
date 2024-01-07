
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:novablue_appointment_app/src/constants/app_sizes.dart';
import 'package:novablue_appointment_app/src/features/appointments_schedule/data/appointments_schedule_repository.dart';
import 'book_appointment_workers_list_card.dart';

class BookAppointmentWorkersListGrid extends ConsumerStatefulWidget {

  final String shopId;
  final String shopName;

  const BookAppointmentWorkersListGrid({super.key, required this.shopId, required this.shopName});

  @override
  _BookAppointmentWorkersListGridState createState() => _BookAppointmentWorkersListGridState();
}

class _BookAppointmentWorkersListGridState extends ConsumerState<BookAppointmentWorkersListGrid> {

  @override
  Widget build(BuildContext context) {

    final workersList = ref.watch(getShopWorkersProvider(widget.shopId));

    return workersList.when(
      data: (workers) => workers.isEmpty
      ? Text('empty') :
      ListView.separated(
        padding: EdgeInsets.symmetric(vertical: Sizes.s24.h),
        shrinkWrap: true,
        itemCount: workers.length,
        separatorBuilder: (BuildContext context, int index) => gapH24,
        itemBuilder: (context,index) {
          final worker = workers[index];
          return BookAppointmentWorkersListCard(shopId: widget.shopId,shopName: widget.shopName, worker: worker);
        },
      ),
      error: (e, st) => const SizedBox(),
      loading: () => const SizedBox(),
    );
  }
}
