
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/auth_repository.dart';

class ProfileScreenController extends StateNotifier<AsyncValue<void>>{

  final SupabaseAuthRepository authRepository;

  ProfileScreenController({required this.authRepository}) : super(const AsyncValue<void>.data(null));

  Future<void> signOut() async {
    state = const AsyncValue<void>.loading();
    final newState = await AsyncValue.guard(() => authRepository.signOut());
    if(mounted){
      state = newState;
    }
  }

}

final profileScreenControllerProvider = StateNotifierProvider.autoDispose<ProfileScreenController,AsyncValue<void>>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return ProfileScreenController(authRepository: authRepository);
});