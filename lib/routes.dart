import 'package:get/get.dart';

import 'core/constant/routes.dart';
import 'core/middleware/middleware.dart';
import 'view/screen/Auth/forget_password/forget_email.dart';
import 'view/screen/Auth/login/login.dart';
import 'view/screen/Auth/user_info/user_info.dart';
import 'view/screen/home/home.dart';
import 'view/screen/management services/management_services_main.dart';
import 'view/screen/management services/request_history.dart';
import 'view/screen/management services/request_vacation.dart';
import 'view/screen/notification_screen/notification_screen.dart';
import 'view/screen/send_notification/send_notifications.dart';
import 'view/screen/settings/change_email.dart';
import 'view/screen/settings/change_password.dart';
import 'view/screen/settings/change_phone.dart';
import 'view/screen/settings/change_user_name.dart';
import 'view/screen/settings/settings.dart';
import 'view/screen/task/add_task/add_task.dart';
import 'view/screen/task/edit_task/edit_task.dart';
import 'view/screen/task/view_filter_task/filtered_task.dart';
import 'view/screen/users/add_user.dart';

List<GetPage<dynamic>>? routes = [
  // GetPage(name: '/', page: () => const HomeScreen()),
  GetPage(name: "/", page: () => const Login(), middlewares: [
    MyMiddleWare(),
  ]),
  GetPage(
      name: AppRoutes.notificationScreen,
      page: () => const NotificationScreen()),
  GetPage(name: AppRoutes.login, page: () => const Login()),
  GetPage(name: AppRoutes.home, page: () => const HomeScreen()),
  GetPage(name: AppRoutes.addTask, page: () => const AddTask()),
  GetPage(name: AppRoutes.filteredTask, page: () => const FilteredTask()),
  GetPage(name: AppRoutes.userInfo, page: () => const UserInfo()),
  GetPage(name: AppRoutes.addUser, page: () => const AddUser()),
  GetPage(name: AppRoutes.editTask, page: () => const EditTask()),
  GetPage(name: AppRoutes.settings, page: () => const UserSettings()),
  GetPage(name: AppRoutes.forgetPassword, page: () => const ForgetPassword()),
  GetPage(name: AppRoutes.changeEmail, page: () => const ChangeEmail()),
  GetPage(name: AppRoutes.changeUserName, page: () => const ChangeUserName()),
  GetPage(name: AppRoutes.changeUserPhone, page: () => const ChangeUserPhone()),
  GetPage(
      name: AppRoutes.changeUserPassword, page: () => const ChangePassword()),
  GetPage(
      name: AppRoutes.sendNotifications, page: () => const SendNotifications()),
  GetPage(
      name: AppRoutes.managementServicesMain,
      page: () => const ManagementServicesMain()),
  GetPage(name: AppRoutes.requestVacation, page: () => const RequestVacation()),
  GetPage(name: AppRoutes.requestHistory, page: () => const RequestHistory()),
];
