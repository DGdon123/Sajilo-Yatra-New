import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../firebase_options.dart';

class AppInitialize {
  static appInitialize() async {
    WidgetsFlutterBinding.ensureInitialized();

    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    await SharedPreferences.getInstance();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    await dotenv.load(fileName: ".env");
  }
}
