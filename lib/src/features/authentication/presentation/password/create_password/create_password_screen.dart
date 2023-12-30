
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
import 'package:novablue_appointment_app/src/features/authentication/presentation/password/create_password/create_password_form.dart';
import 'package:novablue_appointment_app/src/localization/app_localizations_context.dart';
import 'package:novablue_appointment_app/src/utils/dialogs.dart';
import 'package:novablue_appointment_app/src/utils/formatters.dart';
import 'create_password_screen_controller.dart';

class CreatePasswordScreenArguments {

  String filePath;
  String firstname;
  String lastname;
  String email;
  String phone;
  String phoneCode;

  CreatePasswordScreenArguments({
    required this.filePath,
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.phone,
    required this.phoneCode,
  });
}

class CreatePasswordScreen extends ConsumerStatefulWidget {

  final CreatePasswordScreenArguments args;

  const CreatePasswordScreen({super.key,required this.args});

  @override
  _CreatePasswordScreenState createState() => _CreatePasswordScreenState();
}

class _CreatePasswordScreenState extends ConsumerState<CreatePasswordScreen> {

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<void>>(
      createPasswordScreenControllerProvider,
          (_, state) => state.showDialogError(context: context),
    );
    final state = ref.watch(createPasswordScreenControllerProvider);
    return MyScaffold(
      state: state,
      appBar: MyAppBar(
        title: context.loc.createPassword.capitalize(),
        leading: Transform.translate(
          offset: Offset(-Sizes.s16.w, Sizes.s0),
          child: GestureDetector(
            onTap: (){
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
            gapH71,
            MySvg(
              colorFilter: MainColors.primary,
              imagePath: 'images/undraw/create_password_image.svg',
              width: Sizes.s329.w,
              height: Sizes.s250.h
            ),
            gapH71,
            Align(
              alignment: Alignment.centerLeft,
              child: MyText(type: TextTypes.bodyLarge,fontWeight: FontWeights.medium, text: context.loc.createYourNewPassword.capitalize())
            ),
            gapH24,
            CreatePasswordForm(state: state,args: widget.args)
          ],
        ),
      ),
    );
  }
}