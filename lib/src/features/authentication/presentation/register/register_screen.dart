
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';
import 'package:novablue_appointment_app/src/common_widgets/my_app_bar.dart';
import 'package:novablue_appointment_app/src/common_widgets/my_avatar.dart';
import 'package:novablue_appointment_app/src/common_widgets/my_dropdown_button.dart';
import 'package:novablue_appointment_app/src/common_widgets/my_scaffold.dart';
import 'package:novablue_appointment_app/src/constants/app_sizes.dart';
import 'package:novablue_appointment_app/src/languages/languages_constants.dart';
import 'package:novablue_appointment_app/src/utils/formatters.dart';
import '../../../../common_widgets/my_button.dart';
import '../../../../common_widgets/my_text_form_field.dart';
import '../../../../constants/app_colors.dart';
import '../../../../routing/app_routing.dart';
import '../../../../utils/validations.dart';


class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {

  final _formKey = GlobalKey<FormState>();

  final _firstnameController = TextEditingController();
  final _lastnameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  bool _firstnameHasError = false;
  bool _lastnameHasError = false;
  bool _emailHasError = false;
  bool _phoneHasError = false;

  bool _isFirstnameFocused = false;
  bool _isLastnameFocused = false;
  bool _isEmailFocused = false;
  bool _isPhoneFocused = false;

  List<CountryCode> items = [PhoneCountryCode.pt,PhoneCountryCode.es,PhoneCountryCode.fr];
  CountryCode selectedValue = PhoneCountryCode.pt;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _firstnameController.dispose();
    _lastnameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      appBar: MyAppBar(
        title: translation(context).fillYourProfile.capitalize(),
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
            gapH24,
            const MyAvatar(),
            gapH24,
            Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  MyTextFormField(
                    textEditingController: _firstnameController,
                    text: translation(context).firstname.capitalize(),
                    errorText: translation(context).firstnameValidation.capitalize(),
                    prefixIcon: IconlyBold.profile,
                    fieldHasError: _firstnameHasError,
                    isFieldFocused: _isFirstnameFocused,
                    onFocusChange: (value) {
                      setState(() {_isFirstnameFocused = value;});
                    },
                    validator: (value){

                      return null;
                    }
                  ),
                  gapH24,
                  MyTextFormField(
                    textEditingController: _lastnameController,
                    text: translation(context).lastname.capitalize(),
                    errorText: translation(context).lastnameValidation.capitalize(),
                    prefixIcon: IconlyBold.profile,
                    fieldHasError: _lastnameHasError,
                    isFieldFocused: _isLastnameFocused,
                    onFocusChange: (value) {
                      setState(() {_isLastnameFocused = value;});
                    },
                    validator: (value){

                      return null;
                    }
                  ),
                  gapH24,
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

                      return null;
                    }
                  ),
                  gapH24,
                  MyTextFormField(
                    textEditingController: _phoneController,
                    text: translation(context).phone.capitalize(),
                    errorText: translation(context).phoneValidation.capitalize(),
                    prefixWidget: MyDropdownButton(
                      items: items,
                      value: selectedValue,
                      dropDownMenuItem: items.map((item) {
                        return DropdownMenuItem(
                          alignment: Alignment.center,
                          value: item,
                          child: SvgPicture.asset(item.imagePath,width: Sizes.s24.w,height: Sizes.s18.h),
                        );
                      }).toList(),
                      onChanged: (value){
                        setState(() {
                          selectedValue = value!;
                        });
                      },
                    ),
                    fieldHasError: _phoneHasError,
                    isFieldFocused: _isPhoneFocused,
                    onFocusChange: (value) {
                      setState(() {_isPhoneFocused = value;});
                    },
                    validator: (value){
                      if(value == null || value.isEmpty || !Validations.isPhoneValid(value, selectedValue.code)){
                        _phoneHasError = true;
                        return '';
                      }
                      _phoneHasError = false;
                      return null;
                    }
                  ),
                  gapH80,
                  MyButton(
                    type: ButtonTypes.filledFullyRounded,
                    text: translation(context).next.capitalize(),
                    onPressed: (){
                      context.pushNamed(AppRoute.createPassword.name);
                    }
                  ),
                  gapH48,
                ],
              )
            ),
          ],
        ),
      ),
    );
  }
}