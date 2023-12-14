
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:novablue_appointment_app/src/features/authentication/domain/user_role_company_supabase.dart';
import 'package:novablue_appointment_app/src/features/authentication/presentation/change_role_list/role_card.dart';
import 'package:novablue_appointment_app/src/utils/shared_prefrences.dart';

import 'change_role_list_screen_controller.dart';

class RolesGrid extends ConsumerStatefulWidget {

  final List<UserRoleCompanySupabase> items;
  final UserRoleCompanySupabase selectedValue;

  const RolesGrid({super.key, required this.items, required this.selectedValue});

  @override
  _ChangeRoleGridState createState() => _ChangeRoleGridState();
}

class _ChangeRoleGridState extends ConsumerState<RolesGrid> {

  @override
  Widget build(BuildContext context) {
    var language = AppSharedPreference.getLocale();
    return ListView.builder(
      shrinkWrap: true,
      itemCount: widget.items.length,
      itemBuilder: (context, index) {
        return RoleCard(
          item: widget.items[index],
          selectedValue: widget.selectedValue,
          language: language,
          onChanged: (value){
            ref.read(changeRoleScreenControllerProvider.notifier).changeTempRole(ref,widget.items[index]);
          }
        );
      },
    );
  }
}