import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:market_nest_app/app/ui/themes/app_color.dart';

class CustomTheme {
  static const lightThemeFont = "Poppins", darkThemeFont = "Poppins";

  // light theme
  static final lightTheme = ThemeData(
    primaryColor: lightThemeColor,
    useMaterial3: true,
    fontFamily: lightThemeFont,
    switchTheme: SwitchThemeData(
      thumbColor:
      WidgetStateProperty.resolveWith<Color>((states) => lightThemeColor),
    ),
    iconTheme: const IconThemeData(
      color: AppColors.white
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.cyan,
      scrolledUnderElevation: 0,
      titleTextStyle: const TextStyle(
        fontWeight: FontWeight.w500,
        color: AppColors.white,
        fontSize: 18, //20
      ),
      iconTheme: IconThemeData(color: lightThemeColor),
      elevation: 0,
      actionsIconTheme: IconThemeData(color: lightThemeColor),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: white,
        statusBarIconBrightness: Brightness.dark,
      ),
    ),
  );

  // dark theme
  static final darkTheme = ThemeData(
    primaryColor: darkThemeColor,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: black,
    useMaterial3: true,
    fontFamily: darkThemeFont,
    switchTheme: SwitchThemeData(
      trackColor:
      WidgetStateProperty.resolveWith<Color>((states) => darkThemeColor),
    ),
    iconTheme: const IconThemeData(
        color: AppColors.white
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: black,
      scrolledUnderElevation: 0,
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.w500,
        color: white,
        fontSize: 18, //20
      ),
      iconTheme: IconThemeData(color: darkThemeColor),
      elevation: 0,
      actionsIconTheme: IconThemeData(color: darkThemeColor),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: black,
        statusBarIconBrightness: Brightness.light,
      ),
    ),
  );

  // colors
  static Color lightThemeColor = Colors.black,
      white = AppColors.primaryWhite,
      black =  AppColors.primaryBlack,
      darkThemeColor = AppColors.primaryWhite;
}