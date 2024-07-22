import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:music_app/views/home_screen.dart';
import 'package:music_app/views/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'music app',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor:  Colors.transparent,
          elevation: 0
        )
      ),
      home: SplashScreen(),
    );
  }
}


