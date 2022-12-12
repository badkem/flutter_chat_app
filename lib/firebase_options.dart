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
    apiKey: 'AIzaSyDay9sjGP0k7oABgCpglCUgrODtZJFcSmA',
    appId: '1:71735278009:web:374a8546183498236ede68',
    messagingSenderId: '71735278009',
    projectId: 'flutter-chat-app-d5498',
    authDomain: 'flutter-chat-app-d5498.firebaseapp.com',
    storageBucket: 'flutter-chat-app-d5498.appspot.com',
    measurementId: 'G-0S7Y0THC8M',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCSVVsDIDC36EHkG0sosG6PcLXXuhWF1Ss',
    appId: '1:71735278009:android:e2bb4048a777fb286ede68',
    messagingSenderId: '71735278009',
    projectId: 'flutter-chat-app-d5498',
    storageBucket: 'flutter-chat-app-d5498.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDalGG0tBXJeLZ_CYq2JS_se-pimwPobOc',
    appId: '1:71735278009:ios:e1a5689a9ef08f6a6ede68',
    messagingSenderId: '71735278009',
    projectId: 'flutter-chat-app-d5498',
    storageBucket: 'flutter-chat-app-d5498.appspot.com',
    androidClientId: '71735278009-1h1e9n78il23hdrm2k3ndabjoe117ebf.apps.googleusercontent.com',
    iosClientId: '71735278009-jvrlf3jfda11jvpr1pmeil6pho015g3g.apps.googleusercontent.com',
    iosBundleId: 'com.pd.chatapp.flutterChatApp',
  );
}