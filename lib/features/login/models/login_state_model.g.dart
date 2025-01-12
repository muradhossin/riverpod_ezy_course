// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_state_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LoginStateImpl _$$LoginStateImplFromJson(Map<String, dynamic> json) =>
    _$LoginStateImpl(
      email: json['email'] as String? ?? '',
      password: json['password'] as String? ?? '',
      isLoading: json['isLoading'] as bool? ?? false,
      isSuccess: json['isSuccess'] as bool? ?? false,
      rememberMe: json['rememberMe'] as bool? ?? false,
      errorMessage: json['errorMessage'] as String? ?? '',
    );

Map<String, dynamic> _$$LoginStateImplToJson(_$LoginStateImpl instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
      'isLoading': instance.isLoading,
      'isSuccess': instance.isSuccess,
      'rememberMe': instance.rememberMe,
      'errorMessage': instance.errorMessage,
    };
