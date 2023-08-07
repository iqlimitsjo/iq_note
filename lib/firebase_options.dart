// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAAiucqrn1CoQ5fsOXZ9HY2KtAlSjqAhBM',
    appId: '1:607676168991:web:2063e6a5c9327e9dcb8e2a',
    messagingSenderId: '607676168991',
    projectId: 'iq-note-e121e',
    authDomain: 'iq-note-e121e.firebaseapp.com',
    storageBucket: 'iq-note-e121e.appspot.com',
    measurementId: 'G-6VC8HHL0CK',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAde7foV7KsrixAY69QHMejJsI5qGnHA3k',
    appId: '1:607676168991:android:af7a67600b05f0abcb8e2a',
    messagingSenderId: '607676168991',
    projectId: 'iq-note-e121e',
    storageBucket: 'iq-note-e121e.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA8i9Y8RfNWPb7gGuf6Yfuf52cwXd0FKvo',
    appId: '1:607676168991:ios:445bfcc4a43d0e7dcb8e2a',
    messagingSenderId: '607676168991',
    projectId: 'iq-note-e121e',
    storageBucket: 'iq-note-e121e.appspot.com',
    iosClientId: '607676168991-rtuvp6pqm4m3i422gc7j70d5ihtb8f69.apps.googleusercontent.com',
    iosBundleId: 'com.example.iqNote',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA8i9Y8RfNWPb7gGuf6Yfuf52cwXd0FKvo',
    appId: '1:607676168991:ios:abf7154a29ae2eefcb8e2a',
    messagingSenderId: '607676168991',
    projectId: 'iq-note-e121e',
    storageBucket: 'iq-note-e121e.appspot.com',
    iosClientId: '607676168991-2hv3vfu1tdf1kqg6fuq3gmifbfqu4mvb.apps.googleusercontent.com',
    iosBundleId: 'com.example.iqNote.RunnerTests',
  );
}