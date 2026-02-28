import 'package:demo_ecommerce/app/data/model/auth/login_response.dart';
import 'package:demo_ecommerce/app/data/model/user.dart';

abstract class AuthRemoteDataSource {
  Future<LoginResponse> login(String username, String password);
  Future<User> getUserProfile(int userId);
}
