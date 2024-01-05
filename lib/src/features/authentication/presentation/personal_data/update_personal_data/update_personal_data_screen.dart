
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';
import 'package:novablue_appointment_app/src/common_widgets/my_app_bar.dart';
import 'package:novablue_appointment_app/src/common_widgets/my_scaffold.dart';
import 'package:novablue_appointment_app/src/constants/app_colors.dart';
import 'package:novablue_appointment_app/src/constants/app_sizes.dart';
import 'package:novablue_appointment_app/src/features/authentication/presentation/personal_data/update_personal_data/update_personal_data_form.dart';
import 'package:novablue_appointment_app/src/utils/dialogs.dart';
import 'update_personal_data_screen_controller.dart';

class UpdatePersonalDataScreen extends ConsumerStatefulWidget {
  const UpdatePersonalDataScreen({super.key});

  @override
  _UpdatePersonalDataScreenState createState() => _UpdatePersonalDataScreenState();
}

class _UpdatePersonalDataScreenState extends ConsumerState<UpdatePersonalDataScreen> {

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<void>>(
      updatePersonalDataScreenControllerProvider,
          (_, state) => state.showDialogError(context: context),
    );
    final state = ref.watch(updatePersonalDataScreenControllerProvider);
    return MyScaffold(
      state: state,
      appBar: MyAppBar(
        title: 'Editar perfil',
        leading: IconButton(
          icon: Icon(IconlyLight.arrow_left, size: Sizes.s20.w, color: OtherColors.black),
          onPressed: (){
            context.pop();
          },
        )
      ),
      body: UpdatePersonalDataForm()
    );
  }
}