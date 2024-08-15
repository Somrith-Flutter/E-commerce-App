import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:market_nest_app/config/themes/app_color.dart';
import 'package:market_nest_app/constants/asset_path.dart';
import 'package:market_nest_app/modules/app/controllers/auth_controller.dart';
import 'package:market_nest_app/modules/app/ui/widgets/form_confirm_password_widget.dart';
import 'package:market_nest_app/modules/app/ui/widgets/form_input_widget.dart';
import 'package:market_nest_app/modules/app/ui/widgets/form_password_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GetBuilder<AuthController>(builder: (auth) {
          return SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(AssetPath.miniLogoApp,
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
                  const Row(
                    children: [
                      Text("Already have an account?",
                        style: TextStyle(
                            fontSize: 16
                        ),
                      ),
                      Gap(5),
                      Text("Login",
                        style: TextStyle(
                            color: AppColors.cyan,
                            fontSize: 16
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

                  const Gap(50),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: (){},
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 22),
                        backgroundColor: AppColors.black,
                        shape: ContinuousRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        )
                      ),
                      child: const Text(
                        "Create Account",
                        style: TextStyle(fontSize: 18, color: AppColors.cyan),
                      )
                    ),
                  )
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
