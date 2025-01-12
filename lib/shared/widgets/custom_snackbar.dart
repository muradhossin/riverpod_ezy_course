
import 'package:boilerplate/main.dart';
import 'package:boilerplate/shared/utils/dimensions.dart';
import 'package:boilerplate/shared/utils/styles.dart';
import 'package:flutter/material.dart';

void showCustomSnackbar({
  required String? message,
  BuildContext? context,
  bool isError = false,
}) {
  scaffoldMessengerKey.currentState?.showSnackBar(
    SnackBar(
      dismissDirection: DismissDirection.horizontal,
      margin: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall, vertical: Dimensions.paddingSizeSmall),
      duration: const Duration(seconds: 3),
      backgroundColor: isError ? Colors.red : Colors.green,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.radiusSmall)),
      content: Text(message ?? '', style: fontMedium.copyWith(color: Colors.white)),
    ),
  );
}

