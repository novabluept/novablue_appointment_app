import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:novablue_appointment_app/src/common_widgets/my_dialog.dart';

extension AsyncValueUI on AsyncValue {
  void showDialogError(BuildContext context) {
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
