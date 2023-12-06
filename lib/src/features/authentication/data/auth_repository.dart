
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:novablue_appointment_app/src/constants/app_file_size.dart';
import 'package:novablue_appointment_app/src/supabase_providers/providers.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide Provider;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../exceptions/app_exceptions.dart';
import '../domain/user_model.dart';

abstract class AuthRepository {
  Stream  authStateChanges();
  User? get currentUser;
  Future<void> signInWithEmailAndPassword({required String email,required String password});
  Future<void> createUserWithEmailAndPassword({required String password, required String filePath, required String firstname, required String lastname, required String email, required String phone, required String phoneCode});
  Future<void> signOut();
  Future<void> resetPasswordForEmail({required String email});
  Future<void> updatePassword({required String password});
  Future<void> resend({required String email});
  Future<File?> chooseProfileImage();
}

class SupabaseAuthRepository implements AuthRepository{

  final String loginCallback = 'io.supabase.novablue://login-callback/';
  final String updatePasswordCallback = 'io.supabase.novablue://update-password-callback/';

  static String userTable() => 'user';
  static String userBucket() => 'users';
  static String userBucketFilePath(String id) => '/${id}/profileImage';

  final Ref ref;
  final SupabaseClient _client;

  SupabaseAuthRepository(this.ref,this._client);

  @override
  Stream<User?> authStateChanges() async*{
    final authStream = _client.auth.onAuthStateChange;
    await for (final authState in authStream) {
      ref.read(authChangeEventProvider.notifier).state = authState.event;
      yield authState.session?.user;
    }
  }

  @override
  User? get currentUser => _client.auth.currentUser;

  Future<void> _uploadProfileImage({
    required String id,
    required String filePath
  })async{
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
  })async{
    var user = UserModel(
      id: id,
      firstname: firstname,
      lastname: lastname,
      email: email,
      phone: phone,
      phoneCode: phoneCode,
      updatedAt: DateTime.now().toUtc().toIso8601String(),
    ).toJson();

    await _client.from(userTable()).insert(user)
      .then((value) async =>
        filePath != '' ?
        await _uploadProfileImage(
          id: id,
          filePath: filePath
        )
        : null
      )
      .catchError((e){
      throw UnexpectedErrorException(ref);
      }
    );
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
  })async{
    await _client.auth.signUp(
      email: email,
      password: password,
      emailRedirectTo: loginCallback
    ).then((value)async{
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
  Future<void> signInWithEmailAndPassword({required String email,required String password})async{
    await _client.auth.signInWithPassword(
      email: email,
      password: password,
    ).catchError((e){
      if(e.message == 'Invalid login credentials'){
        throw InvalidLoginCredentialsException(ref);
      }else if(e.message == 'Email not confirmed'){
        throw EmailNotConfirmedException(ref);
      }
      throw UnexpectedErrorException(ref);
    });
  }

  @override
  Future<void> signOut()async{
    await _client.auth.signOut();
  }

  @override
  Future<void> resetPasswordForEmail({required String email})async{
    await _client.auth.resetPasswordForEmail(
      email,
      redirectTo: updatePasswordCallback,
    ).catchError((e){
      throw UnexpectedErrorException(ref);
    });
  }

  @override
  Future<void> updatePassword({required String password}) async{
    await _client.auth.updateUser(
      UserAttributes(password: password)
    ).catchError((e){
      throw UnexpectedErrorException(ref);
    });
  }

  @override
  Future<File?> chooseProfileImage()async{
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

  @override
  Future<void> resend({required String email}) async{
    await _client.auth.resend(
      email: email,
      type: OtpType.signup,
      emailRedirectTo: loginCallback
    ).catchError((e){
      throw UnexpectedErrorException(ref);
    });
  }

}

final authRepositoryProvider = Provider<SupabaseAuthRepository>((ref) {
  final client = ref.watch(supabaseClientProvider);
  return SupabaseAuthRepository(ref,client);
});

final authStateChangesProvider = StreamProvider((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return authRepository.authStateChanges();
});

final authChangeEventProvider = StateProvider<AuthChangeEvent>((ref) => AuthChangeEvent.signedOut);







