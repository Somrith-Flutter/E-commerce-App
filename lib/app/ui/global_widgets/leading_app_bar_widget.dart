import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:market_nest_app/app/ui/themes/app_color.dart';

Widget leadingAppBarWidget({required BuildContext cc, Function? handler, bool background = false}){
  return IconButton(
    onPressed: (){
      if(handler != null){
        handler.call();
        return;
      }
      Get.back();
    },
    icon: Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: background ? Colors.grey.withOpacity(0.7) : Colors.transparent
      ),
      child: Icon(
        Platform.isAndroid
          ? CupertinoIcons.arrow_left
          : CupertinoIcons.back,
        color: AppColors.white,
      ),
    ));
}