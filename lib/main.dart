import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:market_nest_app/splash_screen.dart';

import 'modules/app/bindings/init_bindings.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: AppBindings(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Poppins"
      ),
      home: const SplashScreen(),
    );
  }
}

