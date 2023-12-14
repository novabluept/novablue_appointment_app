
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconly/iconly.dart';
import 'package:novablue_appointment_app/src/common_widgets/my_app_bar.dart';
import 'package:novablue_appointment_app/src/common_widgets/my_button.dart';
import 'package:novablue_appointment_app/src/common_widgets/my_scaffold.dart';
import 'package:novablue_appointment_app/src/common_widgets/my_text.dart';
import 'package:novablue_appointment_app/src/common_widgets/my_text_form_field.dart';
import 'package:novablue_appointment_app/src/constants/app_colors.dart';
import 'package:novablue_appointment_app/src/constants/app_sizes.dart';
import 'package:novablue_appointment_app/src/features/authentication/presentation/password/password_recovery/password_recovery_screen_controller.dart';
import 'package:novablue_appointment_app/src/localization/app_localizations_context.dart';
import 'package:novablue_appointment_app/src/utils/dialogs.dart';
import 'package:novablue_appointment_app/src/utils/formatters.dart';
import 'package:novablue_appointment_app/src/utils/validations.dart';
import '../../../../../common_widgets/my_svg.dart';


class PasswordRecoveryScreen extends ConsumerStatefulWidget {

  const PasswordRecoveryScreen({super.key});

  @override
  _PasswordRecoveryScreenState createState() => _PasswordRecoveryScreenState();
}

class _PasswordRecoveryScreenState extends ConsumerState<PasswordRecoveryScreen>{

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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<void>>(
      passwordRecoveryScreenControllerProvider,
          (_, state) => state.showDialogError(context: context),
    );
    final state = ref.watch(passwordRecoveryScreenControllerProvider);
    return MyScaffold(
      state: state,
      onWillPop: () async {
        await ref.read(passwordRecoveryScreenControllerProvider.notifier).signOut();
        return false;
      },
      appBar: MyAppBar(
        title: context.loc.recoverPassword.capitalize(),
        leading: Transform.translate(
          offset: Offset(-Sizes.s16.w, Sizes.s0),
          child: GestureDetector(
            onTap: () async {
              await ref.read(passwordRecoveryScreenControllerProvider.notifier).signOut();
            },
            child: Icon(IconlyLight.arrow_left, size: Sizes.s20.w, color: OtherColors.black)
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            gapH71,
            MySvg(
              colorFilter: MainColors.primary,
              imagePath: 'images/app_info_blue/recover_password_image.svg',
              width: Sizes.s329.w,
              height: Sizes.s250.h
            ),
            gapH71,
            Align(
              alignment: Alignment.centerLeft,
              child: MyText(type: TextTypes.bodyLarge,fontWeight: FontWeights.medium, text: context.loc.createYourNewPassword.capitalize())
            ),
            gapH24,
            Form(
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
                    text: context.loc.recover.capitalize(),
                    onPressed: state.isLoading ? null : () async {
                      setState(() {});
                      if (_formKey.currentState!.validate()){
                        await ref.read(passwordRecoveryScreenControllerProvider.notifier).updatePassword(
                          password: password,
                          onSuccess: () async {
                            await ref.read(passwordRecoveryScreenControllerProvider.notifier).signOut();
                          }
                        );
                      }
                    }
                  ),
                  gapH48,
                ],
              )
            )
          ],
        ),
      ),
    );
  }
}