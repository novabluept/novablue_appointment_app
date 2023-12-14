
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:novablue_appointment_app/src/features/authentication/data/auth_repository.dart';
import 'package:novablue_appointment_app/src/features/authentication/domain/user_role_company_supabase.dart';
import 'change_role_list_provider.dart';

class ChangeRoleScreenController extends StateNotifier<AsyncValue<void>>{

  final SupabaseAuthRepository authRepository;

  ChangeRoleScreenController({required this.authRepository}) : super(const AsyncValue<void>.data(null));

  void changeTempRole(WidgetRef ref,UserRoleCompanySupabase value){
    ref.read(tempUserRoleCompanyProvider.notifier).state = value;
  }
}

final changeRoleScreenControllerProvider = StateNotifierProvider.autoDispose<ChangeRoleScreenController,AsyncValue<void>>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return ChangeRoleScreenController(authRepository: authRepository);
});