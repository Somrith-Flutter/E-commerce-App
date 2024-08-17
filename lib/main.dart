import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:market_nest_app/modules/app/data/globle_variable/public_variable.dart';
import 'package:market_nest_app/splash_screen.dart';
import 'package:shared_value/shared_value.dart';
import 'modules/app/bindings/init_bindings.dart';

void main() async {
  runApp(SharedValue.wrapApp(const MyApp()));

  await accessToken.load();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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

