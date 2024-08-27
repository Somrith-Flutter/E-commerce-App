import 'package:get/get.dart';
import 'package:market_nest_app/app/controllers/auth_controller.dart';
import 'package:market_nest_app/app/controllers/theme_controller.dart';
import 'package:market_nest_app/app/ui/pages/category/controller/category_controller.dart';
import 'package:market_nest_app/app/ui/pages/category/repository/category_repository.dart';
import 'package:market_nest_app/app/ui/pages/home/controller/home_controller.dart';
import 'package:market_nest_app/app/ui/pages/home/repository/home_repository.dart';
import 'package:market_nest_app/app/ui/pages/product/controller/product_controller.dart';
import 'package:market_nest_app/app/ui/pages/product/repository/product_repository.dart';
import 'package:market_nest_app/app/ui/pages/sub_category/controller/sub_category_controller.dart';
import 'package:market_nest_app/app/ui/pages/sub_category/repository/sub_category_repository.dart';

class AppBindings extends Bindings{
  @override
  void dependencies() {
    /// Get.lazyPut(() => WidgetClass())
    Get.lazyPut(() => AuthController());
    Get.lazyPut(() => CategoryController(repository: CategoryRepository()));
    Get.lazyPut(() => ThemeController());
    Get.lazyPut(() => HomeController(repository: HomeRepository()));
    Get.lazyPut(() => SubCategoryController(repository: SubCategoryRepository()));
    Get.lazyPut(() => ProductController(repository: ProductRepository()));
  }
}