
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';
import 'package:novablue_appointment_app/src/common_widgets/my_app_bar.dart';
import 'package:novablue_appointment_app/src/common_widgets/my_scaffold.dart';
import 'package:novablue_appointment_app/src/common_widgets/my_svg.dart';
import 'package:novablue_appointment_app/src/common_widgets/my_text.dart';
import 'package:novablue_appointment_app/src/constants/app_colors.dart';
import 'package:novablue_appointment_app/src/constants/app_sizes.dart';
import 'package:novablue_appointment_app/src/features/authentication/presentation/password/forgot_password/forgot_password_form.dart';
import 'package:novablue_appointment_app/src/localization/app_localizations_context.dart';
import 'package:novablue_appointment_app/src/utils/dialogs.dart';
import 'package:novablue_appointment_app/src/utils/formatters.dart';
import 'forgot_password_screen_controller.dart';

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<void>>(
      forgotPasswordScreenControllerProvider,
          (_, state) => state.showDialogError(context: context),
    );
    final state = ref.watch(forgotPasswordScreenControllerProvider);
    return MyScaffold(
      state: state,
      appBar: MyAppBar(
        title: context.loc.recoverPassword.capitalize(),
        leading: IconButton(
          icon: Icon(IconlyLight.arrow_left, size: Sizes.s20.w, color: OtherColors.black),
          onPressed: (){
            context.pop();
          },
        )
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            gapH71,
            MySvg(
              colorFilter: MainColors.primary,
              imagePath: 'images/undraw/forgot_password_image.svg',
              width: Sizes.s276.w,
              height: Sizes.s250.h,
            ),
            gapH24,
            Align(
              alignment: Alignment.centerLeft,
              child: MyText(type: TextTypes.bodyLarge,fontWeight: FontWeights.medium, text: context.loc.emailRecoverMessage.capitalize())
            ),
            gapH24,
            ForgotPasswordForm(state: state)
          ],
        ),
      ),
    );
  }
}