// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, TargetPlatform;

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
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAb-EKt9wljb9dTMYLbL-H2KuDzrKRvAj8',
    appId: '1:664224390267:android:d4ac20eeb4e9489e5bd6de',
    messagingSenderId: '664224390267',
    projectId: 'news-f660a',
    databaseURL:
        'https://news-f660a-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'news-f660a.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDhoT4h5Spi2AzsxBsL17S-tnx8U7EZIYM',
    appId: '1:664224390267:ios:0413efd0d7fa0c1f5bd6de',
    messagingSenderId: '664224390267',
    projectId: 'news-f660a',
    databaseURL:
        'https://news-f660a-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'news-f660a.appspot.com',
    iosClientId:
        '664224390267-sennbr5tkv2o1uj613tfe8nir4c67in4.apps.googleusercontent.com',
    iosBundleId: 'com.example.newss',
  );
}
