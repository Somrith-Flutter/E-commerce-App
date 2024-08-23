import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:market_nest_app/app/ui/pages/authentication_page/register_page.dart';
import 'package:market_nest_app/app/ui/themes/app_color.dart';
import 'package:market_nest_app/app/config/constants/asset_path.dart';
import 'package:market_nest_app/app/ui/layouts/dashboard.dart';
import 'package:market_nest_app/app/controllers/auth_controller.dart';
import 'package:market_nest_app/app/data/globle_variable/public_variable.dart';
import 'package:market_nest_app/app/ui/pages/authentication_page/login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotationAnimation;
  final user = Get.find<AuthController>();

  @override
  void initState() {
    super.initState();
    user.refreshTokenController();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _opacityAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _rotationAnimation = Tween<double>(begin: 0.0, end: 2 * 3.1416).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _controller.forward();

    Future.delayed(const Duration(seconds: 3), () {
      if(user.status == Status.success && user.tmpNewToken != null && user.tmpNewToken!.isNotEmpty) {
        Get.off(const DashboardPage());
      }else{
        if(user.status == Status.fail){
          sessionExpired(context);
          return;
        }
        Get.off(const LoginPage());
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cyan,
      body: SafeArea(
        child: Center(
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Opacity(
                opacity: _opacityAnimation.value,
                child: Transform.scale(
                  scale: _scaleAnimation.value,
                  child: Transform.rotate(
                    angle: _rotationAnimation.value,
                    child: child,
                  ),
                ),
              );
            },
            child: SizedBox(
              width: 350,
              height: 350,
              child: Image.asset(AssetPath.logoApp),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> sessionExpired(BuildContext context) async => showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Session Expired',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          titlePadding: EdgeInsets.zero,
          contentPadding: EdgeInsets.zero,
          backgroundColor: AppColors.white,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  "Currently, we couldn't find your account in our system. To continue, please follow the instructions on the screen.",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: AppColors.black, fontSize: 16),
                ),
              ),
              const SizedBox(height: 30),
              const Divider(
                thickness: 1,
                color: AppColors.grey150,
                height: 1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () async{
                        Get.off(const LoginPage());
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: AppColors.cyan,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(15),
                          ),
                        ),
                      ),
                      child: const Text(
                        'Login Account',
                        style: TextStyle(color: AppColors.white,),
                      ),
                    ),
                  ),
                  const VerticalDivider(
                    width: 1,
                    thickness: 1,
                    color: AppColors.black,
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        Get.off(const RegisterPage());
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: AppColors.cyan,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(15),
                          ),
                        ),
                      ),
                      child: const Text(
                        'Register Account',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
}
