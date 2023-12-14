
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:novablue_appointment_app/src/features/authentication/data/auth_repository.dart';

class PersonalDataScreenController extends StateNotifier<AsyncValue<File?>>{

  final SupabaseAuthRepository authRepository;

  PersonalDataScreenController({required this.authRepository}) : super(const AsyncValue<File?>.data(null));

  Future chooseProfilePicture() async {
    state = const AsyncLoading();
    final value = await AsyncValue.guard(() => authRepository.chooseProfileImage());
    if (value.hasError) {
      state = AsyncError(value.error!, StackTrace.current);
    } else {
      state = AsyncData(value.value);
    }
  }
}

final personalDataScreenControllerProvider = StateNotifierProvider.autoDispose<PersonalDataScreenController,AsyncValue<File?>>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return PersonalDataScreenController(authRepository: authRepository);
});