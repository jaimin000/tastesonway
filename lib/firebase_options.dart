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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDhaIPpQoSUbSjq_4z0I0vovMTCVOOu-3c',
    appId: '1:823346082634:android:73fc3e2ec96a55967607b3',
    messagingSenderId: '823346082634',
    projectId: 'tastesonway-51bec',
    storageBucket: 'tastesonway-51bec.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCewGw6Qarn4WkUSA0Km4KAOupp9iCbnYU',
    appId: '1:823346082634:ios:2747546bebcd177c7607b3',
    messagingSenderId: '823346082634',
    projectId: 'tastesonway-51bec',
    storageBucket: 'tastesonway-51bec.appspot.com',
    androidClientId: '823346082634-d9pqbbfde2as7ug4115l579l93986eqm.apps.googleusercontent.com',
    iosClientId: '823346082634-m2asrbhn03n5jiq575odd3fltgkek68j.apps.googleusercontent.com',
    iosBundleId: 'com.testing.tastesonway',
  );
}
