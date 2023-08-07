import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';

import '../constant/strings.dart';

customDialog(
    {required BuildContext context,
    required DialogType dialogType,
    required String title,
    required String description,
    void Function()? onTapOK}) {
  return AwesomeDialog(
    context: context,
    dialogType: dialogType,
    animType: AnimType.rightSlide,
    title: title,
    desc: description,
    btnOkOnPress: onTapOK,
    btnOkText: AppStrings.ok,
    btnCancelText: AppStrings.cancel,
  )..show();
}
