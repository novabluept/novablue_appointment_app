import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:novablue_appointment_app/src/common_widgets/my_button.dart';
import 'package:novablue_appointment_app/src/common_widgets/my_text.dart';
import 'package:novablue_appointment_app/src/constants/app_sizes.dart';
import 'package:novablue_appointment_app/src/features/authentication/data/auth_repository.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../common_widgets/my_text_form_field.dart';


class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black45,
        padding: EdgeInsets.all(Sizes.s24.w),
        child: Center(
          child: Column(
            children: [
              gapH8,
              const MyText(type: TextTypes.bodyMedium, text: 'Olá meus amigos'),
              MyButton(
                type: ButtonTypes.filledFullyRounded,
                text: 'Login',
                onPressed: (){
                  ref.read(authRepositoryProvider).signInWithEmailAndPassword('email', '');
                }
              ),
              gapH8,
              MyTextFormField(
                text: 'Ola',
                hasError: true,
                isFieldFocused: false,
                validator: (value){
                  return null;
                },
              ),
              SvgPicture.asset(
                'images/main/logo_medica.svg',
                semanticsLabel: 'A red up arrow'
              )
            ],
          ),
        )
      ),
    );
  }
}