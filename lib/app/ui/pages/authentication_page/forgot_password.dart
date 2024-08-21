import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:market_nest_app/app/ui/themes/app_color.dart';
import 'package:market_nest_app/app/controllers/auth_controller.dart';
import 'package:market_nest_app/app/ui/global_widgets/confirm_email_widget.dart';
import 'package:market_nest_app/app/ui/global_widgets/pin_put_code_widget.dart';
import 'package:market_nest_app/app/ui/global_widgets/set_new_pass_widget.dart';

class ForgotPasswordScreen extends StatefulWidget {
  final int? fixedWidget;
  final bool ? isFromChangePassword;
  const ForgotPasswordScreen({super.key, this.fixedWidget = 0, this.isFromChangePassword = false});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  int finalStep = 3;
  final _auth = Get.find<AuthController>();

  List<Widget> _stepWidget() {
    return [
      const ConfirmEmailWidget(),
      PinPutCode(confirmMailBeforeFirst: widget.fixedWidget != 0 ? true : false),
      const SetNewPassWidget(),
    ];
  }

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 100), () {
      widget.fixedWidget != 0 ?
      _auth.widgetTrigger(widget.fixedWidget??0) : _auth.widgetTrigger(0);
    });
    appBarTextTriggle();
    super.initState();
  }

  String appBarTextTriggle() {
    if(widget.fixedWidget == 0 && widget.isFromChangePassword == false) return "Forget Password";
    if(widget.fixedWidget == 0 && widget.isFromChangePassword == true) return "Change Password";
    return "Verify Email";
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
            title: Text( appBarTextTriggle(),
              style: const TextStyle(fontSize: 18),
            ),
            actions: [
              if(widget.fixedWidget != 0)
                const SizedBox()
              else
                Row(
                children: [
                  Text(
                    "0${_auth.setterIndex+1}",
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
