
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconly/iconly.dart';
import 'package:novablue_appointment_app/src/common_widgets/my_button.dart';
import 'package:novablue_appointment_app/src/common_widgets/my_text_form_field.dart';
import 'package:novablue_appointment_app/src/constants/app_sizes.dart';
import 'package:novablue_appointment_app/src/features/authentication/presentation/password/update_password/update_password_screen_controller.dart';
import 'package:novablue_appointment_app/src/localization/app_localizations_context.dart';
import 'package:novablue_appointment_app/src/utils/formatters.dart';
import 'package:novablue_appointment_app/src/utils/validations.dart';

class UpdatePasswordForm extends ConsumerStatefulWidget {

  final AsyncValue<void> state;

  const UpdatePasswordForm({super.key,required this.state});

  @override
  _UpdatePasswordFormState createState() => _UpdatePasswordFormState();
}

class _UpdatePasswordFormState extends ConsumerState<UpdatePasswordForm> {

  final _formKey = GlobalKey<FormState>();

  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _passwordHasError = false;
  bool _confirmPasswordHasError = false;

  bool _isPasswordFocused = false;
  bool _isConfirmPasswordFocused = false;

  bool _isPasswordObscure = true;
  bool _isConfirmPasswordObscure = true;

  String get password => _passwordController.text;
  String get confirmPassword => _confirmPasswordController.text;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          MyTextFormField(
            textEditingController: _passwordController,
            text: context.loc.password.capitalize(),
            errorText: context.loc.passwordValidation.capitalize(),
            prefixIcon: IconlyBold.message,
            suffixIcon: _isPasswordObscure ? IconlyBold.hide : IconlyBold.show,
            onSuffixIconTap: (){
              setState(() {
                _isPasswordObscure ? _isPasswordObscure = false : _isPasswordObscure = true;
              });
            },
            fieldHasError: _passwordHasError,
            isFieldFocused: _isPasswordFocused,
            isTextObscure: _isPasswordObscure,
            onFocusChange: (value) {
              setState(() {_isPasswordFocused = value;});
            },
            validator: (value){
              if(value == null || value.isEmpty || !Validations.isPasswordValid(value)){
                _passwordHasError = true;
                return '';
              }
              _passwordHasError = false;
              return null;
            }
          ),
          gapH24,
          MyTextFormField(
            textEditingController: _confirmPasswordController,
            text: context.loc.confirmPassword.capitalize(),
            errorText: context.loc.confirmPasswordValidation.capitalize(),
            prefixIcon: IconlyBold.message,
            suffixIcon: _isConfirmPasswordObscure ? IconlyBold.hide : IconlyBold.show,
            onSuffixIconTap: (){
              setState(() {
                _isConfirmPasswordObscure ? _isConfirmPasswordObscure = false : _isConfirmPasswordObscure = true;
              });
            },
            fieldHasError: _confirmPasswordHasError,
            isFieldFocused: _isConfirmPasswordFocused,
            isTextObscure: _isConfirmPasswordObscure,
            onFocusChange: (value) {
              setState(() {_isConfirmPasswordFocused = value;});
            },
            validator: (value){
              if(value == null || value.isEmpty || password != confirmPassword){
                _confirmPasswordHasError = true;
                return '';
              }
              _confirmPasswordHasError = false;
              return null;
            }
          ),
          gapH24,
          MyButton(
            type: ButtonTypes.filledFullyRounded,
            text: context.loc.change.capitalize(),
            onPressed: widget.state.isLoading ? null : () async {
              setState(() {});
              if (_formKey.currentState!.validate()){
                await ref.read(updatePasswordScreenControllerProvider.notifier).updatePassword(
                  ref: ref,
                  password: password,
                  onSuccess: () async{
                    await ref.read(updatePasswordScreenControllerProvider.notifier).signOut();
                  }
                );
              }
            }
          ),
          gapH48,
        ],
      )
    );
  }
}
