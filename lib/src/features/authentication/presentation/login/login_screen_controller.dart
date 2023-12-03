

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/auth_repository.dart';

class LoginScreenController extends StateNotifier<AsyncValue<void>>{

  final SupabaseAuthRepository authRepository;

  LoginScreenController({required this.authRepository})
      : super(const AsyncValue<void>.data(null));

  Future<void> signInWithEmailAndPassword(String email,String password) async {
    state = const AsyncValue<void>.loading();
    state = await AsyncValue.guard(() => authRepository.signInWithEmailAndPassword(email, password));
  }

}


final loginScreenControllerProvider = StateNotifierProvider.autoDispose<LoginScreenController,AsyncValue<void>>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return LoginScreenController(authRepository: authRepository);
});