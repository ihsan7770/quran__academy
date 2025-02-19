import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:io' show Platform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    } else if (Platform.isAndroid) {
      return android;
    } else if (Platform.isWindows) {
      return windows;
    } else {
      throw UnsupportedError(
        'FirebaseOptions are not configured for this platform.',
      );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: "AIzaSyAmK030SiFb9j3HqiXxOVlECEynIEsbLSg",  
    authDomain: "quran-academy-b27b5.firebaseapp.com",
    projectId: "quran-academy-b27b5",
    storageBucket: "quran-academy-b27b5.appspot.com",
    messagingSenderId: "1041215585825",
    appId: "1:1041215585825:web:YOUR_UNIQUE_WEB_APP_ID",
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: "AIzaSyAmK030SiFb9j3HqiXxOVlECEynIEsbLSg",  // Found in google-services.json
    appId: "1:1041215585825:android:7d79ce020fecbc42f9ad60",
    messagingSenderId: "1041215585825",
    projectId: "quran-academy-b27b5",
    storageBucket: "quran-academy-b27b5.appspot.com",
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: "YOUR_WEB_API_KEY",  // Same as the Web API key
    appId: "1:1041215585825:web:YOUR_UNIQUE_WINDOWS_APP_ID",
    messagingSenderId: "1041215585825",
    projectId: "quran-academy-b27b5",
    storageBucket: "quran-academy-b27b5.appspot.com",
  );
}
