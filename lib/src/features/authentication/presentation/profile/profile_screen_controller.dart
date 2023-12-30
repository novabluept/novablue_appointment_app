
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:novablue_appointment_app/src/constants/app_duration.dart';
import 'package:novablue_appointment_app/src/features/authentication/data/auth_repository.dart';
import 'package:novablue_appointment_app/src/features/authentication/domain/user_role_company_supabase.dart';
import 'package:novablue_appointment_app/src/routing/refresh_service/refresh_service_provider.dart';
import 'package:novablue_appointment_app/src/routing/scaffold_with_nested_navigation/scaffold_with_nested_navigation_provider.dart';

class ProfileScreenController extends StateNotifier<AsyncValue<void>>{

  final SupabaseAuthRepository authRepository;

  ProfileScreenController({required this.authRepository}) : super(const AsyncValue<void>.data(null));

  Future<void> signOut(WidgetRef ref) async {
    state = const AsyncValue<void>.loading();
    ref.read(currentIndexProvider.notifier).state = 0;
    final newState = await AsyncValue.guard(() => authRepository.signOut());
    if(mounted){
      state = newState;
    }
  }

  Future<void> setUserRoleCompany(WidgetRef ref,UserRoleCompanySupabase value) async{
    ref.read(isBottomLoadingProvider.notifier).state = true;
    state = const AsyncValue<void>.loading();
    ref.read(currentUserRoleCompanyProvider) != value ? ref.read(currentIndexProvider.notifier).state = 0 : null;
    await Future.delayed(Duration(seconds: fakeAsyncDelayMilliseconds));
    ref.read(currentUserRoleCompanyProvider.notifier).state = value;
    state = const AsyncValue<void>.data(null);
    ref.read(isBottomLoadingProvider.notifier).state = false;
  }
}

final profileScreenControllerProvider = StateNotifierProvider.autoDispose<ProfileScreenController,AsyncValue<void>>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return ProfileScreenController(authRepository: authRepository);
});