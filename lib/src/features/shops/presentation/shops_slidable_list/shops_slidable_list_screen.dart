
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:novablue_appointment_app/src/common_widgets/my_scaffold.dart';
import 'package:novablue_appointment_app/src/constants/app_sizes.dart';
import 'package:novablue_appointment_app/src/features/authentication/presentation/change_role/change_role_screen_controller.dart';
import 'package:novablue_appointment_app/src/features/shops/presentation/shops_slidable_list/shops_grid.dart';
import 'package:novablue_appointment_app/src/features/shops/presentation/shops_slidable_list/shops_slidable_list_screen_controller.dart';
import 'package:novablue_appointment_app/src/utils/dialogs.dart';

class ShopsSlidableListScreen extends ConsumerStatefulWidget {
  const ShopsSlidableListScreen({super.key});

  @override
  _ShopsSlidableListScreenState createState() => _ShopsSlidableListScreenState();
}

class _ShopsSlidableListScreenState extends ConsumerState<ShopsSlidableListScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<void>>(
      shopsSlidableListScreenControllerProvider,
        (_, state) => state.showDialogError(context: context),
    );
    final state = ref.watch(changeRoleScreenControllerProvider);
    return MyScaffold(
      state: state,
      edgeInsets: EdgeInsets.zero,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ShopsGrid(),
          gapH24
        ],
      )
    );
  }
}