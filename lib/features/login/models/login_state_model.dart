import 'package:freezed_annotation/freezed_annotation.dart';
part 'login_state_model.freezed.dart';
part 'login_state_model.g.dart';

@freezed
class LoginState with _$LoginState {
  const factory LoginState({
    @Default('') String email,
    @Default('') String password,
    @Default(false) bool isLoading,
    @Default(false) bool isSuccess,
    @Default(false) bool rememberMe,
    @Default('') String errorMessage,
  }) = _LoginState;

  factory LoginState.fromJson(Map<String, dynamic> json) => _$LoginStateFromJson(json);
}