
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';
import 'package:novablue_appointment_app/src/common_widgets/my_button.dart';
import 'package:novablue_appointment_app/src/common_widgets/my_dialog.dart';
import 'package:novablue_appointment_app/src/common_widgets/my_text_form_field.dart';
import 'package:novablue_appointment_app/src/constants/app_sizes.dart';
import 'package:novablue_appointment_app/src/localization/app_localizations_context.dart';
import 'package:novablue_appointment_app/src/routing/app_routing.dart';
import 'package:novablue_appointment_app/src/utils/formatters.dart';
import 'package:novablue_appointment_app/src/utils/validations.dart';
import 'email_confirmation_screen_controller.dart';

class EmailConfirmationForm extends ConsumerStatefulWidget {

  final AsyncValue<void> state;

  const EmailConfirmationForm({super.key, required this.state});

  @override
  _EmailConfirmationFormState createState() => _EmailConfirmationFormState();
}

class _EmailConfirmationFormState extends ConsumerState<EmailConfirmationForm> {

  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();

  bool _emailHasError = false;

  bool _isEmailFocused = false;

  String get email => _emailController.text;


  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
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
              if(value == null || value.isEmpty || !Validations.isEmailValid(value)){
                _emailHasError = true;
                return '';
              }
              _emailHasError = false;
              return null;
            }
          ),
          gapH24,
          MyButton(
            type: ButtonTypes.filledFullyRounded,
            text: context.loc.submit.capitalize(),
            onPressed: widget.state.isLoading ? null : () async {
              setState(() {});
              if (_formKey.currentState!.validate()){
                await ref.read(emailConfirmationScreenControllerProvider.notifier).resend(
                  email: email,
                  onSuccess: () async {
                    await showAlertDialog(
                        context: context,
                        type: DialogTypes.success,
                        label: context.loc.emailConfirmationSuccess,
                        positiveButtonOnPressed: () {
                          context.goNamed(AppRoute.login.name);
                        }
                    );
                  }
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
