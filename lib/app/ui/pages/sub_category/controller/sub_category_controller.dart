import 'package:get/get.dart';
import 'package:market_nest_app/app/ui/pages/sub_category/model/sub_category_model.dart';
import 'package:market_nest_app/app/ui/pages/sub_category/repository/sub_category_repository.dart';

class SubCategoryController extends GetxController {
  final SubCategoryRepository repository;

  SubCategoryController({required this.repository});

  var subCategories = <SubCategoryModel>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchSubCategories();
  }

  void fetchSubCategories({int? categoryId}) async {
    try {
      isLoading(true);
      subCategories.value = await repository.fetchSubCategories(categoryId: categoryId);
    } catch (e) {
      Get.snackbar('Error', 'Failed to load sub-categories');
    } finally {
      isLoading(false);
    }
  }
}
