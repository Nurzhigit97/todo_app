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
    apiKey: 'AIzaSyAsYj_6FjRSxofdt3Fz5o5EzGOIIst2WpM',
    appId: '1:392930894056:web:c47637b2acdc690126a95d',
    messagingSenderId: '392930894056',
    projectId: 'todoapp-5da6f',
    authDomain: 'todoapp-5da6f.firebaseapp.com',
    storageBucket: 'todoapp-5da6f.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAi-IptBoCI4uOrPlXg4JSzgK5KwHAHddg',
    appId: '1:392930894056:android:8b6b8aeb49b8b01d26a95d',
    messagingSenderId: '392930894056',
    projectId: 'todoapp-5da6f',
    storageBucket: 'todoapp-5da6f.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAFlXq9oKE4MIe-z44rOU8yUt0wFNpxkdw',
    appId: '1:392930894056:ios:26b7fa6673ab56f226a95d',
    messagingSenderId: '392930894056',
    projectId: 'todoapp-5da6f',
    storageBucket: 'todoapp-5da6f.appspot.com',
    iosClientId:
        '392930894056-vfr0g7lv345pgclmgvqfcg82f7g6t26t.apps.googleusercontent.com',
    iosBundleId: 'com.example.todoApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAFlXq9oKE4MIe-z44rOU8yUt0wFNpxkdw',
    appId: '1:392930894056:ios:26b7fa6673ab56f226a95d',
    messagingSenderId: '392930894056',
    projectId: 'todoapp-5da6f',
    storageBucket: 'todoapp-5da6f.appspot.com',
    iosClientId:
        '392930894056-vfr0g7lv345pgclmgvqfcg82f7g6t26t.apps.googleusercontent.com',
    iosBundleId: 'com.example.todoApp',
  );
}
