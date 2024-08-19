import 'package:flutter/material.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:market_nest_app/app/ui/themes/app_color.dart';
import 'package:market_nest_app/app/controllers/auth_controller.dart';
import 'package:market_nest_app/app/data/globle_variable/public_variable.dart';
import 'package:market_nest_app/app/ui/pages/authentication_page/forgot_password.dart';
import 'package:market_nest_app/app/ui/global_widgets/loading_widget.dart';
import 'package:market_nest_app/app/data/helpers.dart';
import 'package:pinput/pinput.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timer_count_down/timer_count_down.dart';

class PinPutCode extends StatefulWidget {
  final bool confirmMailBeforeFirst;
  const PinPutCode({super.key, this.confirmMailBeforeFirst = false});

  @override
  State<PinPutCode> createState() => _PinPutCodeState();
}

class _PinPutCodeState extends State<PinPutCode> {
  final pinCodeController = TextEditingController();
  final focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();
  final picController = Get.find<AuthController>();
  int _incorrectAttempts = 0;
  bool _isBlocked = false;
  final bool _isDisposed = false;
  DateTime? _unblockTime;
  String? _errorMessage;
  String? _tempCode;

  @override
  void dispose() {
    pinCodeController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  void _blockAttempts(int value) {
    setState(() {
      _isBlocked = true;
      _unblockTime = DateTime.now().add(Duration(minutes: value));
    });

    Future.delayed(const Duration(minutes: 5), () {
      setState(() {
        _isBlocked = false;
        _incorrectAttempts = 0;
      });
    });
  }

  Future<void> _loadBlockState() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _incorrectAttempts = prefs.getInt('incorrectAttempts') ?? 0;
      final unblockTimeString = prefs.getString('unblockTime');
      if (unblockTimeString != null) {
        _unblockTime = DateTime.parse(unblockTimeString);
        if (_unblockTime!.isAfter(DateTime.now())) {
          _isBlocked = true;
          _scheduleUnblock();
        } else {
          _isBlocked = false;
          _incorrectAttempts = 0;
        }
      }
    });
  }

  Future<void> _saveBlockState() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('incorrectAttempts', _incorrectAttempts);
    if (_unblockTime != null) {
      await prefs.setString('unblockTime', _unblockTime!.toIso8601String());
    } else {
      await prefs.remove('unblockTime');
    }
  }

  String? getterVerifyCode({String? code}){
    return _tempCode = code.toString();
  }

  void _scheduleUnblock() {
    final duration = _unblockTime!.difference(DateTime.now());
    Future.delayed(duration, () {
      if (_isDisposed) return;
      setState(() {
        _isBlocked = false;
        _incorrectAttempts = 0;
      });
      _saveBlockState();
    });
  }

  String? _validatePin(String? value) {
    if (value == picController.verifyCode) {
      getterVerifyCode(code: value);
      setState(() {});
      if(!_isBlocked){
        _incorrectAttempts = 0;
        return null;
      }
    } else {
      _incorrectAttempts++;
      _saveBlockState();

      if (_incorrectAttempts >= 3) {
        _blockAttempts(5);
        _errorMessage = "Too many incorrect attempts. Try again in 5 minutes.";
      } else if (_incorrectAttempts == 2) {
        setState(() {
          _errorMessage = "Pin is incorrect. You have 1 more attempt before being blocked.";
        });
        return null;
      } else {
        setState(() {
          _errorMessage = "Pin is incorrect. You have ${3 - _incorrectAttempts} more attempts.";
        });
        return null;
      }
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    _loadBlockState();
  }

  void _checkCodePermission(){
    if(picController.verifyCode != "00000"){
      IconSnackBar.show(
        context,
        label: 'Verify code has been sent',
        snackBarType: SnackBarType.alert,
        duration: const Duration(seconds: 5),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    const focusedBorderColor = Color.fromRGBO(23, 171, 144, 1);
    const fillColor = Color.fromRGBO(243, 246, 249, 0);
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Color.fromRGBO(30, 60, 87, 1),
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          color: Colors.black.withOpacity(0.1)
      ),
    );
    final CountdownTimer countdownTimer = CountdownTimer();
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        body: GetBuilder<AuthController>(builder: (logic) {
          return SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Email Verification",
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      Gap(15),
                      Text("Enter the 4 digits verification code send to your email address",
                        style: TextStyle(fontSize: 16, color: AppColors.grey150),
                      ),
                    ]),
                  const Gap(50),
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: Pinput(
                      controller: pinCodeController,
                      focusNode: focusNode,
                      defaultPinTheme: defaultPinTheme,
                      separatorBuilder: (index) => const SizedBox(width: 8),
                      validator: _validatePin,
                      hapticFeedbackType: HapticFeedbackType.lightImpact,
                      cursor: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 9),
                            width: 22,
                            height: 1,
                            color: Colors.black.withOpacity(0.1),
                          ),
                        ],
                      ),
                      focusedPinTheme: defaultPinTheme.copyWith(
                        decoration: defaultPinTheme.decoration!.copyWith(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: focusedBorderColor),
                        ),
                      ),
                      submittedPinTheme: defaultPinTheme.copyWith(
                        decoration: defaultPinTheme.decoration!.copyWith(
                          color: fillColor,
                          borderRadius: BorderRadius.circular(7),
                          border: Border.all(color: focusedBorderColor),
                        ),
                      ),
                      errorPinTheme: defaultPinTheme.copyBorderWith(
                        border: Border.all(color: Colors.redAccent),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        if (_isBlocked)...[
                          const Text(
                            "Too many incorrect attempts. Try again in 5 minutes later.",
                            style: TextStyle(color: Colors.red, fontSize: 14.0,),
                          ),
                        ]else ...[
                          if(_errorMessage != null)
                            Text(
                              _errorMessage!,
                              style: const TextStyle(fontSize: 14.0, color: Colors.red),
                            ),
                        ]
                      ],
                    ),
                  ),

                  if(ended.$ == true)...[
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
                        return Text(
                          'Code Expires In ${remainingTime.inSeconds.remainder(60).toString().padLeft(2, '0')}s',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      },
                    )
                  ]else...[
                    GestureDetector(
                      onTap: () async {
                        try{
                          picController.forgotPasswordController();
                          showLoadingDialog(context, label: "Resending...");
                          Future.delayed(const Duration(milliseconds: 200), (){
                            _checkCodePermission();
                            setState(() {});
                          });
                        }catch(_){}finally{
                          Get.back();
                        }
                      },
                      child: const Text("Resend Code",
                        style: TextStyle(
                          color: AppColors.cyan,
                          fontSize: 16,
                          decoration: TextDecoration.underline,
                          decorationColor: AppColors.cyan,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                  const Gap(50),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: () async {
                        if(widget.confirmMailBeforeFirst){
                          if(picController.verifyCode == _tempCode){
                            showLoadingDialog(context, label: "Verifying...");

                            await Future.delayed(const Duration(milliseconds: 500), (){
                              Get.back();
                              Get.back();
                              Get.back();
                              IconSnackBar.show(
                                context,
                                label: 'Success',
                                snackBarType: SnackBarType.success,
                                duration: const Duration(seconds: 3),
                              );
                              picController.checkEmailConfirmation(c: true);
                              picController.resetLimitTimer();
                            });
                          }
                          return;
                        }
                        if(pinCodeController.text  == picController.verifyCode){
                          picController.resetLimitTimer();
                          picController.widgetTrigger(2);
                          picController.checkEmailConfirmation(c: false);
                        }else{
                          IconSnackBar.show(
                            context,
                            label: 'Code is incorrect',
                            snackBarType: SnackBarType.fail,
                            duration: const Duration(seconds: 3),
                          );
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
                        "Process",
                        style: TextStyle(fontSize: 18, color: AppColors.white),
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