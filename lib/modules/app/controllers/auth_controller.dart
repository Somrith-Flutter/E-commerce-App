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
  Status status = Status.progress;

  void init(){

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
}