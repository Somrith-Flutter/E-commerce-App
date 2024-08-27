import 'package:get/get.dart';
import 'package:market_nest_app/app/controllers/auth_controller.dart';
import 'package:market_nest_app/app/controllers/theme_controller.dart';
import 'package:market_nest_app/app/ui/pages/category/controller/category_controller.dart';
import 'package:market_nest_app/app/ui/pages/category/repository/category_repository.dart';

class AppBindings extends Bindings{
  @override
  void dependencies() {
    /// Get.lazyPut(() => WidgetClass())
    Get.lazyPut(() => AuthController());
    Get.lazyPut(() => CategoryController(repository: CategoryRepository()));
    Get.lazyPut(() => ThemeController());
  }
}