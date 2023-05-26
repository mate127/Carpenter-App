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
    apiKey: 'AIzaSyBzMPtQNrqQubllEYTWUlOvclAP49Z8Rfc',
    appId: '1:107003072752:web:cc146afdc9c230d6f37235',
    messagingSenderId: '107003072752',
    projectId: 'carpenter-app-8b725',
    authDomain: 'carpenter-app-8b725.firebaseapp.com',
    storageBucket: 'carpenter-app-8b725.appspot.com',
    measurementId: 'G-YDLPL6K2F1',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyArLU39S0qbQQUxEF10vEcMnfk8qJINQOU',
    appId: '1:107003072752:android:e944e616b895c98bf37235',
    messagingSenderId: '107003072752',
    projectId: 'carpenter-app-8b725',
    storageBucket: 'carpenter-app-8b725.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA7dtj70oxzOM7fLOZw2b-DeUAC4JtAczQ',
    appId: '1:107003072752:ios:1de541b43fac7961f37235',
    messagingSenderId: '107003072752',
    projectId: 'carpenter-app-8b725',
    storageBucket: 'carpenter-app-8b725.appspot.com',
    iosClientId:
        '107003072752-jmqgd9a716vaqu2lb064khegad5vho3u.apps.googleusercontent.com',
    iosBundleId: 'com.mate.carpenterApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA7dtj70oxzOM7fLOZw2b-DeUAC4JtAczQ',
    appId: '1:107003072752:ios:5453a057b919d312f37235',
    messagingSenderId: '107003072752',
    projectId: 'carpenter-app-8b725',
    storageBucket: 'carpenter-app-8b725.appspot.com',
    iosClientId:
        '107003072752-3380vgrhq34fno8n5suacm0us15qaub9.apps.googleusercontent.com',
    iosBundleId: 'com.mate.carpenterApp.RunnerTests',
  );
}