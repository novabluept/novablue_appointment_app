
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:novablue_appointment_app/src/common_widgets/my_button.dart';
import 'package:novablue_appointment_app/src/common_widgets/my_scaffold.dart';
import 'package:novablue_appointment_app/src/common_widgets/my_text.dart';
import 'package:novablue_appointment_app/src/constants/app_colors.dart';
import 'package:novablue_appointment_app/src/constants/app_sizes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:novablue_appointment_app/src/features/authentication/presentation/login/login_screen_controller.dart';
import 'package:novablue_appointment_app/src/localization/app_localizations_context.dart';
import 'package:novablue_appointment_app/src/utils/formatters.dart';
  import '../../../../common_widgets/my_app_bar.dart';
import '../../../../common_widgets/my_dropdown_button.dart';
import '../../../../common_widgets/my_text_form_field.dart';
import 'package:iconly/iconly.dart';
import '../../../../localization/app_locale_notifier.dart';
import '../../../../localization/app_supported_locale.dart';
import '../../../../routing/app_routing.dart';
import '../../../../utils/shared_prefrences.dart';
import '../../../../utils/validations.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {

  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _emailHasError = false;
  final _passwordHasError = false;

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
    ref.listen<AsyncValue<void>>(
      loginScreenControllerProvider,
      (_, state) {
        /*final error = state.error != null ? state.error as AppException : null;
        if(error?.code != AppExceptionTypes.emailNotConfirmed.name){
          state.showDialogError(context: context);
        }*/
      },
    );
    final state = ref.watch(loginScreenControllerProvider);
    return MyScaffold(
      state: state,
      appBar: MyAppBar(
        actions: [
          MyDropdownButton<SupportedLocale>(
            items: SupportedLocale.values,
            icon: Row(
              children: [
                SvgPicture.asset(
                  AppSharedPreference.getLocale() == Locale(SupportedLocale.pt.countryCode) ? 'images/flags/portugal.svg' : 'images/flags/united_kingdom.svg',
                  width: Sizes.s24.w,
                  height: Sizes.s18.h
                ),
                gapW4,
                Icon(IconlyBold.arrow_down_2,size: Sizes.s12.w,color: GreyScaleColors.grey500)
              ],
            ),
            dropDownMenuItem: SupportedLocale.values.map<DropdownMenuItem<SupportedLocale>>((e) => DropdownMenuItem<SupportedLocale>(
              value: e,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SvgPicture.asset(e.path,width: Sizes.s24.w,height: Sizes.s18.h),
                  gapW4,
                  MyText(
                    type: TextTypes.bodyMedium,
                    fontWeight: FontWeights.semiBold,
                    text: e.name == SupportedLocale.pt.name ? context.loc.portuguese.capitalize() : context.loc.english.capitalize(),
                  ),
                ],
              ),
            )).toList(),
            onChanged: (SupportedLocale? value) {
              setState(() {
                ref.read(localeProvider.notifier).changeLanguage(value ?? SupportedLocale.pt);
              });
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            gapH64,
            SvgPicture.asset(
              'images/main/logo_medica.svg',
              width: Sizes.s140.w,
              height: Sizes.s140.h
            ),
            gapH27,
            MyText(type: TextTypes.h3, text: context.loc.loginToYourAccount.capitalize()),
            gapH27,
            Form(
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
                    onPressed: state.isLoading ? null : () async {
                      setState(() {});
                      if (_formKey.currentState!.validate()){
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
            ),
            gapH20,
            GestureDetector(
              onTap: (){
                context.pushNamed(AppRoute.forgotPassword.name);
              },
              child: MyText(type: TextTypes.bodyLarge,fontWeight: FontWeights.semiBold, text: context.loc.forgotPassword.capitalize(),color: MainColors.primary)
            ),
            gapH99,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyText(type: TextTypes.bodyMedium, text: context.loc.dontHaveAnAccount.capitalize(),color: GreyScaleColors.grey500),
                gapW4,
                GestureDetector(
                  onTap: (){
                    context.pushNamed(AppRoute.register.name);
                  },
                  child: MyText(type: TextTypes.bodyMedium,fontWeight: FontWeights.semiBold, text: context.loc.signUp.capitalize(),color: MainColors.primary)
                ),
              ],
            ),
            gapH48,
          ],
        ),
      ),
    );
  }
}