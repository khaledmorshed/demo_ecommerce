import 'package:demo_ecommerce/app/data/model/auth/login_response.dart';
import 'package:demo_ecommerce/app/data/model/user.dart';
import 'package:demo_ecommerce/app/data/remote/auth/auth_remote_data_source.dart';
import 'auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;

  AuthRepositoryImpl(this._remoteDataSource);

  @override
  Future<LoginResponse> login(String username, String password) {
    return _remoteDataSource.login(username, password);
  }

  @override
  Future<User> getUserProfile(int userId) {
    return _remoteDataSource.getUserProfile(userId);
  }
}
