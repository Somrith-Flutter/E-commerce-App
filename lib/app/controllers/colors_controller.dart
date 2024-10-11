import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:market_nest_app/app/data/globle_variable/public_variable.dart';
import 'package:market_nest_app/app/data/models/colors_model.dart';
import 'package:market_nest_app/app/data/repositories/colors_repo.dart';

class ColorsController extends GetxController implements GetxService {
  var modelColors = <ColorsModel>[].obs;
  final repository = ColorsRepository();
  var status = Status.progress.obs;

  void listColorController({required String productIds}) async {
    status.value = Status.progress;
    try {
      await repository.listColorRepository(productIds: productIds).then((data) {
        if (data.isNotEmpty) {
          modelColors.value = data;
          status.value = Status.success;
          update();
        }else {
          status.value = Status.fail;
          update();
        }
      });
    } catch (err) {
      status.value = Status.error;
      update();
      if (kDebugMode) {
        print("list color error in controller $err");
      }
    }
  }
}