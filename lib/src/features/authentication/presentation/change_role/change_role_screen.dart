
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';
import 'package:novablue_appointment_app/src/common_widgets/my_app_bar.dart';
import 'package:novablue_appointment_app/src/common_widgets/my_scaffold.dart';
import 'package:novablue_appointment_app/src/constants/app_colors.dart';
import 'package:novablue_appointment_app/src/constants/app_sizes.dart';
import 'package:novablue_appointment_app/src/features/authentication/presentation/change_role/roles_grid.dart';
import 'package:novablue_appointment_app/src/utils/dialogs.dart';
import 'change_role_screen_controller.dart';

class ChangeRoleScreen extends ConsumerStatefulWidget {

  const ChangeRoleScreen({super.key});

  @override
  _ChangeRoleScreenState createState() => _ChangeRoleScreenState();
}

class _ChangeRoleScreenState extends ConsumerState<ChangeRoleScreen> {

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<void>>(
      changeRoleScreenControllerProvider,
        (_, state) => state.showDialogError(context: context),
    );
    return MyScaffold(
      appBar: MyAppBar(
        title: 'Mudar cargo',
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
      body: RolesGrid()
    );
  }
}


