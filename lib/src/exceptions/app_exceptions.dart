
import 'package:novablue_appointment_app/src/localization/app_locale_notifier.dart';

enum AppExceptionTypes{
  unexpectedError,
  invalidLoginCredentials,
  emailAlreadyInUse,
  weakPassword,
  wrongPassword,
  samePassword,
  userNotFound,
  emailNotConfirmed,
  fileTooLarge,
  noUserIdException
}

sealed class AppException implements Exception {
  AppException(this.code, this.message);

  final String code;
  final String message;

  @override
  String toString() => message;
}

/// General Exceptions
class UnexpectedErrorException extends AppException {
  UnexpectedErrorException(ref) : super(AppExceptionTypes.unexpectedError.name, ref.read(appLocalizationsProvider).unexpectedErrorException);
}

/// Auth
class InvalidLoginCredentialsException extends AppException {
  InvalidLoginCredentialsException(ref) : super(AppExceptionTypes.invalidLoginCredentials.name, ref.read(appLocalizationsProvider).invalidLoginCredentialsException);
}

class EmailAlreadyInUseException extends AppException {
  EmailAlreadyInUseException(ref) : super(AppExceptionTypes.emailAlreadyInUse.name, ref.read(appLocalizationsProvider).emailAlreadyInUseException);
}

class WeakPasswordException extends AppException {
  WeakPasswordException(ref) : super(AppExceptionTypes.weakPassword.name, ref.read(appLocalizationsProvider).weakPasswordException);
}

class WrongPasswordException extends AppException {
  WrongPasswordException(ref) : super(AppExceptionTypes.wrongPassword.name, ref.read(appLocalizationsProvider).wrongPasswordException);
}

class SamePasswordException extends AppException {
  SamePasswordException(ref) : super(AppExceptionTypes.samePassword.name, ref.read(appLocalizationsProvider).samePasswordException);
}

class UserNotFoundException extends AppException {
  UserNotFoundException(ref) : super(AppExceptionTypes.userNotFound.name, ref.read(appLocalizationsProvider).userNotFoundException);
}

class EmailNotConfirmedException extends AppException {
  EmailNotConfirmedException(ref) : super(AppExceptionTypes.emailNotConfirmed.name, ref.read(appLocalizationsProvider).emailNotConfirmedException);
}

class FileTooLargeException extends AppException {
  FileTooLargeException(ref,fileMaxSizeInMegaBytes) : super(AppExceptionTypes.fileTooLarge.name, ref.read(appLocalizationsProvider).fileTooLargeException(fileMaxSizeInMegaBytes));
}

class NoUserRolesException extends AppException {
  NoUserRolesException(ref) : super(AppExceptionTypes.fileTooLarge.name, ref.read(appLocalizationsProvider).noUserRolesException);
}
