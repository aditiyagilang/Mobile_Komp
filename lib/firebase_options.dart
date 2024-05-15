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
    apiKey: 'AIzaSyDAAiGpYUgtjLTp8laMqaskp91aSWcFc74',
    appId: '1:1057046976713:web:d5a879b81d5212a6595518',
    messagingSenderId: '1057046976713',
    projectId: 'ujikom-2d1bf',
    authDomain: 'ujikom-2d1bf.firebaseapp.com',
    storageBucket: 'ujikom-2d1bf.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDaFeH7qZrDBqxkIkV5nfQfy9w0FIfU9Mo',
    appId: '1:1057046976713:android:df45648dc9228980595518',
    messagingSenderId: '1057046976713',
    projectId: 'ujikom-2d1bf',
    storageBucket: 'ujikom-2d1bf.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDtG3Je0gpkacAalYWhNBef2XovGv2cyKQ',
    appId: '1:1057046976713:ios:40ef679226b056a4595518',
    messagingSenderId: '1057046976713',
    projectId: 'ujikom-2d1bf',
    storageBucket: 'ujikom-2d1bf.appspot.com',
    iosBundleId: 'com.example.ujikom',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDtG3Je0gpkacAalYWhNBef2XovGv2cyKQ',
    appId: '1:1057046976713:ios:40ef679226b056a4595518',
    messagingSenderId: '1057046976713',
    projectId: 'ujikom-2d1bf',
    storageBucket: 'ujikom-2d1bf.appspot.com',
    iosBundleId: 'com.example.ujikom',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDAAiGpYUgtjLTp8laMqaskp91aSWcFc74',
    appId: '1:1057046976713:web:c94f21f482bc9447595518',
    messagingSenderId: '1057046976713',
    projectId: 'ujikom-2d1bf',
    authDomain: 'ujikom-2d1bf.firebaseapp.com',
    storageBucket: 'ujikom-2d1bf.appspot.com',
  );
}
