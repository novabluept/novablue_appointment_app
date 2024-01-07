
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:novablue_appointment_app/src/constants/app_sizes.dart';
import 'package:novablue_appointment_app/src/features/authentication/data/auth_repository.dart';
import 'package:novablue_appointment_app/src/features/authentication/presentation/change_role/change_role_screen_controller.dart';
import 'package:novablue_appointment_app/src/features/authentication/presentation/change_role/change_role_card.dart';
import 'package:novablue_appointment_app/src/features/authentication/presentation/change_role/change_role_card_loader.dart';
import 'package:novablue_appointment_app/src/routing/app_routing.dart';
import 'package:novablue_appointment_app/src/routing/refresh_service/refresh_service_provider.dart';
import 'package:novablue_appointment_app/src/utils/shared_prefrences.dart';

class ChangeRolesGrid extends ConsumerStatefulWidget {

  const ChangeRolesGrid({super.key});

  @override
  _ChangeRolesGridState createState() => _ChangeRolesGridState();
}

class _ChangeRolesGridState extends ConsumerState<ChangeRolesGrid> {

  @override
  Widget build(BuildContext context) {
    final language = AppSharedPreference.getLocale();

    final id = ref.read(authRepositoryProvider).currentUser?.id;
    final rolesListValue = ref.watch(getRolesProvider(id ?? ''));
    final currentRole = ref.read(currentUserRoleCompanyProvider);

    return rolesListValue.when(
      data: (roles) => roles.isEmpty
      ? Text('empty')
      :
      ListView.separated(
        padding: EdgeInsets.symmetric(vertical: Sizes.s24.h),
        shrinkWrap: true,
        itemCount: roles.length,
        separatorBuilder: (BuildContext context, int index) => gapH24,
        itemBuilder: (context, index) {
          final role = roles[index];
          return ChangeRoleCard(
            role: role,
            language: language,
            onChanged: (value) async{
              await ref.read(changeRoleScreenControllerProvider.notifier).updateActiveUserRole(
                previousRole: currentRole!,
                nextRole: role,
                onSuccess: () => context.goNamed(AppRoute.home.name) /// TODO: Handle the screen based on role
              );
            }
          );
        },
      ),
      error: (e, st) => const SizedBox(),
      loading: () => ListView.separated(
        padding: EdgeInsets.symmetric(vertical: Sizes.s24.h),
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 8,
        separatorBuilder: (BuildContext context, int index) => gapH24,
        itemBuilder: (context, index) {
          return ChangeRoleCardLoader();
        },
      ),
    );
  }
}