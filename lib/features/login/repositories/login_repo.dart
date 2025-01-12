import 'package:boilerplate/core/constants/app_constants.dart';
import 'package:boilerplate/core/data/api/api_client.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  LoginRepo({required this.apiClient, required this.sharedPreferences});

  Future<Response> login({required String email, required String password}) async {
    Map<String, String> body = {
      'email': email,
      'password': password,
      'app_token' : ""
    };

    return apiClient.postData(AppConstants.loginUri, body, baseUrl: AppConstants.loginAppBaseUrl, headers: null);
  }

  Future<void> updateToken(String token) async {
    await sharedPreferences.setString(AppConstants.token, token);
    apiClient.updateHeader(token);
  }

  Future<void> logout() async {
    await sharedPreferences.remove(AppConstants.token);
    apiClient.updateHeader(null);
  }

  String? getToken() {
    return sharedPreferences.getString(AppConstants.token);
  }

  Future<void> saveEmailPassword(String email, String password) async {
    await sharedPreferences.setString(AppConstants.email, email);
    await sharedPreferences.setString(AppConstants.password, password);
  }

  String getEmail() {
    return sharedPreferences.getString(AppConstants.email) ?? '';
  }

  String getPassword() {
    return sharedPreferences.getString(AppConstants.password) ?? '';
  }
}