
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:novablue_appointment_app/src/common_widgets/my_text.dart';
import 'package:novablue_appointment_app/src/constants/app_colors.dart';
import 'package:novablue_appointment_app/src/constants/app_sizes.dart';
import 'package:novablue_appointment_app/src/features/authentication/domain/user_role_company_supabase.dart';
import 'package:novablue_appointment_app/src/localization/app_supported_locale.dart';

class ChangeRoleCard extends StatelessWidget {

  final UserRoleCompanyShopSupabase role;
  final Locale language;
  final Function(Object?)? onChanged;

  const ChangeRoleCard({super.key,required this.role,required this.language,required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Sizes.s80.h,
      decoration: BoxDecoration(
        color: GreyScaleColors.grey50,
        borderRadius: BorderRadius.all(Radius.circular(Sizes.s30).r)
      ),
      child: Center(
        child: ListTile(
          title: MyText(
            type: TextTypes.bodyMedium,
            fontWeight: FontWeights.semiBold,
            text: language == Locale(SupportedLocale.pt.countryCode) ? role.rolePt : role.roleEn,
          ),
          trailing: Radio(
            value: role,
            groupValue: role.active ? role : null,
            activeColor: MainColors.primary,
            fillColor: MaterialStateProperty.all(MainColors.primary),
            onChanged: onChanged,
          ),
        ),
      ),
    );
  }
}