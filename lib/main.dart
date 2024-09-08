import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:market_nest_app/app/controllers/theme_controller.dart';
import 'package:market_nest_app/app/data/globle_variable/public_variable.dart';
import 'package:market_nest_app/app/ui/layouts/splash_screen.dart';
import 'package:market_nest_app/app/ui/themes/sytem_theme.dart';
import 'package:shared_value/shared_value.dart';
import 'app/bindings/init_bindings.dart';

void main() async {
  runApp(SharedValue.wrapApp(const MyApp()));
  WidgetsFlutterBinding.ensureInitialized();
  final themeController = Get.put(ThemeController());

  await themeController.loadTheme();
  await accessToken.load();
  await limitTime.load();
  await ended.load();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.put(ThemeController());

    return GetMaterialApp(
      initialBinding: AppBindings(),
      debugShowCheckedModeBanner: false,
      theme: CustomTheme.lightTheme,
      darkTheme: CustomTheme.darkTheme,
      themeMode: themeController.currentTheme.value,
      home: const SplashScreen(),
    );
  }
}

