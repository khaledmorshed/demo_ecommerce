import 'package:flutter/material.dart';
import 'package:demo_ecommerce/app/core/values/app_colors.dart';

class CustomCircularProgressIndicator extends StatelessWidget {
  final Color? color;
  const CustomCircularProgressIndicator({super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: color ?? AppColors.appPrimaryColor,
        strokeWidth: 2,
      ),
    );
  }
}
