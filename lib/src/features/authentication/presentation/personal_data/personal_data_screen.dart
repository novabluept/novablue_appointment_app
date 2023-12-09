
import 'dart:io';
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
import 'package:novablue_appointment_app/src/features/authentication/presentation/personal_data/personal_data_screen_controller.dart';
import 'package:novablue_appointment_app/src/localization/app_localizations_context.dart';
import 'package:novablue_appointment_app/src/utils/dialogs.dart';
import 'package:novablue_appointment_app/src/utils/formatters.dart';
import '../../../../common_widgets/my_button.dart';
import '../../../../common_widgets/my_text_form_field.dart';
import '../../../../constants/app_colors.dart';
import '../../../../routing/app_routing.dart';
import '../../../../utils/validations.dart';
import '../create_password/create_password_screen.dart';

class PersonalDataScreen extends ConsumerStatefulWidget {
  const PersonalDataScreen({super.key});

  @override
  _PersonalDataScreenState createState() => _PersonalDataScreenState();
}

class _PersonalDataScreenState extends ConsumerState<PersonalDataScreen> {

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

  String get firstname => _firstnameController.text;
  String get lastname => _lastnameController.text;
  String get email => _emailController.text;
  String get phone => _phoneController.text;

  List<CountryCode> items = [PhoneCountryCode.pt,PhoneCountryCode.es,PhoneCountryCode.fr];
  CountryCode phoneCode = PhoneCountryCode.pt;

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
    ref.listen<AsyncValue<File?>>(
      personalDataScreenControllerProvider,
          (_, state) => state.showDialogError(context: context),
    );
    final state = ref.watch(personalDataScreenControllerProvider);
    return MyScaffold(
      state: state,
      appBar: MyAppBar(
        title: context.loc.fillYourProfile.capitalize(),
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
            gapH24,
            MyAvatar(
              file: state.hasValue ? state.value : null, /// TODO: Arranjar forma de tirar este .hasValue. Vai passar por dedicar um provider para a funcao e outro para o valor obtido
              onTap: ()async{
                await ref.read(personalDataScreenControllerProvider.notifier).chooseProfilePicture();
              },
            ),
            gapH24,
            Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  MyTextFormField(
                    textEditingController: _firstnameController,
                    text: context.loc.firstname.capitalize(),
                    errorText: context.loc.firstnameValidation.capitalize(),
                    prefixIcon: IconlyBold.profile,
                    fieldHasError: _firstnameHasError,
                    isFieldFocused: _isFirstnameFocused,
                    onFocusChange: (value) {
                      setState(() {_isFirstnameFocused = value;});
                    },
                    validator: (value){
                      if(value == null || value.isEmpty || !Validations.hasMinimumAndMaxCharacters(value)){
                        _firstnameHasError = true;
                        return '';
                      }
                      _firstnameHasError = false;
                      return null;
                    }
                  ),
                  gapH24,
                  MyTextFormField(
                    textEditingController: _lastnameController,
                    text: context.loc.lastname.capitalize(),
                    errorText: context.loc.lastnameValidation.capitalize(),
                    prefixIcon: IconlyBold.profile,
                    fieldHasError: _lastnameHasError,
                    isFieldFocused: _isLastnameFocused,
                    onFocusChange: (value) {
                      setState(() {_isLastnameFocused = value;});
                    },
                    validator: (value){
                      if(value == null || value.isEmpty || !Validations.hasMinimumAndMaxCharacters(value)){
                        _lastnameHasError = true;
                        return '';
                      }
                      _lastnameHasError = false;
                      return null;
                    }
                  ),
                  gapH24,
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
                  gapH24,
                  MyTextFormField(
                    textEditingController: _phoneController,
                    text: context.loc.phone.capitalize(),
                    errorText: context.loc.phoneValidation.capitalize(),
                    prefixWidget: MyDropdownButton(
                      items: items,
                      value: phoneCode,
                      icon: Icon(IconlyBold.arrow_down_2,size: Sizes.s12.w,color: GreyScaleColors.grey500),
                      dropDownMenuItem: items.map((item) {
                        return DropdownMenuItem(
                          alignment: Alignment.center,
                          value: item,
                          child: SvgPicture.asset(item.imagePath,width: Sizes.s24.w,height: Sizes.s18.h),
                        );
                      }).toList(),
                      onChanged: (value){
                        setState(() {
                          phoneCode = value!;
                        });
                      },
                    ),
                    fieldHasError: _phoneHasError,
                    isFieldFocused: _isPhoneFocused,
                    onFocusChange: (value) {
                      setState(() {_isPhoneFocused = value;});
                    },
                    validator: (value){
                      if(value == null || value.isEmpty || !Validations.isPhoneValid(value, phoneCode.code)){
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
                    text: context.loc.next.capitalize(),
                    onPressed: state.isLoading ? null : ()async{
                      setState(() {});
                      if (_formKey.currentState!.validate()){
                        context.pushNamed(
                          AppRoute.createPassword.name,
                          extra: CreatePasswordScreenArguments(
                            filePath: state.value?.path ?? '',
                            firstname: firstname.capitalize().trim(),
                            lastname: lastname.capitalize().trim(),
                            email: email.trim(),
                            phone: phone.capitalize().trim(),
                            phoneCode: phoneCode.code,
                          )
                        );
                      }
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