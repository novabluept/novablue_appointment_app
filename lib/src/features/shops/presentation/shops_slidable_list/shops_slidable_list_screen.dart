
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:novablue_appointment_app/src/common_widgets/my_scaffold.dart';
import 'package:novablue_appointment_app/src/constants/app_sizes.dart';
import 'package:novablue_appointment_app/src/features/shops/presentation/shops_slidable_list/shops_slidable_list_grid.dart';

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
    return MyScaffold(
      edgeInsets: EdgeInsets.zero,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ShopsSlidableListGrid(),
          gapH24
        ],
      )
    );
  }
}