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
    apiKey: 'AIzaSyDjjx_rMyUyiWoYeN1w-0updPt-kblYTu8',
    appId: '1:881229039105:web:ee49af2fd4f465a432a200',
    messagingSenderId: '881229039105',
    projectId: 'to-do-16ad4',
    authDomain: 'to-do-16ad4.firebaseapp.com',
    storageBucket: 'to-do-16ad4.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAWnFNu6P3n12JTU73p18mAf7SsMOUrSMw',
    appId: '1:881229039105:android:58bbe6728ae4873832a200',
    messagingSenderId: '881229039105',
    projectId: 'to-do-16ad4',
    storageBucket: 'to-do-16ad4.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDwP08bh5ZkMfAhv_6skTzLcyUSAnbWY4g',
    appId: '1:881229039105:ios:68547a95446da83f32a200',
    messagingSenderId: '881229039105',
    projectId: 'to-do-16ad4',
    storageBucket: 'to-do-16ad4.appspot.com',
    iosBundleId: 'com.example.toDo',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDwP08bh5ZkMfAhv_6skTzLcyUSAnbWY4g',
    appId: '1:881229039105:ios:48d6e6634bdd58d432a200',
    messagingSenderId: '881229039105',
    projectId: 'to-do-16ad4',
    storageBucket: 'to-do-16ad4.appspot.com',
    iosBundleId: 'com.example.toDo.RunnerTests',
  );
}