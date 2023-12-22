
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:novablue_appointment_app/src/features/authentication/data/auth_repository.dart';
import 'package:novablue_appointment_app/src/features/authentication/presentation/change_role/change_role_screen_controller.dart';
import 'package:novablue_appointment_app/src/features/authentication/presentation/change_role/role_card.dart';
import 'package:novablue_appointment_app/src/routing/app_routing.dart';
import 'package:novablue_appointment_app/src/routing/refresh_service/refresh_service_provider.dart';
import 'package:novablue_appointment_app/src/utils/shared_prefrences.dart';

class RolesGrid extends ConsumerStatefulWidget {

  const RolesGrid({super.key});

  @override
  _ChangeRoleGridState createState() => _ChangeRoleGridState();
}

class _ChangeRoleGridState extends ConsumerState<RolesGrid> {

  @override
  Widget build(BuildContext context) {
    final language = AppSharedPreference.getLocale();

    final id = ref.read(authRepositoryProvider).currentUser?.id;
    final rolesListValue = ref.watch(getRolesProvider(id ?? ''));
    final currentRole = ref.read(currentUserRoleCompanyProvider);

    return rolesListValue.when(
      data: (roles) => roles.isEmpty
      ? Text('empty')
      : ListView.builder(
        shrinkWrap: true,
        itemCount: roles.length,
        itemBuilder: (context, index) {
          final role = roles[index];
          return RoleCard(
            role: role,
            language: language,
            onChanged: (value) async{
              await ref.read(changeRoleScreenControllerProvider.notifier).updateActiveUserRole(
                id: id ?? '',
                previousRole: currentRole!,
                nextRole: role,
                onSuccess: () => context.goNamed(AppRoute.home.name) /// TODO: Handle the screen based on role
              );
            }
          );
        },
      ),
      error: (e, st) => const SizedBox(),
      loading: () => const SizedBox()
    );
  }
}