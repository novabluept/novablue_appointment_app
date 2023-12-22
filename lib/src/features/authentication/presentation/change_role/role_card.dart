
import 'package:flutter/material.dart';
import 'package:novablue_appointment_app/src/common_widgets/my_text.dart';
import 'package:novablue_appointment_app/src/constants/app_colors.dart';
import 'package:novablue_appointment_app/src/features/authentication/domain/user_role_company_supabase.dart';
import 'package:novablue_appointment_app/src/localization/app_supported_locale.dart';
import 'package:novablue_appointment_app/src/utils/formatters.dart';


class RoleCard extends StatelessWidget {

  final UserRoleCompanySupabase role;
  final Locale language;
  final Function(Object?)? onChanged;

  const RoleCard({super.key,required this.role,required this.language,required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: MyText(
        type: TextTypes.bodyXLarge,
        fontWeight: FontWeights.semiBold,
        text: language == Locale(SupportedLocale.pt.countryCode) ? role.rolePt.capitalize() : role.roleEn.capitalize(),
      ),
      trailing: Radio(
        value: role,
        groupValue: role.active ? role : null,
        activeColor: MainColors.primary,
        fillColor: MaterialStateProperty.all(MainColors.primary),
        onChanged: onChanged,
      ),
    );
  }
}