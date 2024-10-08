import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:market_nest_app/app/data/globle_variable/public_variable.dart';
import 'package:market_nest_app/app/ui/pages/sub_category/model/sub_category_model.dart';
import 'package:market_nest_app/app/ui/pages/sub_category/repository/sub_category_repository.dart';

class SubCategoryController extends GetxController {
  final SubCategoryRepository repository;

  SubCategoryController({required this.repository});

  var subCategories = <SubCategoryModel>[].obs;
  var slideBanner = <SubCategoryModel>[].obs;
  var isLoading = true.obs;
  var status = Status.fail;

  void fetchSubCategories({int? categoryId}) async {
    try {
      isLoading(true);
      subCategories.value = await repository.fetchSubCategories(categoryId: categoryId);
    } catch (e) {
      Get.snackbar('Warning', 'Unable to load sub-categories');
    } finally {
      isLoading(false);
    }
  }

  void getSlide({required String? active}) async {
    try {
      slideBanner.value = await repository.getBannerSlideRepository(active: active.toString());

      if(slideBanner.isNotEmpty){
        status = Status.success;
      }else{
        status = Status.fail;
      }
      update();
    } catch (e) {
      status = Status.error;
      if (kDebugMode) {
        print("error in controller $e");
      }
    }
  }
}
