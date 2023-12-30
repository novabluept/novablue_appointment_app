
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconly/iconly.dart';
import 'package:novablue_appointment_app/src/common_widgets/my_app_bar.dart';
import 'package:novablue_appointment_app/src/common_widgets/my_scaffold.dart';
import 'package:novablue_appointment_app/src/common_widgets/my_svg.dart';
import 'package:novablue_appointment_app/src/common_widgets/my_text.dart';
import 'package:novablue_appointment_app/src/constants/app_colors.dart';
import 'package:novablue_appointment_app/src/constants/app_sizes.dart';
import 'package:novablue_appointment_app/src/features/authentication/presentation/password/password_recovery/password_recovery_form.dart';
import 'package:novablue_appointment_app/src/features/authentication/presentation/password/password_recovery/password_recovery_screen_controller.dart';
import 'package:novablue_appointment_app/src/localization/app_localizations_context.dart';
import 'package:novablue_appointment_app/src/utils/dialogs.dart';
import 'package:novablue_appointment_app/src/utils/formatters.dart';

class PasswordRecoveryScreen extends ConsumerStatefulWidget {

  const PasswordRecoveryScreen({super.key});

  @override
  _PasswordRecoveryScreenState createState() => _PasswordRecoveryScreenState();
}

class _PasswordRecoveryScreenState extends ConsumerState<PasswordRecoveryScreen>{

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<void>>(
      passwordRecoveryScreenControllerProvider,
          (_, state) => state.showDialogError(context: context),
    );
    final state = ref.watch(passwordRecoveryScreenControllerProvider);
    return MyScaffold(
      state: state,
      onPopInvoked: (value) async{
        await ref.read(passwordRecoveryScreenControllerProvider.notifier).signOut();
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
              imagePath: 'images/undraw/recover_password_image.svg',
              width: Sizes.s329.w,
              height: Sizes.s250.h
            ),
            gapH71,
            Align(
              alignment: Alignment.centerLeft,
              child: MyText(type: TextTypes.bodyLarge,fontWeight: FontWeights.medium, text: context.loc.createYourNewPassword.capitalize())
            ),
            gapH24,
            PasswordRecoveryForm(state: state)
          ],
        ),
      ),
    );
  }
}