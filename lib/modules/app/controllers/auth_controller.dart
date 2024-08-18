import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:market_nest_app/modules/app/data/globle_variable/public_variable.dart';
import 'package:market_nest_app/modules/app/data/repositories/auth_repo.dart';

class AuthController extends GetxController{
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmViaPasswordController = TextEditingController();
  final phoneController = TextEditingController(text: "");
  final authRepo = AuthRepo();
  String messages = "";
  List<String> checkServer = ['Service Unavailable', 'Bed Request', 'Not Found'];
  var verifyCode = "0000";
  Status status = Status.progress;
  int setterIndex = 1;

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
    try{
      await authRepo.forgotPasswordRepo(email: emailController.text).then((code){
        if(code != null){
          verifyCode = code;
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

  void updatePassword() async {
    try{
      await authRepo.resetPassword(
        newPassword: passwordController.text,
        uid: "1",
        confirm: confirmViaPasswordController.text).then((v){
          if(v != null){
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
}