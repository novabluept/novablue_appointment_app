
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';
import 'package:novablue_appointment_app/src/common_widgets/my_app_bar.dart';
import 'package:novablue_appointment_app/src/common_widgets/my_scaffold.dart';
import 'package:novablue_appointment_app/src/constants/app_colors.dart';
import 'package:novablue_appointment_app/src/constants/app_sizes.dart';
import 'package:novablue_appointment_app/src/features/authentication/presentation/password/update_password/update_password_form.dart';
import 'package:novablue_appointment_app/src/features/authentication/presentation/password/update_password/update_password_screen_controller.dart';
import 'package:novablue_appointment_app/src/localization/app_localizations_context.dart';
import 'package:novablue_appointment_app/src/utils/dialogs.dart';
import 'package:novablue_appointment_app/src/utils/formatters.dart';

class UpdatePasswordScreen extends ConsumerStatefulWidget {

  const UpdatePasswordScreen({super.key});

  @override
  _UpdatePasswordScreenState createState() => _UpdatePasswordScreenState();
}

class _UpdatePasswordScreenState extends ConsumerState<UpdatePasswordScreen>{

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<void>>(
      updatePasswordScreenControllerProvider,
          (_, state) => state.showDialogError(context: context),
    );
    final state = ref.watch(updatePasswordScreenControllerProvider);
    return MyScaffold(
      state: state,
      appBar: MyAppBar(
        title: context.loc.changePassword.capitalize(),
        leading: Transform.translate(
          offset: Offset(-Sizes.s16.w, Sizes.s0),
          child: GestureDetector(
            onTap: () async {
              context.pop();
            },
            child: Icon(IconlyLight.arrow_left, size: Sizes.s20.w, color: OtherColors.black)
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            gapH24,
            UpdatePasswordForm(state: state)
          ],
        ),
      ),
    );
  }
}