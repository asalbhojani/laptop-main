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
    apiKey: 'AIzaSyBUrTtZwkBd9pT0BQIxalfSv1Jae7MnDzs',
    appId: '1:1029521473590:web:27a8db458d6134633f9897',
    messagingSenderId: '1029521473590',
    projectId: 'laptop-3d82d',
    authDomain: 'laptop-3d82d.firebaseapp.com',
    storageBucket: 'laptop-3d82d.appspot.com',
    measurementId: 'G-71EMMSP5LE',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDYoX6uz8OfTSKOmErc3-yA6_fflgZikws',
    appId: '1:1029521473590:android:f4c8bf07896f38d73f9897',
    messagingSenderId: '1029521473590',
    projectId: 'laptop-3d82d',
    storageBucket: 'laptop-3d82d.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBJMBHBwINo8jPsFWhlSi97IK-eJwsw84k',
    appId: '1:1029521473590:ios:d809eb51fdf8e10f3f9897',
    messagingSenderId: '1029521473590',
    projectId: 'laptop-3d82d',
    storageBucket: 'laptop-3d82d.appspot.com',
    iosBundleId: 'com.example.laptop',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBJMBHBwINo8jPsFWhlSi97IK-eJwsw84k',
    appId: '1:1029521473590:ios:4ad9ed369f06c2063f9897',
    messagingSenderId: '1029521473590',
    projectId: 'laptop-3d82d',
    storageBucket: 'laptop-3d82d.appspot.com',
    iosBundleId: 'com.example.laptop.RunnerTests',
  );
}
