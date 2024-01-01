import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.

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
    apiKey: 'AIzaSyAdjVTQPwL3RHtA9NdeApVskfhYlze3btE',
    appId: '1:98766095055:web:95632e35bfd90c0425adba',
    messagingSenderId: '98766095055',
    projectId: 'contacts-app-30598',
    authDomain: 'contacts-app-30598.firebaseapp.com',
    storageBucket: 'contacts-app-30598.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCPAuuFUvoiKAxeyvGz2ZBPf2pZzT6qIpg',
    appId: '1:98766095055:android:4260aba631db5a8e25adba',
    messagingSenderId: '98766095055',
    projectId: 'contacts-app-30598',
    storageBucket: 'contacts-app-30598.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBlDH9d9MXznwalYdZBU41hfi95TePiJmQ',
    appId: '1:98766095055:ios:3aa111ec6e140a5925adba',
    messagingSenderId: '98766095055',
    projectId: 'contacts-app-30598',
    storageBucket: 'contacts-app-30598.appspot.com',
    iosBundleId: 'com.example.contactsApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBlDH9d9MXznwalYdZBU41hfi95TePiJmQ',
    appId: '1:98766095055:ios:be17411a9465c91e25adba',
    messagingSenderId: '98766095055',
    projectId: 'contacts-app-30598',
    storageBucket: 'contacts-app-30598.appspot.com',
    iosBundleId: 'com.example.contactsApp.RunnerTests',
  );
}
