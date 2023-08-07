import 'package:get/get.dart';

import 'core/constant/routes.dart';
import 'core/middleware/middleware.dart';
import 'view/screen/Auth/login/login.dart';
import 'view/screen/Auth/user_info.dart';
import 'view/screen/home/home.dart';
import 'view/screen/notification_screen/notification_screen.dart';
import 'view/screen/task/add_task/add_task.dart';
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
];
