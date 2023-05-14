import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:se_delivery/SplashScreen/splash_screen.dart';
import 'package:se_delivery/global/global.dart';
import 'package:shared_preferences/shared_preferences.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences = await SharedPreferences.getInstance();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        title: 'Sellers App',
        theme: ThemeData(
          // primaryIconTheme: Color(0xffee547b),
          iconTheme: const IconThemeData(
              color: Color(0xffee547b),
          ),
          focusColor: Colors.black,

        ),
        home: const MySplashScreen());
  }
}
