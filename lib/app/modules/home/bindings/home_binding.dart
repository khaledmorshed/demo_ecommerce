import 'package:get/get.dart';
import 'package:demo_ecommerce/app/data/remote/product/product_remote_data_source.dart';
import 'package:demo_ecommerce/app/data/remote/product/product_remote_data_source_impl.dart';
import 'package:demo_ecommerce/app/data/repository/product/product_repository.dart';
import 'package:demo_ecommerce/app/data/repository/product/product_repository_impl.dart';
import 'package:demo_ecommerce/app/modules/home/controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductRemoteDataSource>(
      () => ProductRemoteDataSourceImpl(),
    );
    Get.lazyPut<ProductRepository>(
      () => ProductRepositoryImpl(Get.find()),
    );
    Get.lazyPut<HomeController>(
      () => HomeController(Get.find()),
    );
  }
}
