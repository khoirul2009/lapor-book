// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
    apiKey: 'AIzaSyAmLlYNQkLkGf1q9JMuotM802kKPL2ErXg',
    appId: '1:646345087081:web:cf759486f81597949e2af8',
    messagingSenderId: '646345087081',
    projectId: 'lapor-book-67c08',
    authDomain: 'lapor-book-67c08.firebaseapp.com',
    storageBucket: 'lapor-book-67c08.appspot.com',
    measurementId: 'G-0D271GHH8K',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB-R6spG0Q2-aD6LBj3LIe8N_yFFBLSe5M',
    appId: '1:646345087081:android:bad9ed4d60d1537b9e2af8',
    messagingSenderId: '646345087081',
    projectId: 'lapor-book-67c08',
    storageBucket: 'lapor-book-67c08.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB8MiAX5NBMAKyX-wqv1njGxnayIleC4Ko',
    appId: '1:646345087081:ios:b011c82e1fa9b23e9e2af8',
    messagingSenderId: '646345087081',
    projectId: 'lapor-book-67c08',
    storageBucket: 'lapor-book-67c08.appspot.com',
    iosBundleId: 'com.laporbook.laporBook',
  );
}
