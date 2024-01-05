
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:novablue_appointment_app/src/common_widgets/my_app_bar.dart';
import 'package:novablue_appointment_app/src/common_widgets/my_scaffold.dart';
import 'package:novablue_appointment_app/src/common_widgets/my_text.dart';
import 'package:novablue_appointment_app/src/constants/app_colors.dart';
import 'package:novablue_appointment_app/src/constants/app_sizes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:novablue_appointment_app/src/exceptions/app_exceptions.dart';
import 'package:novablue_appointment_app/src/features/authentication/presentation/login/login_form.dart';
import 'package:novablue_appointment_app/src/features/authentication/presentation/login/login_screen_controller.dart';
import 'package:novablue_appointment_app/src/localization/app_localizations_context.dart';
import 'package:novablue_appointment_app/src/routing/app_routing.dart';
import 'package:novablue_appointment_app/src/utils/dialogs.dart';
import 'package:novablue_appointment_app/src/utils/formatters.dart';
import 'change_language_dropdown.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<void>>(
      loginScreenControllerProvider,
      (_, state) {
        final error = state.error is AppException ? state.error as AppException : null;
        if(error != null && error.code == AppExceptionTypes.emailNotConfirmed.name){
          return;
        }else{
          state.showDialogError(context: context);
        }

      },
    );
    final state = ref.watch(loginScreenControllerProvider);
    return MyScaffold(
      state: state,
      appBar: MyAppBar(
        actions: [
          Padding(
            padding: EdgeInsets.only(right: Sizes.s24.w),
            child: ChangeLanguageDropdown()
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            gapH64,
            SvgPicture.asset(
              'images/logos/medica_icon.svg',
              width: Sizes.s140.w,
              height: Sizes.s140.h
            ),
            gapH27,
            MyText(type: TextTypes.h3, text: context.loc.loginToYourAccount.capitalize()),
            gapH27,
            LoginForm(state: state),
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