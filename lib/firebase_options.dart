
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
    appId: '1:664224390267:ios:015aa7a68553261e5bd6de',
    messagingSenderId: '664224390267',
    projectId: 'news-f660a',
    databaseURL:
        'https://news-f660a-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'news-f660a.appspot.com',
    iosClientId:
        '664224390267-5hb075d1pqm4j3k8joghbob4sji7gj5c.apps.googleusercontent.com',
    iosBundleId: 'com.example.newsApp',
  );
}
