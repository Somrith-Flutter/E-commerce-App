import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:market_nest_app/config/themes/app_color.dart';
import 'package:market_nest_app/constants/asset_path.dart';
import 'package:market_nest_app/modules/app/controllers/auth_controller.dart';
import 'package:market_nest_app/modules/app/data/globle_variable/public_variable.dart';
import 'package:market_nest_app/modules/app/ui/pages/forgot_password.dart';
import 'package:market_nest_app/modules/app/ui/pages/login_page.dart';
import 'package:market_nest_app/modules/app/ui/widgets/form_confirm_password_widget.dart';
import 'package:market_nest_app/modules/app/ui/widgets/form_input_widget.dart';
import 'package:market_nest_app/modules/app/ui/widgets/form_password_widget.dart';
import 'package:market_nest_app/modules/app/ui/widgets/loading_widget.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final authController = Get.find<AuthController>();

  void _register() async {
    showLoadingDialog(context, label: "Saving...");

    if(authController.fullNameController.text == ""
    || authController.emailController.text == ""
    || authController.passwordController.text == ""
    || authController.confirmViaPasswordController.text == ""){
      Get.back();
      IconSnackBar.show(
        context,
        label: 'Please fill in all the blank!',
        snackBarType: SnackBarType.fail,
        duration: const Duration(seconds: 3),
      );
      return;
    }

    if(authController.passwordController.text.length < 6){
      Get.back();
      IconSnackBar.show(
        context,
        label: 'Password at least 6 digit!',
        snackBarType: SnackBarType.fail,
        duration: const Duration(seconds: 3),
      );
      return;
    }

    if(!authController.emailController.text.contains("@gmail.com")){
      Get.back();
      IconSnackBar.show(
        context,
        label: 'Your email is invalid',
        snackBarType: SnackBarType.fail,
        duration: const Duration(seconds: 3),
      );
      return;
    }

    if(authController.passwordController.text != authController.confirmViaPasswordController.text){
      Get.back();
      IconSnackBar.show(
        context,
        label: 'Password confirm is not correct',
        snackBarType: SnackBarType.fail,
        duration: const Duration(seconds: 3),
      );
      return;
    }

    await authController.registerController();
    if(authController.status == Status.success) {
      Get.off(const LoginPage());
    }else{
      Get.back();
      IconSnackBar.show(
        context,
        label: "Your email is  already exists!",
        snackBarType: SnackBarType.fail,
        duration: const Duration(seconds: 3),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Scaffold(
          body: GetBuilder<AuthController>(builder: (auth) {
            return SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(AssetPath.blackBgLogoApp,
                      width: 150,
                    ),
                    const Gap(10),
                    const Text("SignUp",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    const Gap(5),
                    Row(
                      children: [
                        const Text("Already have an account?",
                          style: TextStyle(
                              fontSize: 16
                          ),
                        ),
                        const Gap(5),
                        GestureDetector(
                          onTap: () => Get.off(const LoginPage()),
                          child: const Text("Login",
                            style: TextStyle(
                                color: AppColors.cyan,
                                fontSize: 16
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Gap(30),
                    FormInputWidget(
                        label: "Full Name",
                        controller: auth.fullNameController,
                        hint: "Enter full name"
                    ),
                    const Gap(30),
                    FormInputWidget(
                        label: "Email",
                        controller: auth.emailController,
                        hint: "Email address"
                    ),
                    const Gap(30),
                    Visibility(
                      visible: auth.isConfirm,
                        child: Column(
                          children: [
                            FormPasswordWidget(
                              label: "Password",
                              controller: auth.passwordController,
                              hint: "+8 character"
                            ),
                            const Gap(30),
                            FormConfirmPasswordWidget(
                              label: "Re-Write Password",
                              controller: auth.confirmViaPasswordController,
                              hint: "Re-Write Password"
                            ),
                          ],
                    )),

                    const Gap(50),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        onPressed: () async {
                          if(!auth.isConfirm) {
                            if(authController.fullNameController.text == ""
                                || authController.emailController.text == ""){
                              Get.back();
                              IconSnackBar.show(
                                context,
                                label: 'Please fill in all the blank!',
                                snackBarType: SnackBarType.fail,
                                duration: const Duration(seconds: 3),
                              );
                              return;
                            }else{
                              showLoadingDialog(context, label: "Checking...");
                              await auth.forgotPasswordController();
                              if(auth.status == Status.success){
                                Get.to(const ForgotPasswordScreen(fixedWidget: 1,));
                                IconSnackBar.show(
                                  context,
                                  label: 'Verification code have been sent!',
                                  snackBarType: SnackBarType.alert,
                                  duration: const Duration(seconds: 3),
                                );
                                return;
                              }
                            }
                          }
                          _register();
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 22),
                          backgroundColor: AppColors.black,
                          shape: ContinuousRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          )
                        ),
                        child: Text(
                          auth.isConfirm ? "Create Account" : "Confirm Account",
                          style: const TextStyle(fontSize: 18, color: AppColors.cyan),
                        )
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
