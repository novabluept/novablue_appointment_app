
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';
import 'package:novablue_appointment_app/src/common_widgets/my_app_bar.dart';
import 'package:novablue_appointment_app/src/common_widgets/my_scaffold.dart';
import 'package:novablue_appointment_app/src/constants/app_sizes.dart';
import 'package:novablue_appointment_app/src/languages/languages_constants.dart';
import 'package:novablue_appointment_app/src/utils/formatters.dart';
import '../../../../common_widgets/my_button.dart';
import '../../../../common_widgets/my_text.dart';
import '../../../../common_widgets/my_text_form_field.dart';
import '../../../../constants/app_colors.dart';

class CreatePasswordScreen extends ConsumerStatefulWidget {
  const CreatePasswordScreen({super.key});

  @override
  _CreatePasswordScreenState createState() => _CreatePasswordScreenState();
}

class _CreatePasswordScreenState extends ConsumerState<CreatePasswordScreen> {

  final _formKey = GlobalKey<FormState>();

  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _passwordHasError = false;
  bool _confirmPasswordHasError = false;

  bool _isPasswordFocused = false;
  bool _isConfirmPasswordFocused = false;

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
        title: translation(context).createPassword.capitalize(),
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
              'images/app_info_blue/create_password_image.svg',
              width: Sizes.s329.w,
              height: Sizes.s250.h
            ),
            gapH71,
            Align(
              alignment: Alignment.centerLeft,
              child: MyText(type: TextTypes.bodyLarge,fontWeight: FontWeights.medium, text: translation(context).createYourNewPassword.capitalize())
            ),
            gapH24,
            Form(
              child: Column(
                children: [
                  MyTextFormField(
                    textEditingController: _passwordController,
                    text: translation(context).password.capitalize(),
                    errorText: translation(context).passwordValidation.capitalize(),
                    prefixIcon: IconlyBold.message,
                    fieldHasError: _passwordHasError,
                    isFieldFocused: _isPasswordFocused,
                    onFocusChange: (value) {
                      setState(() {_isPasswordFocused = value;});
                    },
                    validator: (value){

                      return null;
                    }
                  ),
                  gapH24,
                  MyTextFormField(
                    textEditingController: _confirmPasswordController,
                    text: translation(context).confirmPassword.capitalize(),
                    errorText: translation(context).confirmPasswordValidation.capitalize(),
                    prefixIcon: IconlyBold.message,
                    fieldHasError: _confirmPasswordHasError,
                    isFieldFocused: _isConfirmPasswordFocused,
                    onFocusChange: (value) {
                      setState(() {_isConfirmPasswordFocused = value;});
                    },
                    validator: (value){
                      return null;
                    }
                  ),
                  gapH24,
                  MyButton(
                    type: ButtonTypes.filledFullyRounded,
                    text: translation(context).signUp.capitalize(),
                    onPressed: (){
                      setState(() {});
                      if (_formKey.currentState!.validate()){}
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