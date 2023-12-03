
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:novablue_appointment_app/src/constants/app_file_size.dart';
import 'package:novablue_appointment_app/src/supabase_providers/providers.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide Provider;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../exceptions/app_exceptions.dart';
import '../domain/user_model.dart';

abstract class AuthRepository {
  Stream<User?>  authStateChanges();
  User? get currentUser;
  Future<void> signInWithEmailAndPassword(String email, String password);
  Future<void> createUserWithEmailAndPassword(String filePath,String firstname,String lastname,String email,String phone,String phoneCode);
  Future<void> signOut();
  Future<void> resetPasswordForEmail(String email);
  Future<File?> chooseProfileImage();
}

class SupabaseAuthRepository implements AuthRepository{

  SupabaseAuthRepository(this.ref,this._client);

  final Ref ref;
  final SupabaseClient _client;


  @override
  Stream<User?> authStateChanges() async*{
    final authStream = _client.auth.onAuthStateChange;

    await for (final authState in authStream) {
      yield authState.session?.user;
    }
  }

  @override
  User? get currentUser => _client.auth.currentUser;

  Future<void> _uploadProfileImage(String id,String filePath) async{
    await _client.storage.from('users').upload('/${id}/profileImage', File(filePath))
      .catchError((e){
        print(e);
        throw UnexpectedErrorException(ref);
      }
    );
  }

  Future<void> _createUser(String id,String filePath,String firstname,String lastname,String email,String phone,String phoneCode) async{
    var user = UserModel(
      id: id,
      firstname: firstname,
      lastname: lastname,
      email: email,
      phone: phone,
      phoneCode: phoneCode,
      updatedAt: DateTime.now().toUtc().toIso8601String(),
    ).toJson();

    await _client.from('user').insert(user)
      .then((value) async => filePath != '' ? await _uploadProfileImage(id,filePath) : null)
      .catchError((e){
      throw UnexpectedErrorException(ref);
      }
    );
  }

  @override
  Future<void> createUserWithEmailAndPassword(String filePath,String firstname,String lastname,String email,String phone,String phoneCode) async{
    await _client.auth.signUp(
      email: 'johnaway4443@gmail.com',
      password: '12345678',
    ).then((value) async{
      await _createUser(value.user!.id,filePath,firstname,lastname,email,phone,phoneCode);
    }).catchError((e){
      throw UnexpectedErrorException(ref);
    });
  }

  @override
  Future<void> signInWithEmailAndPassword(String email, String password) async{
    await _client.auth.signInWithPassword(
      email: email, // 'miguelsilva20015111@gmail.com'
      password: password, // '12345678'
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
  Future<void> signOut() async{
    await _client.auth.signOut();
  }

  @override
  Future<void> resetPasswordForEmail(String email) async{
    await _client.auth.resetPasswordForEmail(
      email
    ).catchError((e){
      throw UnexpectedErrorException(ref);
    });
  }

  @override
  Future<File?> chooseProfileImage() async{
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

}

final authRepositoryProvider = Provider<SupabaseAuthRepository>((ref) {
  final client = ref.watch(supabaseClientProvider);
  return SupabaseAuthRepository(ref,client);
});

final authStateChangesProvider = StreamProvider((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return authRepository.authStateChanges();
});







