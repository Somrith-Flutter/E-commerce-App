import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:market_nest_app/config/themes/app_color.dart';
import 'package:market_nest_app/modules/app/controllers/auth_controller.dart';
import 'package:market_nest_app/modules/app/ui/widgets/confirm_email_widget.dart';
import 'package:market_nest_app/modules/app/ui/widgets/pin_put_code_widget.dart';
import 'package:market_nest_app/modules/app/ui/widgets/set_new_pass_widget.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  int finalStep = 3;
  final _auth = Get.find<AuthController>();

  List<Widget> _stepWidget() {
    return [
      const ConfirmEmailWidget(),
      const PinPutCode(),
      const SetNewPassWidget(),
    ];
  }

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 100), () {
      _auth.widgetTrigger(0);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: GetBuilder<AuthController>(builder: (logic) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  Get.back();
                  _auth.clearSetter();
                },
                icon: Icon(Platform.isAndroid
                    ? CupertinoIcons.arrow_left
                    : CupertinoIcons.back)),
            title: const Text(
              "Forgot Password",
              style: TextStyle(fontSize: 18),
            ),
            actions: [
              Row(
                children: [
                  Text(
                    "0${_auth.setterIndex.toString()}",
                    style:
                        const TextStyle(color: AppColors.black, fontSize: 16),
                  ),
                  Text(
                    "/0${finalStep.toString()}",
                    style:
                        const TextStyle(color: AppColors.grey150, fontSize: 16),
                  ),
                ],
              ),
              const Gap(10)
            ],
          ),
          body: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: _stepWidget().length > logic.setterIndex
              ? _stepWidget()[logic.setterIndex]
              : _stepWidget()[0],
          ),
        );
      }),
    );
  }
}
