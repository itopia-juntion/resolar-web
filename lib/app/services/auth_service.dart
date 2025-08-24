import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:resolar_web/app/api_client.dart';
import 'package:resolar_web/app/routes/app_pages.dart';

class AuthService extends GetxService {
  static const String _tokenKey = "access_token";
  static const String _usernameKey = "username";
  static const String _passwordKey = "password";

  GetStorage storage;
  String? _accessToken;

  String? get accessToken => _accessToken;
  String? get username => storage.read(_usernameKey);
  String? get password => storage.read(_passwordKey);

  AuthService(this.storage);

  @override
  void onInit() {
    super.onInit();
    _accessToken = storage.read(_tokenKey);
  }

  bool isLoggedIn() {
    return _accessToken != null;
  }

  void logout() {
    storage.remove(_tokenKey);
    _accessToken = null;

    Get.offAllNamed(Routes.LOGIN);
  }

  Future updateAccessToken(String token) async {
    _accessToken = token;
    await storage.write(_tokenKey, token);
  }

  Future<RequestResult<EmptyBody>> login(
    String username,
    String password,
  ) async {
    await Future.wait([
      storage.write(_usernameKey, username),
      storage.write(_passwordKey, password),
    ]);

    ApiClient ac = Get.find<ApiClient>();
    return await ac.loginAndRefreshToken(username, password);
  }

  Future<RequestResult<EmptyBody>> signUp(
    String username,
    String password,
    String email,
  ) async {
    await Future.wait([
      storage.write(_usernameKey, username),
      storage.write(_passwordKey, password),
    ]);

    ApiClient ac = Get.find<ApiClient>();
    return await ac.signUpAndRefreshToken(username, password, email);
  }
}
