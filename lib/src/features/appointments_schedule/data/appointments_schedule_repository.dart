
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:novablue_appointment_app/src/exceptions/app_exceptions.dart';
import 'package:novablue_appointment_app/src/features/authentication/data/auth_repository.dart';
import 'package:novablue_appointment_app/src/features/authentication/domain/user_role_company_supabase.dart';
import 'package:novablue_appointment_app/src/features/authentication/domain/user_supabase.dart';
import 'package:novablue_appointment_app/src/supabase_providers/providers.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AppointmentsScheduleRepository {
  Future<List<UserSupabase>> getShopWorkers(String id);
}

class SupabaseAppointmentsScheduleRepository implements AppointmentsScheduleRepository{

  final Ref ref;
  final SupabaseClient _client;

  SupabaseAppointmentsScheduleRepository(this.ref,this._client);

  Future<List<String>> _getShopWorkersIds(String id) async{
    try{
      final responseUserRoleCompanyShop = await _client
          .from(SupabaseAuthRepository.userRoleCompanyShopTable())
          .select()
          .match({
        'shop_id': id,
        'role_en': UserRoles.worker.roleEn
      });

      List<UserRoleCompanyShopSupabase> listUserRoleCompanyShop = responseUserRoleCompanyShop.map((item) => UserRoleCompanyShopSupabase.fromJson(item)).toList();

      List<String> listWorkerIds = [];

      for(var worker in listUserRoleCompanyShop){
        listWorkerIds.add(worker.userId);
      }

      return listWorkerIds;
    }catch(e){
      throw UnexpectedErrorException(ref);
    }
  }

  String _getWorkersImage(String workerId) {
    try{
      return _client.storage.from(SupabaseAuthRepository.userBucket()).getPublicUrl(SupabaseAuthRepository.selectUserBucketFilePath(workerId));
    } catch (error) {
      throw UnexpectedErrorException(ref);
    }

  }

  @override
  Future<List<UserSupabase>> getShopWorkers(String id) async{
    try {
      List<String> listWorkerIds = await _getShopWorkersIds(id);

      final responseUsers = await _client
        .from(SupabaseAuthRepository.userTable())
        .select()
        .inFilter('id', listWorkerIds);

      List<UserSupabase> listWorkers = responseUsers.map((item) => UserSupabase.fromJson(item)).toList();

      for(var worker in listWorkers){
        worker.userImageUrl = _getWorkersImage(worker.id);
      }

      return listWorkers;
    } catch (error) {
      throw UnexpectedErrorException(ref);
    }
  }

}

final appointmentsScheduleRepositoryProvider = Provider<SupabaseAppointmentsScheduleRepository>((ref) {
  final client = ref.watch(supabaseClientProvider);
  return SupabaseAppointmentsScheduleRepository(ref,client);
});

final getShopWorkersProvider = FutureProvider.autoDispose.family<List<UserSupabase>,String>((ref,id) {
  final appointmentsScheduleRepository = ref.watch(appointmentsScheduleRepositoryProvider);
  return appointmentsScheduleRepository.getShopWorkers(id);
});