import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:demo_ecommerce/app/core/values/app_colors.dart';

customSnackBar(String? message, {Color backGroundColor = AppColors.appPrimaryColorDark}) {
  return ScaffoldMessenger.of(Get.context!)..removeCurrentSnackBar()..showSnackBar(
    SnackBar(
      backgroundColor: backGroundColor,
      duration: const Duration(milliseconds: 1500),
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(10.0),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(message.toString(), maxLines: 2),
          ),
        ],
      ),
    ),
  );
}
