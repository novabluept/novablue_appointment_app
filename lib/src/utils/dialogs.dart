
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:novablue_appointment_app/src/common_widgets/my_dialog.dart';
import 'package:novablue_appointment_app/src/constants/app_colors.dart';


extension AsyncValueUI on AsyncValue {
  void showDialogError({required BuildContext context}) {
    if (!isLoading && hasError) {
      showAlertDialog(
        context: context,
        type: DialogTypes.error,
        label: error.toString(),
        positiveButtonOnPressed: () {
          context.pop();
        }
      );
    }
  }
}

extension bottomModal on BuildContext {
  void showBottomModal({required BuildContext context,required Widget content,Function()? action}) async{
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useRootNavigator: true,
      enableDrag: false,
      isDismissible: false,
      backgroundColor: OtherColors.transparent,
      elevation: 0,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async{
            return false;
          },
          child: content
        );
      }
    ).whenComplete(() => action);
  }
}
