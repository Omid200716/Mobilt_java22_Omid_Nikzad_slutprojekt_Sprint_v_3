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
    apiKey: 'AIzaSyCzgYE2ziZefujInHrbFEPps2etememX5E',
    appId: '1:984341287399:web:24527727c6495acfc6ed42',
    messagingSenderId: '984341287399',
    projectId: 'omidnikzad-app',
    authDomain: 'omidnikzad-app.firebaseapp.com',
    storageBucket: 'omidnikzad-app.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCW-hbGDkJRAoSMgXRzssGP-5ILUULlhqY',
    appId: '1:984341287399:android:34a1575f4f4854c1c6ed42',
    messagingSenderId: '984341287399',
    projectId: 'omidnikzad-app',
    storageBucket: 'omidnikzad-app.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCpaQ09K1mDKZepYkohwpTtpmYnofG9hOM',
    appId: '1:984341287399:ios:14209a0208e81421c6ed42',
    messagingSenderId: '984341287399',
    projectId: 'omidnikzad-app',
    storageBucket: 'omidnikzad-app.appspot.com',
    iosBundleId: 'com.example.second',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCpaQ09K1mDKZepYkohwpTtpmYnofG9hOM',
    appId: '1:984341287399:ios:d17886119b867b8ac6ed42',
    messagingSenderId: '984341287399',
    projectId: 'omidnikzad-app',
    storageBucket: 'omidnikzad-app.appspot.com',
    iosBundleId: 'com.example.second.RunnerTests',
  );
}