import 'package:flutter/material.dart';
import 'package:grace_ogangwu/constants/styles.dart';

class CustomSnackbar {
  static main(BuildContext context, {required String message}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: CustomTextStyle.bodyMedium(
            context,
            color: CustomColors.foreground,
          ),
        ),
        duration: Duration(seconds: 4),
        elevation: 8,
        behavior: SnackBarBehavior.floating,
        backgroundColor: CustomColors.text,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        width: 300,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(12),
          side: BorderSide(width: 1, color: CustomColors.foreground),
        ),
      ),
    );
  }
}
