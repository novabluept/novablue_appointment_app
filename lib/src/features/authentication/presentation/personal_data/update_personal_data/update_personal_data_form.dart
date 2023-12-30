
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';
import 'package:novablue_appointment_app/src/common_widgets/my_button.dart';
import 'package:novablue_appointment_app/src/common_widgets/my_phone_dropdown_button.dart';
import 'package:novablue_appointment_app/src/common_widgets/my_text_form_field.dart';
import 'package:novablue_appointment_app/src/constants/app_sizes.dart';
import 'package:novablue_appointment_app/src/features/authentication/data/auth_repository.dart';
import 'package:novablue_appointment_app/src/features/authentication/presentation/personal_data/update_personal_data/update_personal_data_screen_controller.dart';
import 'package:novablue_appointment_app/src/localization/app_localizations_context.dart';
import 'package:novablue_appointment_app/src/utils/formatters.dart';
import 'package:novablue_appointment_app/src/utils/validations.dart';

class UpdatePersonalDataForm extends ConsumerStatefulWidget {
  const UpdatePersonalDataForm({super.key});

  @override
  _UpdatePersonalDataFormState createState() => _UpdatePersonalDataFormState();
}

class _UpdatePersonalDataFormState extends ConsumerState<UpdatePersonalDataForm> {

  final _formKey = GlobalKey<FormState>();

  final _firstnameController = TextEditingController();
  final _lastnameController = TextEditingController();
  final _phoneController = TextEditingController();

  bool _firstnameHasError = false;
  bool _lastnameHasError = false;
  bool _phoneHasError = false;

  bool _isFirstnameFocused = false;
  bool _isLastnameFocused = false;
  bool _isPhoneFocused = false;

  String get firstname => _firstnameController.text;
  String get lastname => _lastnameController.text;
  String get phone => _phoneController.text;

  CountryCode _phoneCode = PhoneCountryCode.pt;

  @override
  void initState() {
    super.initState();
    ServicesBinding.instance.addPostFrameCallback((_) async{
      await _initializeData();
    });
  }

  @override
  void dispose() {
    _firstnameController.dispose();
    _lastnameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  _getPhoneCountryCode(String phoneCode){
    if(phoneCode == PhoneCountryCode.pt.code){
      return PhoneCountryCode.pt;
    }else if(phoneCode == PhoneCountryCode.es.code){
      return PhoneCountryCode.es;
    }else{
      return PhoneCountryCode.fr;
    }
  }

  Future<void> _initializeData() async{
    final id = ref.read(authRepositoryProvider).currentUser?.id;
    final userData = await ref.read(getUserDataProvider(id ?? '').future);

    if(mounted){
      setState(() {
        _firstnameController.text = userData.firstname;
        _lastnameController.text = userData.lastname;
        _phoneController.text = userData.phone;
        _phoneCode = _getPhoneCountryCode(userData.phoneCode);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final id = ref.read(authRepositoryProvider).currentUser?.id;
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
                gapH24,
                MyButton(
                  type: ButtonTypes.filledFullyRounded,
                  text: context.loc.next.capitalize(),
                  onPressed: () async {
                    setState(() {});
                    if (_formKey.currentState!.validate()){

                      Map<String,dynamic> updatedData = {
                        'first_name': firstname.capitalize().trim(),
                        'last_name': lastname.capitalize().trim(),
                        'phone': phone,
                        'phone_code': _phoneCode.code,
                        //'updated_at': DateTime.now(),
                      };
                      ref.read(updatePersonalDataScreenControllerProvider.notifier).updateUserData(
                        id: id ?? '',
                        updatedData: updatedData,
                        onSuccess: (){
                          context.pop();
                        }
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
