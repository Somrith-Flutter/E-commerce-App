import 'package:flutter/material.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:market_nest_app/config/themes/app_color.dart';
import 'package:market_nest_app/modules/app/controllers/auth_controller.dart';
import 'package:pinput/pinput.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PinPutCode extends StatefulWidget {
  const PinPutCode({super.key});

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

  @override
  void dispose() {
    pinCodeController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  void _blockAttempts() {
    setState(() {
      _isBlocked = true;
      _unblockTime = DateTime.now().add(const Duration(minutes: 5));
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
      if(!_isBlocked){
        _incorrectAttempts = 0;
        return null;
      }
    } else {
      _incorrectAttempts++;
      _saveBlockState();

      if (_incorrectAttempts >= 3) {
        _blockAttempts();
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
    _checkCodePermission();
    _loadBlockState();
  }

  void _checkCodePermission(){
    if(picController.verifyCode != "0000"){
      WidgetsBinding.instance.addPostFrameCallback((_) {
        IconSnackBar.show(
          context,
          label: 'Verify code has been sent',
          snackBarType: SnackBarType.alert,
          duration: const Duration(seconds: 5),
        );
      });
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
                  GestureDetector(
                    onTap: () async {
                      try{
                        picController.forgotPasswordController();
                        Future.delayed(const Duration(milliseconds: 200), (){
                          _checkCodePermission();
                        });
                      }catch(_){}
                    },
                    child: Text("Resend Code".tr,
                      style: const TextStyle(
                        color: AppColors.cyan,
                        fontSize: 16,
                        decoration: TextDecoration.underline,
                        decorationColor: AppColors.cyan,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Gap(50),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: () {
                        if(pinCodeController.text  == picController.verifyCode){
                          picController.widgetTrigger(3);
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