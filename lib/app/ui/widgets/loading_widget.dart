import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:market_nest_app/app/ui/themes/app_color.dart';

void showLoadingDialog(BuildContext context, {required String label}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return WillPopScope(
        onWillPop: () async => false,
        child: Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                LoadingAnimationWidget.discreteCircle(
                  color: AppColors.cyan,
                  secondRingColor: AppColors.blue,
                  thirdRingColor: Colors.blueAccent,
                  size: 50,
                ),
                const SizedBox(height: 20),
                Text(
                  label,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}