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
    apiKey: 'AIzaSyD1WiUyzpbMuBLGLPfShmyk5bZM9pNDHkY',
    appId: '1:955720840741:web:25761e61d071f96996b1cc',
    messagingSenderId: '955720840741',
    projectId: 'civic-shelf',
    authDomain: 'civic-shelf.firebaseapp.com',
    storageBucket: 'civic-shelf.appspot.com',
    measurementId: 'G-0QQ1QZ9QHM',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD6qDA3NSgTBoFxxnTXwuhRgOHuqDIWU-8',
    appId: '1:955720840741:android:f8f12439f741b39a96b1cc',
    messagingSenderId: '955720840741',
    projectId: 'civic-shelf',
    storageBucket: 'civic-shelf.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDFtRfVdJBjFVL3tY8xJ0YSybtgf8w-sDk',
    appId: '1:955720840741:ios:864ae7a104fdef4e96b1cc',
    messagingSenderId: '955720840741',
    projectId: 'civic-shelf',
    storageBucket: 'civic-shelf.appspot.com',
    iosBundleId: 'com.example.civicShelfMobileApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDFtRfVdJBjFVL3tY8xJ0YSybtgf8w-sDk',
    appId: '1:955720840741:ios:21600f31b9d37f5096b1cc',
    messagingSenderId: '955720840741',
    projectId: 'civic-shelf',
    storageBucket: 'civic-shelf.appspot.com',
    iosBundleId: 'com.example.civicShelfMobileApp.RunnerTests',
  );
}
