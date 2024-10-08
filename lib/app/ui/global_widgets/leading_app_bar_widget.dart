import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:market_nest_app/app/ui/themes/app_color.dart';

Widget leadingAppBarWidget({required BuildContext cc, Function? handler}){
  return IconButton(
    onPressed: (){
      if(handler != null){
        handler.call();
        return;
      }
      Get.back();
    },
    icon: Icon(
      Platform.isAndroid
          ? CupertinoIcons.arrow_left
          : CupertinoIcons.back,
      color: AppColors.white,
    ));
}