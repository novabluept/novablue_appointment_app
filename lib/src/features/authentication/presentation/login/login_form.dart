
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:novablue_appointment_app/src/common_widgets/my_button.dart';
import 'package:novablue_appointment_app/src/common_widgets/my_text_form_field.dart';
import 'package:novablue_appointment_app/src/constants/app_sizes.dart';
import 'package:novablue_appointment_app/src/features/authentication/presentation/login/login_screen_controller.dart';
import 'package:novablue_appointment_app/src/localization/app_localizations_context.dart';
import 'package:novablue_appointment_app/src/routing/app_routing.dart';
import 'package:novablue_appointment_app/src/routing/refresh_service/refresh_service_provider.dart';
import 'package:novablue_appointment_app/src/utils/formatters.dart';
import 'package:iconly/iconly.dart';
import 'package:novablue_appointment_app/src/utils/validations.dart';

class LoginForm extends ConsumerStatefulWidget {

  final AsyncValue<void> state;

  const LoginForm({super.key,required this.state});

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends ConsumerState<LoginForm> {

  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _emailHasError = false;
  bool _passwordHasError = false;

  bool _isEmailFocused = false;
  bool _isPasswordFocused = false;

  bool _isPasswordObscure = true;

  String get email => _emailController.text;
  String get password => _passwordController.text;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
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
            textEditingController: _emailController,
            text: context.loc.email.capitalize(),
            errorText: context.loc.emailValidation.capitalize(),
            prefixIcon: IconlyBold.message,
            fieldHasError: _emailHasError,
            isFieldFocused: _isEmailFocused,
            onFocusChange: (value) {
              setState(() {_isEmailFocused = value;});
            },
            validator: (value){
              if(value == null || value.isEmpty || !Validations.isEmailValid(value)){
                _emailHasError = true;
                return '';
              }
              _emailHasError = false;
              return null;
            }
          ),
          gapH20,
          MyTextFormField(
            textEditingController: _passwordController,
            text: context.loc.password.capitalize(),
            prefixIcon: IconlyBold.lock,
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
              return null;
            },
          ),
          gapH64,
          MyButton(
            type: ButtonTypes.filledFullyRounded,
            text: context.loc.login.capitalize(),
            onPressed: widget.state.isLoading ? null : () async {
              setState(() {});
              if (_formKey.currentState!.validate()){
                ref.read(currentUserRoleCompanyProvider.notifier).state = null;
                await ref.read(loginScreenControllerProvider.notifier).signInWithEmailAndPassword(
                  email: email,
                  password: password,
                  onEmailNotConfirmed: (){
                    context.pushNamed(AppRoute.confirmEmail.name);
                  }
                );
              }
            }
          ),
        ],
      )
    );
  }
}
