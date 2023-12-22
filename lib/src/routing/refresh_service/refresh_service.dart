
import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:novablue_appointment_app/src/routing/refresh_service/refresh_service_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../features/authentication/data/auth_repository.dart';
import '../../features/authentication/domain/user_role_company_supabase.dart';

class RefreshService {

  final Ref ref;
  StreamSubscription<UserRoleCompanySupabase?>? _subscription;
  StreamSubscription<AuthChangeEvent?>? _subscriptionSecond;

  StreamController<UserRoleCompanySupabase?> _outputStreamController = StreamController<UserRoleCompanySupabase?>();
  StreamController<AuthChangeEvent?> _outputStreamControllerSecond = StreamController<AuthChangeEvent?>();


  RefreshService(this.ref) {
    _init();
  }

  void _init() {
    ref.listen<AsyncValue<AuthChangeEvent?>>(watchEventChangesProvider, (previous, next) {
      final event = next.value;
      _subscription?.cancel();
      if (event != null) {
        getAuthEvent();
      }
    });

    ref.listen<AsyncValue<User?>>(watchUserSessionChangesProvider, (previous, next) {
      final user = next.value;
      _subscription?.cancel();
      if (user != null) {
        getActiveUserRoleCompany(user.id);
      }else{
        _outputStreamController.add(null);
      }
    });
  }

  getAuthEvent(){
    _subscriptionSecond = ref
        .read(authRepositoryProvider)
        .watchEventChanges()
        .listen((event) async {
      ref.read(currentAuthChangeEventProvider.notifier).state = event;
      _outputStreamControllerSecond.add(event);
    });
  }

  getActiveUserRoleCompany(String id){
    _subscription = ref
      .read(authRepositoryProvider)
      .watchActiveUserRoleCompany(id: id)
      .listen((role) async {
        final user = ref.read(authRepositoryProvider).currentUser;
        if (user != null) {
          ref.read(currentUserRoleCompanyProvider.notifier).state = role;
          _outputStreamController.add(role);
        }
    });
  }


  void dispose() {
    _subscription?.cancel();
    _subscriptionSecond?.cancel();
    _outputStreamController.close();
    _outputStreamControllerSecond.close();
  }

  Stream<UserRoleCompanySupabase?> get outputStream => _outputStreamController.stream;
  Stream<AuthChangeEvent?> get outputStreamSecond => _outputStreamControllerSecond.stream;

}