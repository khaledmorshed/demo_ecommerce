import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:demo_ecommerce/app/core/base/base_controller.dart';
import 'package:demo_ecommerce/app/data/model/user.dart';
import 'package:demo_ecommerce/app/data/repository/auth/auth_repository.dart';

class AuthController extends BaseController {
  final AuthRepository _authRepository;

  AuthController(this._authRepository);

  final RxnString token = RxnString();
  final Rxn<User> userProfile = Rxn<User>();

  @override
  void onInit() {
    super.onInit();
    _loadToken();
  }

  Future<void> _loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    token.value = prefs.getString('auth_token');
    if (token.value != null) {
      await fetchUserProfile();
    }
  }

  Future<bool> login(String username, String password) async {
    final result = await callDataService(
      _authRepository.login(username, password),
      onSuccess: (response) async {
        if (response.token != null) {
          token.value = response.token;
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('auth_token', response.token!);
          await fetchUserProfile(userId: 1);
        }
      },
    );
    return token.value != null;
  }

  Future<void> fetchUserProfile({int userId = 1}) async {
    await callDataService(
      _authRepository.getUserProfile(userId),
      onSuccess: (user) {
        userProfile.value = user;
      },
      onError: (e) {
        debugPrint('Error fetching profile: $e');
      },
    );
  }

  Future<void> logout() async {
    token.value = null;
    userProfile.value = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
    Get.offAllNamed('/login');
  }

  bool get isLoggedIn => token.value != null;
}
