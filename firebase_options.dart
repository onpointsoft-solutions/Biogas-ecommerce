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
    apiKey: 'your-actual-web-api-key-here',
    appId: 'your-actual-web-app-id-here',
    messagingSenderId: 'your-actual-sender-id-here',
    projectId: 'your-actual-project-id-here',
    authDomain: 'your-project-id.firebaseapp.com',
    storageBucket: 'your-project-id.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'your-actual-android-api-key-here',
    appId: 'your-actual-android-app-id-here',
    messagingSenderId: 'your-actual-sender-id-here',
    projectId: 'your-actual-project-id-here',
    storageBucket: 'your-project-id.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'your-actual-ios-api-key-here',
    appId: 'your-actual-ios-app-id-here',
    messagingSenderId: 'your-actual-sender-id-here',
    projectId: 'your-actual-project-id-here',
    storageBucket: 'your-project-id.appspot.com',
    iosBundleId: 'com.example.biogasTechnicianApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'your-macos-api-key',
    appId: 'your-macos-app-id',
    messagingSenderId: 'your-sender-id',
    projectId: 'your-project-id',
    storageBucket: 'your-project-id.appspot.com',
    iosBundleId: 'com.example.biogasTechnicianApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'your-windows-api-key',
    appId: 'your-windows-app-id',
    messagingSenderId: 'your-sender-id',
    projectId: 'your-project-id',
    authDomain: 'your-project-id.firebaseapp.com',
    storageBucket: 'your-project-id.appspot.com',
  );
}
