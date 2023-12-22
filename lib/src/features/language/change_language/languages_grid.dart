
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:novablue_appointment_app/src/localization/app_supported_locale.dart';
import 'package:novablue_appointment_app/src/utils/shared_prefrences.dart';
import 'change_language_screen_controller.dart';
import 'language_card.dart';

class LanguagesGrid extends ConsumerStatefulWidget {

  const LanguagesGrid({super.key});

  @override
  _LanguagesGridState createState() => _LanguagesGridState();
}

class _LanguagesGridState extends ConsumerState<LanguagesGrid> {

  @override
  Widget build(BuildContext context) {
    var languagesList = SupportedLocale.values;
    final selectedValue = AppSharedPreference.getLocale();

    return ListView.builder(
      shrinkWrap: true,
      itemCount: languagesList.length,
      itemBuilder: (context, index) {
        final language = languagesList[index];
        return LanguageCard(
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