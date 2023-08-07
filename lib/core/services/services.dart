import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../firebase_options.dart';
import '../constant/strings.dart';
import '../function/fcm.dart';

class MyServices extends GetxService {
  late User user;
  late SharedPreferences sharedPref;
  late FirebaseAuth firebaseAuth;
  late FirebaseFirestore firestore;
  late FirebaseStorage firestorage;

  late final LocalAuthentication auth;
  bool supportState = false;

  Future<MyServices> init() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    sharedPref = await SharedPreferences.getInstance();
    firebaseAuth = FirebaseAuth.instance;
    firestore = FirebaseFirestore.instance;
    firestorage = FirebaseStorage.instance;
    auth = LocalAuthentication();
    supportState = await auth.isDeviceSupported();

    await requestNotificationPermissions();
    initAwesomeNotifications();
    timeZoneConfig();
    fcmConfig();
    // createScheduleNotification();
    return this;
  }

  Future<bool> authenticate() async {
    bool authResult = await auth.authenticate(
        localizedReason: AppStrings.enableBiometrics,
        options:
            const AuthenticationOptions(stickyAuth: true, biometricOnly: true));
    return authResult;
  }
}

initialServices() async {
  await Get.putAsync(() => MyServices().init());
}
