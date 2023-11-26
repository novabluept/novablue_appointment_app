import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:novablue_appointment_app/src/localization/app_supported_locale.dart';
import '../utils/shared_prefrences.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LocaleNotifier extends StateNotifier<Locale>{
  LocaleNotifier(): super(Locale(SupportedLocale.pt.countryCode)) {
    onAppStart();
  }
  void changeLanguage(SupportedLocale locale){
    try {
      AppSharedPreference.saveLocale(locale);
      state = Locale(locale.countryCode);
    } catch (error) {
      state = Locale(SupportedLocale.pt.countryCode);
    }
  }

  void onAppStart(){
    try {
      final locale = AppSharedPreference.getLocale();
      state = locale;
    } catch (error) {
      state = Locale(SupportedLocale.pt.countryCode);
    }
  }
}

final localeProvider = StateNotifierProvider<LocaleNotifier,Locale>((ref){
  return LocaleNotifier();
});

final appLocalizationsProvider = Provider<AppLocalizations>((ref) {
  // set the initial locale from SharedPreferences
  ref.state = lookupAppLocalizations(
    basicLocaleListResolution(
      [Locale(ref.watch(localeProvider).toString())], // Use the value from the localeProvider
      AppLocalizations.supportedLocales,
    ),
  );

  // update afterwards when SharedPreferences changes
  final observer = _LocaleObserver((locales) {
    ref.state = lookupAppLocalizations(
      basicLocaleListResolution(
        [Locale(ref.watch(localeProvider).toString())], // Use the updated value from the localeProvider
        AppLocalizations.supportedLocales,
      ),
    );
  });

  final binding = WidgetsBinding.instance;
  binding.addObserver(observer);
  ref.onDispose(() => binding.removeObserver(observer));

  return ref.state;
});

class _LocaleObserver extends WidgetsBindingObserver {
  _LocaleObserver(this._didChangeLocales);
  final void Function(List<Locale>? locales) _didChangeLocales;

  @override
  void didChangeLocales(List<Locale>? locales) {
    _didChangeLocales(locales);
  }
}
