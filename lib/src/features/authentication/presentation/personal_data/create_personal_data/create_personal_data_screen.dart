
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';
import 'package:novablue_appointment_app/src/common_widgets/my_app_bar.dart';
import 'package:novablue_appointment_app/src/common_widgets/my_avatar.dart';
import 'package:novablue_appointment_app/src/common_widgets/my_scaffold.dart';
import 'package:novablue_appointment_app/src/constants/app_colors.dart';
import 'package:novablue_appointment_app/src/constants/app_sizes.dart';
import 'package:novablue_appointment_app/src/features/authentication/presentation/personal_data/create_personal_data/create_personal_data_form.dart';
import 'package:novablue_appointment_app/src/localization/app_localizations_context.dart';
import 'package:novablue_appointment_app/src/utils/dialogs.dart';
import 'package:novablue_appointment_app/src/utils/formatters.dart';
import 'create_personal_data_screen_controller.dart';

class CreatePersonalDataScreen extends ConsumerStatefulWidget {
  const CreatePersonalDataScreen({super.key});

  @override
  _CreatePersonalDataScreenState createState() => _CreatePersonalDataScreenState();
}

class _CreatePersonalDataScreenState extends ConsumerState<CreatePersonalDataScreen> {

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<File?>>(
      createPersonalDataScreenControllerProvider,
          (_, state) => state.showDialogError(context: context),
    );
    final state = ref.watch(createPersonalDataScreenControllerProvider);
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
              onTap: () async {
                await ref.read(createPersonalDataScreenControllerProvider.notifier).chooseProfilePicture();
              },
            ),
            gapH24,
            CreatePersonalDataForm(state: state)
          ],
        ),
      ),
    );
  }
}