
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:novablue_appointment_app/src/constants/app_file_size.dart';
import 'package:novablue_appointment_app/src/exceptions/app_exceptions.dart';
import 'package:novablue_appointment_app/src/features/authentication/domain/user_role_company_supabase.dart';
import 'package:novablue_appointment_app/src/features/authentication/domain/user_supabase.dart';
import 'package:novablue_appointment_app/src/routing/scaffold_with_nested_navigation/scaffold_with_nested_navigation_provider.dart';
import 'package:novablue_appointment_app/src/supabase_providers/providers.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide Provider;
import 'package:flutter_riverpod/flutter_riverpod.dart';


abstract class AuthRepository {
  User? get currentUser;
  Stream<User?> watchUserSessionChanges();
  Stream<AuthChangeEvent?> watchEventChanges();
  Stream<UserRoleCompanySupabase> watchActiveUserRoleCompany({required String id});
  Future<File?> chooseProfileImage();
  Future<void> signInWithEmailAndPassword({required String email,required String password});
  Future<void> createUserWithEmailAndPassword({required String password, required String filePath, required String firstname, required String lastname, required String email, required String phone, required String phoneCode});
  Future<void> signOut();
  Future<void> resetPasswordForEmail({required String email});
  Future<void> updatePassword({required String password});
  Future<void> resend({required String email});
  Future<List<UserRoleCompanySupabase>> getUserRoles({required String id});
  Future<void> updateActiveUserRole({required String id,required UserRoleCompanySupabase previousRole,required UserRoleCompanySupabase nextRole});

}

class SupabaseAuthRepository implements AuthRepository{

  final String loginCallback = 'io.supabase.novablue://login-callback/';
  final String updatePasswordCallback = 'io.supabase.novablue://update-password-callback/';

  static String userTable() => 'user';
  static String userRoleCompanyTable() => 'user_role_company';

  static String userBucket() => 'users';
  static String userBucketFilePath(String id) => '/${id}/profileImage';

  final Ref ref;
  final SupabaseClient _client;

  SupabaseAuthRepository(this.ref,this._client);

  @override
  User? get currentUser => _client.auth.currentUser;

  @override
  Stream<User?> watchUserSessionChanges() async*{
    final authStream = _client.auth.onAuthStateChange;

    await for (final authState in authStream) {
      yield authState.session?.user;
    }
  }

  @override
  Stream<AuthChangeEvent?> watchEventChanges() async*{
    final authStream = _client.auth.onAuthStateChange;

    await for (final authState in authStream) {
      yield authState.event;
    }
  }

  @override
  Stream<UserRoleCompanySupabase> watchActiveUserRoleCompany({required String id}) {

    return _client
      .from(userRoleCompanyTable())
      .stream(primaryKey: ['id'])
      .eq('user_id', id)
      .map((event) {
        List<UserRoleCompanySupabase> list = event.map((item) => UserRoleCompanySupabase.fromJson(item)).toList();

        for(var role in list){
          if(role.active){
            return role;
          }
        }

        return UserRoleCompanySupabase(id: 0, userId: id, rolePt: UserRoles.user.rolePt, roleEn: UserRoles.user.roleEn, active: true);
    });

  }

  @override
  Future<File?> chooseProfileImage() async {
    final file = await ImagePicker().pickImage(source: ImageSource.gallery,imageQuality: 80);
    if(file != null){
      var imagePath = await file.readAsBytes();
      var fileSize = imagePath.length;
      if(fileSize <= fileMaxSizeInBytes){
        return File(file.path);
      }else if(fileSize > fileMaxSizeInBytes){
        throw FileTooLargeException(ref,fileMaxSizeInMegaBytes);
      }
    }
    return null;
  }

  Future<void> _uploadProfileImage({
    required String id,
    required String filePath
  }) async {
    await _client.storage.from(userBucket()).upload(userBucketFilePath(id), File(filePath))
      .catchError((e){
        throw UnexpectedErrorException(ref);
      }
    );
  }

  Future<void> _createUser({
    required String id,
    required String filePath,
    required String firstname,
    required String lastname,
    required String email,
    required String phone,
    required String phoneCode
  }) async {

    try{
      var user = UserSupabase(
        id: id,
        firstname: firstname,
        lastname: lastname,
        email: email,
        phone: phone,
        phoneCode: phoneCode,
        updatedAt: DateTime.now().toUtc().toIso8601String(),
      ).toJson();

      var userRoleCompany = UserRoleCompanySupabase(
        id: 0,
        userId: id,
        rolePt: UserRoles.user.rolePt,
        roleEn: UserRoles.user.roleEn,
        active: true
      ).toJson();

      await _client.from(userTable())
        .insert(user)
        .then((value) async => filePath != '' ? await _uploadProfileImage(id: id, filePath: filePath): null
      );

      await _client.from(userRoleCompanyTable()).insert(userRoleCompany);
    }catch(e){
      throw UnexpectedErrorException(ref);
    }
  }

  @override
  Future<void> createUserWithEmailAndPassword({
    required String password,
    required String filePath,
    required String firstname,
    required String lastname,
    required String email,
    required String phone,
    required String phoneCode
  }) async {
    await _client.auth.signUp(
      email: email,
      password: password,
      emailRedirectTo: loginCallback
    ).then((value) async {
      await _createUser(
        id: value.user!.id,
        filePath: filePath,
        firstname: firstname,
        lastname: lastname,
        email: email,
        phone: phone,
        phoneCode: phoneCode
      );
    }).catchError((e){
      throw UnexpectedErrorException(ref);
    });
  }

  @override
  Future<void> signInWithEmailAndPassword({required String email,required String password}) async {
    await _client.auth.signInWithPassword(
      email: email,
      password: password,
    ).then((value) async {
      //await _chooseSignInRole(id: value.user!.id);
    }).catchError((e){
      if(e.message == 'Invalid login credentials'){
        throw InvalidLoginCredentialsException(ref);
      }else if(e.message == 'Email not confirmed'){
        throw EmailNotConfirmedException(ref);
      }
      throw UnexpectedErrorException(ref);
    });
  }

  @override
  Future<void> signOut() async {
    await _client.auth.signOut();
  }

  @override
  Future<void> resetPasswordForEmail({required String email}) async {
    await _client.auth.resetPasswordForEmail(
      email,
      redirectTo: updatePasswordCallback,
    ).catchError((e){
      print('error -> ${e.toString()}');
      throw UnexpectedErrorException(ref);
    });
  }

  @override
  Future<void> updatePassword({required String password}) async {
    await _client.auth.updateUser(
      UserAttributes(password: password)
    ).catchError((e){
      print('error -> ${e.toString()}');
      if(e.message == 'New password should be different from the old password.'){
        throw SamePasswordException(ref);
      }
      throw UnexpectedErrorException(ref);
    });
  }

  @override
  Future<void> resend({required String email}) async {
    await _client.auth.resend(
      email: email,
      type: OtpType.signup,
      emailRedirectTo: loginCallback
    ).catchError((e){
      throw UnexpectedErrorException(ref);
    });
  }

  @override
  Future<List<UserRoleCompanySupabase>> getUserRoles({required String id}) async {
    try {
      final response = await _client
        .from(userRoleCompanyTable())
        .select()
        .match({'user_id': id});

      List<UserRoleCompanySupabase> userRoles = List<UserRoleCompanySupabase>.from(response.map((model)=> UserRoleCompanySupabase.fromJson(model)));

      return userRoles;
    } catch (error) {
      throw error;
    }
  }

  @override
  Future<void> updateActiveUserRole({required String id,required UserRoleCompanySupabase previousRole,required UserRoleCompanySupabase nextRole}) async{
    try {

      // Reset bottom navigation index
      ref.read(currentIndexProvider.notifier).state = 0;

      // Update the previous role to not active
      await _client
        .from(userRoleCompanyTable())
        .update({'active': false})
        .match({'id': previousRole.id});

      // Update the next role to active
      await _client
        .from(userRoleCompanyTable())
        .update({'active': true})
        .match({'id': nextRole.id});
    } catch (error) {
      throw error;
    }
  }



}

final authRepositoryProvider = Provider<SupabaseAuthRepository>((ref) {
  final client = ref.watch(supabaseClientProvider);
  return SupabaseAuthRepository(ref,client);
});


final watchUserSessionChangesProvider = StreamProvider<User?>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return authRepository.watchUserSessionChanges();
});

final watchEventChangesProvider = StreamProvider<AuthChangeEvent?>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return authRepository.watchEventChanges();
});

final watchActiveUserRoleCompanyProvider = StreamProvider.family<UserRoleCompanySupabase,String>((ref,id) {
  final authRepository = ref.watch(authRepositoryProvider);
  return authRepository.watchActiveUserRoleCompany(id: id);
});

final getRolesProvider = FutureProvider.autoDispose.family<List<UserRoleCompanySupabase>,String>((ref,id) {
  final authRepository = ref.watch(authRepositoryProvider);
  return authRepository.getUserRoles(id: id);
});








