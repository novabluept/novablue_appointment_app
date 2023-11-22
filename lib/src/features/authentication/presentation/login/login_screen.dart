
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:novablue_appointment_app/src/common_widgets/my_button.dart';
import 'package:novablue_appointment_app/src/common_widgets/my_scaffold.dart';
import 'package:novablue_appointment_app/src/common_widgets/my_text.dart';
import 'package:novablue_appointment_app/src/constants/app_colors.dart';
import 'package:novablue_appointment_app/src/constants/app_sizes.dart';
import 'package:novablue_appointment_app/src/features/authentication/data/auth_repository.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:novablue_appointment_app/src/utils/formatters.dart';
import '../../../../../main.dart';
import '../../../../common_widgets/my_app_bar.dart';
import '../../../../common_widgets/my_dropdown_button.dart';
import '../../../../common_widgets/my_text_form_field.dart';
import 'package:iconly/iconly.dart';
import '../../../../languages/languages.dart';
import '../../../../languages/languages_constants.dart';
import '../../../../routing/app_routing.dart';
import '../../../../utils/validations.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginScreen> {

  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _emailHasError = false;
  final _passwordHasError = false;

  bool _isEmailFocused = false;
  bool _isPasswordFocused = false;

  bool _isPasswordObscure = true;

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
    return MyScaffold(
      appBar: MyAppBar(
        actions: [
          MyDropdownButton(
            items: Language.languageList(),
            icon: Icons.language_rounded,
            dropDownMenuItem: Language.languageList().map<DropdownMenuItem<Language>>((e) => DropdownMenuItem<Language>(
                value: e,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SvgPicture.asset(e.imagePath,width: Sizes.s24.w,height: Sizes.s18.h),
                    gapW4,
                    MyText(
                      type: TextTypes.bodyMedium,
                      fontWeight: FontWeights.semiBold,
                      text: e.languageCode == 'pt' ? translation(context).portuguese.capitalize() : translation(context).english.capitalize(),
                    ),
                  ],
                ),
              ),
            ).toList(),
            onChanged: (Language? language) async{
              if (language != null) {
                Locale _locale = await setLocale(language.languageCode);
                MyApp.setLocale(context, _locale);
              }
            },
          ),
        ]
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
            MyText(type: TextTypes.h3, text: translation(context).loginToYourAccount.capitalize()),
            gapH27,
            Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  MyTextFormField(
                    textEditingController: _emailController,
                    text: translation(context).email.capitalize(),
                    errorText: translation(context).emailValidation.capitalize(),
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
                    text: translation(context).password.capitalize(),
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
                    text: translation(context).login.capitalize(),
                    onPressed: (){
                      setState(() {});
                      if (_formKey.currentState!.validate()){
                        ref.read(authRepositoryProvider).signInWithEmailAndPassword('email', '');
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
              child: MyText(type: TextTypes.bodyLarge,fontWeight: FontWeights.semiBold, text: translation(context).forgotPassword.capitalize(),color: MainColors.primary)
            ),
            gapH99,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyText(type: TextTypes.bodyMedium, text: translation(context).dontHaveAnAccount.capitalize(),color: GreyScaleColors.grey500),
                gapW4,
                GestureDetector(
                  onTap: (){
                    context.pushNamed(AppRoute.register.name);
                  },
                  child: MyText(type: TextTypes.bodyMedium,fontWeight: FontWeights.semiBold, text: translation(context).signUp.capitalize(),color: MainColors.primary)
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