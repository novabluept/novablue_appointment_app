

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:novablue_appointment_app/src/exceptions/app_exceptions.dart';

import '../../data/auth_repository.dart';

class LoginScreenController extends StateNotifier<AsyncValue<void>>{

  final SupabaseAuthRepository authRepository;

  LoginScreenController({required this.authRepository})
      : super(const AsyncValue<void>.data(null));

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
    required void Function() onEmailNotConfirmed,
  })async{
    state = const AsyncValue<void>.loading();
    state = await AsyncValue.guard(() => authRepository.signInWithEmailAndPassword(
      email: email,
      password: password
    ));
    final error = state.error as AppException;
    if(error.code == AppExceptionTypes.emailNotConfirmed.name){
      onEmailNotConfirmed();
    }
  }

}


final loginScreenControllerProvider = StateNotifierProvider.autoDispose<LoginScreenController,AsyncValue<void>>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return LoginScreenController(authRepository: authRepository);
});