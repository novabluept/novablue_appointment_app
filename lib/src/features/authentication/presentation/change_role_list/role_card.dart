
import 'package:flutter/material.dart';
import 'package:novablue_appointment_app/src/common_widgets/my_text.dart';
import 'package:novablue_appointment_app/src/constants/app_colors.dart';
import 'package:novablue_appointment_app/src/features/authentication/domain/user_role_company_supabase.dart';
import 'package:novablue_appointment_app/src/localization/app_supported_locale.dart';
import 'package:novablue_appointment_app/src/utils/formatters.dart';

class RoleCard extends StatefulWidget {

  final UserRoleCompanySupabase item;
  final UserRoleCompanySupabase? selectedValue;
  final Locale language;
  final Function(Object?)? onChanged;

  const RoleCard({super.key,required this.item,required this.selectedValue,required this.language,required this.onChanged,});

  @override
  State<RoleCard> createState() => _RoleCardState();
}

class _RoleCardState extends State<RoleCard> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: MyText(
        type: TextTypes.bodyXLarge,
        fontWeight: FontWeights.semiBold,
        text: widget.language == Locale(SupportedLocale.pt.countryCode) ? widget.item.rolePt.capitalize() : widget.item.roleEn.capitalize(),
      ),
      trailing: Radio(
        value: widget.item,
        groupValue: widget.selectedValue,
        activeColor: MainColors.primary,
        fillColor: MaterialStateProperty.all(MainColors.primary),
        onChanged: widget.onChanged,
      ),
    );
  }
}
