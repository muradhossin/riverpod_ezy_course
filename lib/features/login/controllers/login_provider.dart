import 'dart:convert';
import 'package:boilerplate/core/constants/app_constants.dart';
import 'package:boilerplate/core/data/api/api_client.dart';
import 'package:boilerplate/core/data/model/response_model.dart';
import 'package:boilerplate/features/login/models/login_state_model.dart';
import 'package:boilerplate/features/login/repositories/login_repo.dart';
import 'package:boilerplate/shared/providers/shared_pref_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginNotifier extends StateNotifier<LoginState> {
  final LoginRepo loginRepo;

  LoginNotifier(this.loginRepo) : super(LoginState());

  Future<ResponseModel> login(String email, String password) async {
    try {
      state = state.copyWith(isLoading: true, errorMessage: '');
      final response = await loginRepo.login(email: email, password: password);

      if (response.statusCode == 200) {
        final token = jsonDecode(response.body)['token'];
        await loginRepo.updateToken(token);

        if (state.rememberMe) {
          await loginRepo.saveEmailPassword(email, password);
        } else {
          await loginRepo.saveEmailPassword('', '');

        }

        initializeCredentials();

        state = state.copyWith(isLoading: false, isSuccess: true);
        return ResponseModel(true, "Login successful");
      } else {
        final errorMsg = jsonDecode(response.body)['msg'];
        state = state.copyWith(isLoading: false, isSuccess: false, errorMessage: errorMsg);
        return ResponseModel(false, errorMsg);
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: "An unexpected error occurred");
      return ResponseModel(false, "An unexpected error occurred");
    }
  }

  Future<void> logout() async {
    await loginRepo.logout();
  }

  void setEmail(String value) {
    state = state.copyWith(email: value);
  }

  void setPassword(String value) {
    state = state.copyWith(password: value);
  }

  void setRememberMe(bool value) {
    state = state.copyWith(rememberMe: value);
  }

  String? getToken() {
    return loginRepo.getToken();
  }

  void initializeCredentials() {
    state = state.copyWith(
      email: loginRepo.getEmail(),
      password: loginRepo.getPassword(),
      rememberMe: loginRepo.getEmail().isNotEmpty,
    );
  }
}

final loginRepoProvider = Provider<LoginRepo>((ref) {
  final sharedPref = ref.watch(sharedPrefProvider);
  final apiClient = ApiClient(appBaseUrl: AppConstants.loginAppBaseUrl, sharedPreferences: sharedPref);
  return LoginRepo(apiClient: apiClient, sharedPreferences: sharedPref);
});

final loginProvider = StateNotifierProvider<LoginNotifier, LoginState>((ref) {
  final loginRepo = ref.watch(loginRepoProvider);
  return LoginNotifier(loginRepo)..initializeCredentials();
});
