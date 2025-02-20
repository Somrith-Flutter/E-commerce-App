import 'package:flutter/material.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:market_nest_app/app/controllers/theme_controller.dart';
import 'package:market_nest_app/app/ui/themes/app_color.dart';
import 'package:market_nest_app/app/controllers/auth_controller.dart';
import 'package:market_nest_app/app/data/globle_variable/public_variable.dart';
import 'package:market_nest_app/app/ui/pages/authentication_page/login_page.dart';
import 'package:market_nest_app/app/ui/global_widgets/form_confirm_password_widget.dart';
import 'package:market_nest_app/app/ui/global_widgets/form_password_widget.dart';
import 'package:market_nest_app/app/ui/global_widgets/loading_widget.dart';

class SetNewPassWidget extends StatefulWidget {
  const SetNewPassWidget({super.key});

  @override
  State<SetNewPassWidget> createState() => _SetNewPassWidgetState();
}

class _SetNewPassWidgetState extends State<SetNewPassWidget> {
  final auth = Get.find<AuthController>();
  final _theme = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("New Password",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const Gap(15),
              const Text("Enter your new password and remember it.",
                style: TextStyle(fontSize: 16, color: AppColors.grey150),
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
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                child: ElevatedButton(
                    onPressed: () {
                      showLoadingDialog(context, label: "Saving...");
                      if (auth.passwordController.text.length < 6) {
                        Get.back();
                        IconSnackBar.show(
                          context,
                          label: 'Password at least 6 digits!',
                          snackBarType: SnackBarType.fail,
                          duration: const Duration(seconds: 5),
                        );
                        return;
                      }

                      if (auth.passwordController.text !=
                          auth.confirmViaPasswordController.text) {
                        Get.back();
                        IconSnackBar.show(
                          context,
                          label: 'Confirm password does not match!',
                          snackBarType: SnackBarType.fail,
                          duration: const Duration(seconds: 5),
                        );
                        return;
                      }

                      Future.delayed(const Duration(seconds: 1), () {
                        auth.updatePassword(userId: auth.tempUUId.toString());
                        if (auth.status == Status.success) {
                          Get.back();
                          IconSnackBar.show(
                            context,
                            label: 'Password have been reset',
                            snackBarType: SnackBarType.success,
                            duration: const Duration(seconds: 5),
                          );
                          auth.clearSetter();
                          Get.off(const LoginPage());
                          return;
                        }
                      });
                    },
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 22),
                        backgroundColor: _theme.currentTheme.value ==
                            ThemeMode.dark ? Colors.redAccent : AppColors.black,
                        shape: ContinuousRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        )
                    ),
                    child: const Text(
                      "Save",
                      style: TextStyle(fontSize: 18, color: AppColors.white),
                    )
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
