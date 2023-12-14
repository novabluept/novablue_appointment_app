
import 'dart:ui';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:novablue_appointment_app/src/features/authentication/data/auth_repository.dart';
import 'package:novablue_appointment_app/src/localization/app_locale_notifier.dart';
import 'package:novablue_appointment_app/src/localization/app_supported_locale.dart';

class ChangeLanguageScreenController extends StateNotifier<AsyncValue<void>>{

  final SupabaseAuthRepository authRepository;

  ChangeLanguageScreenController({required this.authRepository}) : super(const AsyncValue<void>.data(null));

  void changeLanguage(WidgetRef ref,Object locale){
    final newValue = locale as Locale;
    final savedValue = newValue.languageCode == SupportedLocale.pt.countryCode ? SupportedLocale.pt : SupportedLocale.en;
    ref.read(localeProvider.notifier).changeLanguage(savedValue);
  }
}

final changeLanguageScreenControllerProvider = StateNotifierProvider.autoDispose<ChangeLanguageScreenController,AsyncValue<void>>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return ChangeLanguageScreenController(authRepository: authRepository);
});