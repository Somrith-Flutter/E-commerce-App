import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:market_nest_app/config/themes/app_color.dart';
import 'package:market_nest_app/constants/asset_path.dart';
import 'package:market_nest_app/modules/app/controllers/auth_controller.dart';
import 'package:market_nest_app/modules/app/ui/pages/register_page.dart';
import 'package:market_nest_app/modules/app/ui/widgets/form_input_widget.dart';
import 'package:market_nest_app/modules/app/ui/widgets/form_password_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final user = Get.find<AuthController>();

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
                    const Gap(20),
                    const Text("Signin",
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    const Gap(5),
                    Row(
                      children: [
                        const Text("Do not have an account?",
                          style: TextStyle(
                              fontSize: 16
                          ),
                        ),
                        const Gap(5),
                        GestureDetector(
                          onTap: () => Get.off(const RegisterPage()),
                          child: const Text("Signup",
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
                        label: "Email",
                        controller: auth.emailController,
                        hint: "Email address"
                    ),
                    const Gap(30),
                    FormPasswordWidget(
                      label: "Password",
                      hint: "+6 charecter and number",
                      controller: auth.passwordController),
                    const Gap(20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: const Text(
                            "Forgot Password?",
                            style: TextStyle(
                              color: AppColors.cyan,
                              fontSize: 16,
                              fontWeight: FontWeight.w600
                            ),
                          ),
                        )
                      ],
                    ),
                    const Gap(100),
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
                            "Login Account",
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
      ),
    );
  }
}
