
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';
import 'package:novablue_appointment_app/src/common_widgets/my_button.dart';
import 'package:novablue_appointment_app/src/common_widgets/my_dialog.dart';
import 'package:novablue_appointment_app/src/common_widgets/my_text_form_field.dart';
import 'package:novablue_appointment_app/src/constants/app_sizes.dart';
import 'package:novablue_appointment_app/src/localization/app_localizations_context.dart';
import 'package:novablue_appointment_app/src/routing/app_routing.dart';
import 'package:novablue_appointment_app/src/utils/formatters.dart';
import 'package:novablue_appointment_app/src/utils/validations.dart';
import 'create_password_screen.dart';
import 'create_password_screen_controller.dart';

class CreatePasswordForm extends ConsumerStatefulWidget {

  final AsyncValue<void> state;
  final CreatePasswordScreenArguments args;

  const CreatePasswordForm({super.key,required this.state, required this.args});

  @override
  _CreatePasswordFormState createState() => _CreatePasswordFormState();
}

class _CreatePasswordFormState extends ConsumerState<CreatePasswordForm> {

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
            text: context.loc.signUp.capitalize(),
            onPressed: widget.state.isLoading ? null : () async {
              setState(() {});
              if (_formKey.currentState!.validate()){
                await ref.read(createPasswordScreenControllerProvider.notifier).createUserWithEmailAndPassword(
                  password: password,
                  filePath: widget.args.filePath,
                  firstname: widget.args.firstname,
                  lastname: widget.args.lastname,
                  email: widget.args.email,
                  phone: widget.args.phone,
                  phoneCode: widget.args.phoneCode,
                  onSuccess: () async {
                    await showAlertDialog(
                      context: context,
                      type: DialogTypes.success,
                      label: context.loc.emailConfirmationSuccess,
                      positiveButtonOnPressed: () {
                        context.goNamed(AppRoute.login.name);
                      }
                    );
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
