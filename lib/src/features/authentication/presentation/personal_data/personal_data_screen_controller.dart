

import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/auth_repository.dart';

class PersonalDataScreenController extends StateNotifier<AsyncValue<void>>{

  final SupabaseAuthRepository authRepository;

  PersonalDataScreenController({required this.authRepository})
      : super(const AsyncValue<void>.data(null));

  Future<void> chooseProfilePicture() async {
    state = const AsyncValue<void>.loading();
    state = await AsyncValue.guard(() => authRepository.chooseProfilePicture());
  }

}


final PersonalDataScreenControllerProvider = StateNotifierProvider<PersonalDataScreenController,AsyncValue<void>>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return PersonalDataScreenController(authRepository: authRepository);
});