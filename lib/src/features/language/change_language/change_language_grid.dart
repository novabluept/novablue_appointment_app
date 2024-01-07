
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:novablue_appointment_app/src/constants/app_sizes.dart';
import 'package:novablue_appointment_app/src/localization/app_supported_locale.dart';
import 'package:novablue_appointment_app/src/utils/shared_prefrences.dart';
import 'change_language_screen_controller.dart';
import 'change_language_card.dart';

class ChangeLanguageGrid extends ConsumerStatefulWidget {

  const ChangeLanguageGrid({super.key});

  @override
  _ChangeLanguageGridState createState() => _ChangeLanguageGridState();
}

class _ChangeLanguageGridState extends ConsumerState<ChangeLanguageGrid> {

  @override
  Widget build(BuildContext context) {
    var languagesList = SupportedLocale.values;
    final selectedValue = AppSharedPreference.getLocale();

    return ListView.separated(
      padding: EdgeInsets.symmetric(vertical: Sizes.s24.h),
      shrinkWrap: true,
      itemCount: languagesList.length,
      separatorBuilder: (BuildContext context, int index) => gapH24,
      itemBuilder: (context, index) {
        final language = languagesList[index];
        return ChangeLanguageCard(
          language: language,
          selectedValue: selectedValue,
          onChanged: (value) {
            ref.read(changeLanguageScreenControllerProvider.notifier).changeLanguage(
              ref: ref,
              locale: value,
              onSuccess: () => context.pop(),
            );
          },
        );
      },
    );
  }
}