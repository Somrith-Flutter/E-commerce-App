import 'package:flutter/material.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:market_nest_app/config/themes/app_color.dart';
import 'package:market_nest_app/modules/app/controllers/auth_controller.dart';
import 'package:market_nest_app/modules/app/data/globle_variable/public_variable.dart';
import 'package:market_nest_app/modules/app/ui/widgets/form_input_widget.dart';
import 'package:market_nest_app/modules/app/ui/widgets/loading_widget.dart';

class ConfirmEmailWidget extends StatefulWidget {
  const ConfirmEmailWidget({super.key});

  @override
  State<ConfirmEmailWidget> createState() => _ConfirmEmailWidgetState();
}

class _ConfirmEmailWidgetState extends State<ConfirmEmailWidget> {
  final _auth = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Confirmation Email",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const Gap(15),
          const Text("Enter your email address for verification",
            style: TextStyle(fontSize: 16, color: AppColors.grey150),
          ),
          const Gap(20),
          FormInputWidget(
            label: "Email",
            hint: "Enter email address",
            controller: _auth.emailController),
          const Gap(50),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: ElevatedButton(
              onPressed: () async {
                showLoadingDialog(context, label: "Checking...");

                if(_auth.emailController.text.isEmpty || !_auth.emailController.text.contains("@gmail.com")){
                  Get.back();
                  IconSnackBar.show(
                    context,
                    label: 'Invalid email!',
                    snackBarType: SnackBarType.fail,
                    duration: const Duration(seconds: 3),
                  );
                  return;
                }
                _auth.forgotPasswordController();
                if(_auth.status == Status.fail){
                  Get.back();
                  IconSnackBar.show(
                    context,
                    label: 'Your email not found!',
                    snackBarType: SnackBarType.fail,
                    duration: const Duration(seconds: 3),
                  );
                  return;
                }else{
                  Get.back();
                  _auth.widgetTrigger(1);
                }
              },
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 22),
                  backgroundColor: AppColors.black,
                  shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  )
              ),
              child: const Text(
                "Send",
                style: TextStyle(fontSize: 18, color: AppColors.white),
              )
            ),
          )
        ],
      ),
    );
  }
}
