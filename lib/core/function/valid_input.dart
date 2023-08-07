import 'package:get/get.dart';

validInput(String val, int min, int max, String type) {
  if (type == "userName") {
    if (!GetUtils.isUsername(val)) {
      return 'اسم المستخدم غير صحيح ';
    }
  }

  if (type == "email") {
    if (!GetUtils.isEmail(val)) {
      return 'بريد الكتروني غير صالح';
    }
  }

  if (val.isEmpty) {
    return 'لا يمكن ترك هذا الحقل فارغ';
  }
  if (val.length < min) {
    return 'لا يمكن ان يكون هذا الحقل اقل من  $min حروف ';
  }
  if (val.length > max) {
    return 'لا يمكن ان يكون هذا الحقل أكبر من $maxحروف ';
  }
}
