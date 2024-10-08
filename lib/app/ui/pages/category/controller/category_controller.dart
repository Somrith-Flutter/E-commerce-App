import 'package:get/get.dart';
import 'package:market_nest_app/app/ui/pages/category/repository/category_repository.dart';
import 'package:market_nest_app/app/ui/pages/category/model/category_model.dart';

class CategoryController extends GetxController {
  final CategoryRepository repository;

  CategoryController({required this.repository});

  var categories = <CategoryModel>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    // fetchCategories();
  }

  void fetchCategories() async {
    try {
      isLoading(true);
      categories.value = await repository.fetchCategories();
    } catch (e) {
      Get.snackbar('Error', 'Failed to load categories');
    } finally {
      isLoading(false);
    }
    update();
  }
}
