import 'package:get/get.dart';
import 'package:demo_ecommerce/app/data/remote/auth/auth_remote_data_source.dart';
import 'package:demo_ecommerce/app/data/remote/auth/auth_remote_data_source_impl.dart';
import 'package:demo_ecommerce/app/data/repository/auth/auth_repository.dart';
import 'package:demo_ecommerce/app/data/repository/auth/auth_repository_impl.dart';
import 'package:demo_ecommerce/app/modules/auth/controllers/auth_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(),
    );
    Get.lazyPut<AuthRepository>(
      () => AuthRepositoryImpl(Get.find()),
    );
    Get.put<AuthController>(
      AuthController(Get.find()),
      permanent: true,
    );
  }
}
