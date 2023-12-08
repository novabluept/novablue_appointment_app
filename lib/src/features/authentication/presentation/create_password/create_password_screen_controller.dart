
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/auth_repository.dart';

class CreatePasswordScreenController extends StateNotifier<AsyncValue<void>>{

  final SupabaseAuthRepository authRepository;

  CreatePasswordScreenController({required this.authRepository})
      : super(const AsyncValue<void>.data(null));

  Future<void> createUserWithEmailAndPassword({
    required String password,
    required String filePath,
    required String firstname,
    required String lastname,
    required String email,
    required String phone,
    required String phoneCode,
    required void Function() onSuccess,
  }) async {
    state = const AsyncValue<void>.loading();
    final newState = await AsyncValue.guard(() => authRepository.createUserWithEmailAndPassword(
        password: password,
        filePath: filePath,
        firstname: firstname,
        lastname: lastname,
        email: email,
        phone: phone,
        phoneCode: phoneCode
    ));
    if(mounted){
      state = newState;
      if(!state.hasError){
        onSuccess();
      }
    }
  }
}

final createPasswordScreenControllerProvider = StateNotifierProvider.autoDispose<CreatePasswordScreenController,AsyncValue<void>>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return CreatePasswordScreenController(authRepository: authRepository);
});