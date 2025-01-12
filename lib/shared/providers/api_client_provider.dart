import 'package:boilerplate/core/constants/app_constants.dart';
import 'package:boilerplate/core/data/api/api_client.dart';
import 'package:boilerplate/shared/providers/shared_pref_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final apiClientProvider = Provider<ApiClient>((ref) {
  final sharedPref = ref.watch(sharedPrefProvider);
  return ApiClient(appBaseUrl: AppConstants.appBaseUrl, sharedPreferences: sharedPref);
});