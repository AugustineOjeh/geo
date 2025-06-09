import 'package:flutter/material.dart';
import 'package:grace_ogangwu/constants/sizes.dart';

class CustomColors {
  static Color primary = Color(0xFF8259D4);
  static Color secondary = Color(0xFF5D42A4);
  static Color background = Color(0xFFF3F3F3);
  static Color foreground = Color(0xFFFFFFFF);
  static Color black = Color(0xFF000000);
  static Color text = Color(0xFF707070);
}

class CustomTextStyle {
  static TextStyle bodyMedium(BuildContext context, {Color? color}) =>
      TextStyle(
        fontSize: FontSizes.bodyMedium,
        fontFamily: CustomFontFamily.sans,
        color: color ?? CustomColors.text,
      );

  static TextStyle bodyLarge(BuildContext context, {Color? color}) => TextStyle(
    fontSize: FontSizes.bodyLarge,
    fontFamily: CustomFontFamily.sans,
    color: color ?? CustomColors.text,
  );

  static TextStyle headlineSmall(BuildContext context, {Color? color}) =>
      TextStyle(
        fontSize: FontSizes.headlineSmall(context),
        letterSpacing: FontSizes.headlineMedium(context),
        fontFamily: CustomFontFamily.sans,
        color: color ?? CustomColors.black,
      );

  static TextStyle headlineMedium(BuildContext context, {Color? color}) =>
      TextStyle(
        fontSize: FontSizes.headlineMedium(context),
        fontFamily: CustomFontFamily.sansDisplay,
        letterSpacing: FontSizes.headlineMedium(context) * 0.05,
        height: 0.9,
        color: color ?? CustomColors.black,
      );

  static TextStyle headlineLarge(BuildContext context) => TextStyle(
    fontSize: FontSizes.headlineLarge(context),
    fontFamily: CustomFontFamily.sansDisplay,
    letterSpacing: FontSizes.headlineMedium(context) * 0.05,
    height: 0.9,
    color: CustomColors.black,
  );

  static TextStyle title(BuildContext context, {Color? color}) => TextStyle(
    fontSize: FontSizes.title(context),
    fontFamily: CustomFontFamily.sansDisplay,
    letterSpacing: FontSizes.headlineMedium(context) * 0.05,
    height: 0.9,
    color: color ?? CustomColors.foreground,
  );
}
