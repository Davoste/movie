// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyDiEPLPaCFWZ2NHJKQ_fM-T0AUC0kqffxE',
    appId: '1:581163551012:web:fc0fbb2d563a9903cecbb1',
    messagingSenderId: '581163551012',
    projectId: 'goojara-61cc8',
    authDomain: 'goojara-61cc8.firebaseapp.com',
    storageBucket: 'goojara-61cc8.appspot.com',
    measurementId: 'G-2KL9E4ZH9N',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC4IWd72Jhb3ZwjajPhGmDYwN6Uv_nV_YM',
    appId: '1:581163551012:android:f127e4d7e20d3dd8cecbb1',
    messagingSenderId: '581163551012',
    projectId: 'goojara-61cc8',
    storageBucket: 'goojara-61cc8.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA34tj00TLPS3NMyfi0OzRNUljeAhHFJaE',
    appId: '1:581163551012:ios:836d8b790a04d7a1cecbb1',
    messagingSenderId: '581163551012',
    projectId: 'goojara-61cc8',
    storageBucket: 'goojara-61cc8.appspot.com',
    iosBundleId: 'com.example.goojara',
  );
}
