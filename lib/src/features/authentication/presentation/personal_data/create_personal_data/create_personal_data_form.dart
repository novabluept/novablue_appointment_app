
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';
import 'package:novablue_appointment_app/src/common_widgets/my_button.dart';
import 'package:novablue_appointment_app/src/common_widgets/my_phone_dropdown_button.dart';
import 'package:novablue_appointment_app/src/common_widgets/my_text_form_field.dart';
import 'package:novablue_appointment_app/src/constants/app_sizes.dart';
import 'package:novablue_appointment_app/src/features/authentication/presentation/password/create_password/create_password_screen.dart';
import 'package:novablue_appointment_app/src/localization/app_localizations_context.dart';
import 'package:novablue_appointment_app/src/routing/app_routing.dart';
import 'package:novablue_appointment_app/src/utils/formatters.dart';
import 'package:novablue_appointment_app/src/utils/validations.dart';

class CreatePersonalDataForm extends ConsumerStatefulWidget {

  final AsyncValue<File?> state;

  const CreatePersonalDataForm({super.key,required this.state});

  @override
  _CreatePersonalDataFormState createState() => _CreatePersonalDataFormState();
}

class _CreatePersonalDataFormState extends ConsumerState<CreatePersonalDataForm> {

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

  CountryCode _phoneCode = PhoneCountryCode.pt;

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
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
                prefixWidget: MyPhoneDropdownButton(
                  value: _phoneCode,
                  valueTextIcon: _phoneCode.icon,
                  onTapPt: () {
                    setState(() {
                      _phoneCode = PhoneCountryCode.pt;
                    });
                  },
                  onTapEs: () {
                    setState(() {
                      _phoneCode = PhoneCountryCode.es;
                    });
                  },
                  onTapFr: () {
                    setState(() {
                      _phoneCode = PhoneCountryCode.fr;
                    });
                  },
                ),
                fieldHasError: _phoneHasError,
                isFieldFocused: _isPhoneFocused,
                onFocusChange: (value) {
                  setState(() {_isPhoneFocused = value;});
                },
                validator: (value){
                  if(value == null || value.isEmpty || !Validations.isPhoneValid(value, _phoneCode.code)){
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
                onPressed: widget.state.isLoading ? null : () async {
                  setState(() {});
                  if (_formKey.currentState!.validate()){
                    context.pushNamed(
                      AppRoute.createPassword.name,
                      extra: CreatePasswordScreenArguments(
                        filePath: widget.state.value?.path ?? '',
                        firstname: firstname.capitalize().trim(),
                        lastname: lastname.capitalize().trim(),
                        email: email.trim(),
                        phone: phone.capitalize().trim(),
                        phoneCode: _phoneCode.code,
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
    );
  }
}
