import 'package:get/get.dart';
import 'package:market_nest_app/modules/app/controllers/auth_controller.dart';

class AppBindings extends Bindings{
  @override
  void dependencies() {
    /// Get.lazyPut(() => WidgetClass())
    Get.lazyPut(() => AuthController());
  }
}