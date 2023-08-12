import '../../model/user_level_model.dart';

List<UserLevelModel> userLevelList = [
  UserLevelModel(value: "0", title: "موظف", description: 'رؤية الملاحظات فقط'),
  UserLevelModel(
      value: "1",
      title: "ادمن",
      description: 'إضافة الملاحظات وتعديلها وإرسال الاشعارات'),
  UserLevelModel(
      value: "2",
      title: "سوبر ادمن",
      description: 'إضافة المستخدمين والملاحظات وإدارة الموظفين'),
];
