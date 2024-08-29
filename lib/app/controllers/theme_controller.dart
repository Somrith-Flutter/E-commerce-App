import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends GetxController implements GetxService {
  Rx<ThemeMode> currentTheme = ThemeMode.system.obs;

  void switchTheme() async {
    final prefs = await SharedPreferences.getInstance();
    currentTheme.value = currentTheme.value == ThemeMode.light
        ? ThemeMode.dark
        : ThemeMode.light;

    await prefs.setBool('isDarkMode', currentTheme.value == ThemeMode.dark);
    Get.changeThemeMode(currentTheme.value);
    update();
  }

  Future<void> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final isDarkMode = prefs.getBool('isDarkMode') ?? false;
    currentTheme.value = !isDarkMode ? ThemeMode.dark : ThemeMode.light;
    update();
  }
}