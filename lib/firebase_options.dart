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
        return macos;
      case TargetPlatform.windows:
        return windows;
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
    apiKey: 'AIzaSyCgt1ko1D4K-EFFLGH_o7503KNymMIqmfQ',
    appId: '1:911646898774:web:45894be6a4a21ae89e19f7',
    messagingSenderId: '911646898774',
    projectId: 'summarizer-15429',
    authDomain: 'summarizer-15429.firebaseapp.com',
    storageBucket: 'summarizer-15429.firebasestorage.app',
    measurementId: 'G-PXM133J5KZ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDZLrNj1K9nFEC4GgmJU3p9fQ8zyFaDkkQ',
    appId: '1:911646898774:android:adedcb369eb47d389e19f7',
    messagingSenderId: '911646898774',
    projectId: 'summarizer-15429',
    storageBucket: 'summarizer-15429.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDTIQ1KRBt5ev2B5qywCPHG7-ub1h7Wslg',
    appId: '1:911646898774:ios:737c352c2cfcc9469e19f7',
    messagingSenderId: '911646898774',
    projectId: 'summarizer-15429',
    storageBucket: 'summarizer-15429.firebasestorage.app',
    iosBundleId: 'com.example.summarize',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDTIQ1KRBt5ev2B5qywCPHG7-ub1h7Wslg',
    appId: '1:911646898774:ios:737c352c2cfcc9469e19f7',
    messagingSenderId: '911646898774',
    projectId: 'summarizer-15429',
    storageBucket: 'summarizer-15429.firebasestorage.app',
    iosBundleId: 'com.example.summarize',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCgt1ko1D4K-EFFLGH_o7503KNymMIqmfQ',
    appId: '1:911646898774:web:6076fcd633a4ab9d9e19f7',
    messagingSenderId: '911646898774',
    projectId: 'summarizer-15429',
    authDomain: 'summarizer-15429.firebaseapp.com',
    storageBucket: 'summarizer-15429.firebasestorage.app',
    measurementId: 'G-HB0JMRB1S3',
  );
}
