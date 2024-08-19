import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:market_nest_app/app/data/globle_variable/public_variable.dart';
import 'package:market_nest_app/app/data/models/user_models.dart';
import 'package:market_nest_app/app/data/repositories/auth_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController{
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmViaPasswordController = TextEditingController();
  final phoneController = TextEditingController(text: "");
  final authRepo = AuthRepo();
  int remainingTime = 0;
  String messages = "";
  List<String> checkServer = ['Service Unavailable', 'Bed Request', 'Not Found'];
  var verifyCode = "00000";
  int tempUUId = 0;
  Status status = Status.progress;
  int setterIndex = 0;
  UserModel? userModel;
  List<UserModel?> newUserModel = [];

  void init(){

  }

  void widgetTrigger(int index) async {
    setterIndex = index;
    update();
  }

  void clearSetter(){
    setterIndex = 1;
    emailController.clear();
    fullNameController.clear();
    confirmViaPasswordController.clear();
    passwordController.clear();
    phoneController.clear();
    update();
  }

  Future<void> loginController() async {
    try{
      final authentication = await authRepo.loginRepo(
          emailAddress: emailController.text,
          password: passwordController.text);

      if(authentication != ""){
        accessToken.$ = authentication;
        await accessToken.save();
        status = Status.success;
      }else{
        status = Status.fail;
      }
    }catch(e){
      debugPrint("================&&&& $e");
      status = Status.fail;
    }finally{
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

    print("========== controller ${ended.$}");
    update();
  }

  Future<void> registerController() async {
    try{
      await authRepo.registerRepo(
        name: fullNameController.text,
        email: emailController.text,
        password: passwordController.text,
        phone: phoneController.text,
        confirmPassword: confirmViaPasswordController.text
      ).then((data){
        if(data.toString().isNotEmpty){
          status = Status.success;
        }else{
          status = Status.fail;
        }
      });
    }catch(e){
      status = Status.fail;
    }finally{
      update();
    }
  }

  void forgotPasswordController() async {
    ended.$ = true;
    await ended.save();

    if(limitTime.$ < 4){
      limitTime.$ += 1;
      await limitTime.save();
    }
    print("=============== ${limitTime.$}");

    try{
      await authRepo.forgotPasswordRepo(email: emailController.text).then((code){
        if(code != null){
          verifyCode = code['verify_via_code'];
          tempUUId = code['user_id'];
          status = Status.success;
        }else{
          status = Status.fail;
        }
      });
    }catch(e){
      debugPrint("error ${e.toString()}");
      status = Status.fail;
    }finally{
      update();
    }
  }

  void updatePassword({required String userId}) async {
    try{
      await authRepo.resetPassword(
        newPassword: passwordController.text,
        uid: userId,
        confirm: confirmViaPasswordController.text).then((v){
          if(v != null){
            print("============= $v");
            status = Status.success;
          }
          return status = Status.fail;
      });
    }catch(e){
      status = Status.fail;
    }finally{
      update();
    }
  }

  void getMeController({required String getToken}) async {
    try{
      await authRepo.getMeRepo(userToken: getToken).then((user){
        if(user != null){
          newUserModel = user;
          status = Status.success;
        }
      });
    }catch(e){
      debugPrint("============= $e");
    }finally{
      update();
    }
  }
}