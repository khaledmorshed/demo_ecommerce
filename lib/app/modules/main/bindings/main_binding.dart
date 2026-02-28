import 'package:get/get.dart';
import 'package:demo_ecommerce/app/modules/home/bindings/home_binding.dart';
import '../controllers/main_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainController>(() => MainController());
    HomeBinding().dependencies();
  }
}
