
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:novablue_appointment_app/src/features/authentication/domain/user_role_company_supabase.dart';
import 'package:novablue_appointment_app/src/features/authentication/presentation/change_role_list/roles_grid.dart';
import 'change_role_list_provider.dart';

class ChangeRoleListScreen extends ConsumerStatefulWidget {
  final List<UserRoleCompanySupabase> items;

  const ChangeRoleListScreen({super.key,required this.items});

  @override
  _ChangeRoleListScreenState createState() => _ChangeRoleListScreenState();
}

class _ChangeRoleListScreenState extends ConsumerState<ChangeRoleListScreen> {

  @override
  Widget build(BuildContext context) {
    final selectedValue = ref.watch(tempUserRoleCompanyProvider);
    return Column(
      children: [
        RolesGrid(items: widget.items,selectedValue: selectedValue!),
      ],
    );
  }
}


