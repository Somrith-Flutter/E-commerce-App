import 'package:flutter/material.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:market_nest_app/config/themes/app_color.dart';
import 'package:market_nest_app/constants/asset_path.dart';
import 'package:market_nest_app/dashboard.dart';
import 'package:market_nest_app/modules/app/controllers/auth_controller.dart';
import 'package:market_nest_app/modules/app/data/globle_variable/public_variable.dart';
import 'package:market_nest_app/modules/app/ui/pages/forgot_password.dart';
import 'package:market_nest_app/modules/app/ui/pages/register_page.dart';
import 'package:market_nest_app/modules/app/ui/widgets/form_input_widget.dart';
import 'package:market_nest_app/modules/app/ui/widgets/form_password_widget.dart';
import 'package:market_nest_app/modules/app/ui/widgets/loading_widget.dart';
import 'package:market_nest_app/utils/helpers.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final user = Get.find<AuthController>();

  Future<bool> _login(BuildContext context) async {
    showLoadingDialog(context, label: "Logging in...");
    if(user.emailController.text.isEmpty
        && !user.emailController.text.contains("@gmail.com")){
      Get.back();
      IconSnackBar.show(
        context,
        label: 'Invalid email address',
        snackBarType: SnackBarType.fail,
        duration: const Duration(seconds: 3),
      );
      return false;
    }

    if(user.passwordController.text.isEmpty){
      Get.back();
      IconSnackBar.show(
        context,
        label: 'Invalid email password',
        snackBarType: SnackBarType.fail,
        duration: const Duration(seconds: 3),
      );
      return false;
    }

    await user.loginController();

    if(user.status == Status.fail){
      Get.back();
      IconSnackBar.show(
        context,
        label: 'Something wrong with Server',
        snackBarType: SnackBarType.fail,
        duration: const Duration(seconds: 3),
      );
      return false;
    }

    if(accessToken.toString().isNotEmpty && user.status == Status.success){
      Get.off(const DashboardPage());
    }
    return false;
  }

  @override
  void initState() {
    print("ended ${ended.$}");
    print("limitTime ${limitTime.$}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final CountdownTimer countdownTimer = CountdownTimer();

    return SafeArea(
      child: GestureDetector(
        onTap: () async {
          // limitTime.$ = 0;
          // await limitTime.save();
          FocusScope.of(context).requestFocus(FocusNode());
        },
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
                    if(ended.$ == true)...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          StreamBuilder<Duration>(
                            stream: countdownTimer.remainingTimeStream,
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return const CircularProgressIndicator();
                              }

                              final remainingTime = snapshot.data!;
                              if (limitTime.$ == 3 || limitTime.$ == 4) {
                                return Text(
                                  'Try again in ${remainingTime.inHours.toString().padLeft(2, '0')}:${remainingTime.inMinutes.remainder(60).toString().padLeft(2, '0')}:${remainingTime.inSeconds.remainder(60).toString().padLeft(2, '0')}',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold,
                                  ),
                                );
                              }
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                    onTap: () => Get.to( const ForgotPasswordScreen()),
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
                              );
                            },
                          )
                        ],
                      )
                    ]else...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () => Get.to( const ForgotPasswordScreen()),
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
                    ],
                    const Gap(100),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                          onPressed: () => _login(context),
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
