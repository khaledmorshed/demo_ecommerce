import 'package:demo_ecommerce/app/core/base/base_remote_source.dart';
import 'package:demo_ecommerce/app/data/model/auth/login_response.dart';
import 'package:demo_ecommerce/app/data/model/user.dart';
import 'auth_remote_data_source.dart';

class AuthRemoteDataSourceImpl extends BaseRemoteSource implements AuthRemoteDataSource {
  @override
  Future<LoginResponse> login(String username, String password) async {
    var endpoint = "https://fakestoreapi.com/auth/login";
    var data = {
      "username": username,
      "password": password
    };
    var dioCall = dioClient.post(endpoint, data: data);

    try {
      final response = await callApiWithErrorParser(dioCall);
      return LoginResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<User> getUserProfile(int userId) async {
    var endpoint = "https://fakestoreapi.com/users/$userId";
    var dioCall = dioClient.get(endpoint);

    try {
      final response = await callApiWithErrorParser(dioCall);
      return User.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
