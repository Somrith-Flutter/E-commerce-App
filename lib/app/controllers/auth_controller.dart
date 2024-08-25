import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:market_nest_app/app/data/globle_variable/public_variable.dart';
import 'package:market_nest_app/app/data/models/user_models.dart';
import 'package:market_nest_app/app/data/repositories/auth_repo.dart';

class AuthController extends GetxController {
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmViaPasswordController = TextEditingController();
  final phoneController = TextEditingController(text: "");
  final authRepo = AuthRepo();
  int remainingTime = 0;
  String messages = "";
  List<String> checkServer = [
    'Service Unavailable',
    'Bed Request',
    'Not Found'
  ];
  var verifyCode = "00000";
  String tmpNewToken = "";
  int tempUUId = 0;
  Status status = Status.progress;
  int setterIndex = 0;
  UserModel? userModel;
  bool isConfirm = false;
  UserModel? newUserModel;

  void init() {}

  void resetLimitTimer() async {
    limitTime.$ = 0;
    await limitTime.save();
    update();
  }

  void widgetTrigger(int index) async {
    setterIndex = index;
    update();
  }

  void clearSetter() {
    setterIndex = 1;
    emailController.clear();
    fullNameController.clear();
    confirmViaPasswordController.clear();
    passwordController.clear();
    phoneController.clear();
    verifyCode = "00000";
    isConfirm = false;
    update();
  }

  void checkEmailConfirmation({bool c = false}) {
    isConfirm = c;
    update();
  }

  Future<void> logout() async {
    accessToken.$ = "";
    await accessToken.save();
    timerTrigger();
    update();
  }

  Future<void> loginController() async {
    try {
      final authentication = await authRepo.loginRepo(
          emailAddress: emailController.text,
          password: passwordController.text);

      if (authentication != "") {
        accessToken.$ = authentication;
        await accessToken.save();
        status = Status.success;
      } else {
        status = Status.fail;
      }
    } catch (e) {
      debugPrint("================&&&& $e");
      status = Status.fail;
    } finally {
      update();
    }
  }

  void timerTrigger() async {
    ended.$ = false;
    await ended.save();
    if (limitTime.$ == 4) {
      limitTime.$ = 0;
      await limitTime.save();
    }
    update();
  }

  Future<void> registerController() async {
    try {
      await authRepo
          .registerRepo(
              name: fullNameController.text,
              email: emailController.text,
              password: passwordController.text,
              phone: phoneController.text,
              confirmPassword: confirmViaPasswordController.text)
          .then((data) {
        if (data != null && data['isError'] == false) {
          status = Status.success;
          update();
        } else {
          status = Status.fail;
        }
      });
    } catch (e) {
      debugPrint("========= &&$e");
      status = Status.error;
    }
    update();
  }

  Future<void> forgotPasswordController() async {
    ended.$ = true;
    await ended.save();
    if (limitTime.$ < 4) {
      limitTime.$ += 1;
      await limitTime.save();
    }

    try {
      await authRepo
          .forgotPasswordRepo(email: emailController.text)
          .then((code) {
        if (code != null) {
          verifyCode = code['verify_via_code'];
          tempUUId = code['user_id'];
          status = Status.success;
        } else {
          status = Status.fail;
        }
      });
    } catch (e) {
      debugPrint("error ${e.toString()}");
      status = Status.error;
    } finally {
      update();
    }
  }

  void updatePassword({required String userId}) async {
    try {
      await authRepo
          .resetPassword(
              newPassword: passwordController.text,
              uid: userId,
              confirm: confirmViaPasswordController.text)
          .then((v) {
        if (v != null) {
          debugPrint("============= $v");
          status = Status.success;
        }
        return status = Status.fail;
      });
    } catch (e) {
      status = Status.fail;
    } finally {
      update();
    }
  }

  void getMeController({required String getToken}) async {
    try {
      await authRepo.getMeRepo(userToken: getToken).then((user) {
        if (user != null) {
          newUserModel = user;
          status = Status.success;
        }
      });
    } catch (e) {
      debugPrint("get me catch$e");
    } finally {
      update();
    }
  }

  Future<void> confirmViaEmailController() async {
    try {
      await authRepo.confirmViaEmailRepo(email: emailController.text).then((v) {
        if (v != null && v['isError'] != false) {
          verifyCode = v['code'];
          status = Status.success;
          return;
        }
        status = Status.fail;
      });
    } catch (e) {
      status = Status.error;
      debugPrint(e.toString());
    }
  }

  Future<void> refreshTokenController() async {
    try {
      final token = await authRepo.refreshUserRepo();

      if (token != null && token['isError'] != true) {
        accessToken.$ = token['new_token'];
        await accessToken.save();
        status = Status.success;
      } else {
        status = Status.fail;
      }
    } catch (e) {
      status = Status.error;
      debugPrint("======controller $e");
    } finally {
      update();
    }
  }
}
