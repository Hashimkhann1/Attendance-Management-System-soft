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
    apiKey: 'AIzaSyC-kb2gFw_Se8RfkQAh1KxaeasnaDlLc1s',
    appId: '1:392472885770:web:4271679a7c3f0d6aee3df3',
    messagingSenderId: '392472885770',
    projectId: 'attendancemanagement-b9c24',
    authDomain: 'attendancemanagement-b9c24.firebaseapp.com',
    storageBucket: 'attendancemanagement-b9c24.appspot.com',
    measurementId: 'G-VT4P7HD87X',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAYsf8T55jU8yLVW95wPQCHI6BICg7BIYs',
    appId: '1:392472885770:android:b6f13f6a103e3091ee3df3',
    messagingSenderId: '392472885770',
    projectId: 'attendancemanagement-b9c24',
    storageBucket: 'attendancemanagement-b9c24.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCOXfhdiW45rx4sQ2WWxkkZ-AQ_GNr1HsY',
    appId: '1:392472885770:ios:640b437ead815295ee3df3',
    messagingSenderId: '392472885770',
    projectId: 'attendancemanagement-b9c24',
    storageBucket: 'attendancemanagement-b9c24.appspot.com',
    iosBundleId: 'com.example.attendancemanagementsystem',
  );
}
