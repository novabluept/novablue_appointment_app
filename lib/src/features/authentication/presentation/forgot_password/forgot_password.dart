
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';
import 'package:novablue_appointment_app/src/common_widgets/my_app_bar.dart';
import 'package:novablue_appointment_app/src/common_widgets/my_scaffold.dart';
import 'package:novablue_appointment_app/src/constants/app_sizes.dart';
import 'package:novablue_appointment_app/src/localization/app_localizations_context.dart';
import 'package:novablue_appointment_app/src/utils/formatters.dart';
import '../../../../common_widgets/my_button.dart';
import '../../../../common_widgets/my_text.dart';
import '../../../../common_widgets/my_text_form_field.dart';
import '../../../../constants/app_colors.dart';


class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _emailHasError = false;
  bool _isEmailFocused = false;


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
    return MyScaffold(
      appBar: MyAppBar(
        title: context.loc.recoverPassword.capitalize(),
        leading: Transform.translate(
          offset: Offset(-Sizes.s16.w, 0),
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
            SvgPicture.asset(
                'images/app_info_blue/forgot_password_image.svg',
                width: Sizes.s276.w,
                height: Sizes.s250.h
            ),
            gapH24,
            Align(
                alignment: Alignment.centerLeft,
                child: MyText(type: TextTypes.bodyLarge,fontWeight: FontWeights.medium, text: context.loc.emailRecoverMessage.capitalize())
            ),
            gapH24,
            Form(
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

                        return null;
                      }
                  ),
                  gapH24,
                  MyButton(
                      type: ButtonTypes.filledFullyRounded,
                      text: context.loc.submit.capitalize(),
                      onPressed: (){
                        setState(() {});
                        if (_formKey.currentState!.validate()){}
                      }
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}