import 'package:flutter/material.dart';

class Device {
  static double screenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;
  static double screenHeight(BuildContext context) =>
      MediaQuery.of(context).size.width;
  static bool isMobile(BuildContext context) => screenWidth(context) < 600;
  static bool isTablet(BuildContext context) => screenWidth(context) < 1024;
  static isLaptop(BuildContext context) => screenWidth(context) < 1440;
  static bool isDesktop(BuildContext context) => screenWidth(context) >= 1400;
}

class CustomFontFamily {
  static String sans = 'Google Sans';
  static String sansDisplay = 'Google Sans Display';
}

class FontSizes {
  static double title(BuildContext context) => Device.isMobile(context)
      ? 56.00
      : Device.isTablet(context)
      ? 80.00
      : 96.00;

  static double headlineLarge(BuildContext context) => Device.isMobile(context)
      ? 32.00
      : Device.isTablet(context)
      ? 36.00
      : 48.00;

  static double headlineMedium(BuildContext context) => Device.isMobile(context)
      ? 24.00
      : Device.isTablet(context)
      ? 28.00
      : 32.00;

  static double headlineSmall(BuildContext context) => Device.isMobile(context)
      ? 20.00
      : Device.isTablet(context)
      ? 24.00
      : 24.00;

  static double bodyLarge = 18.00;
  static double bodyMedium = 16.00;
  static double bodySmall = 14.00;
}

class CustomFontWeight {
  static FontWeight regular = FontWeight.normal;
  static FontWeight bold = FontWeight.bold;
  static FontWeight medium = FontWeight.w500;
}

class CustomSizes {
  static double partnerLogo(BuildContext context) =>
      Device.isMobile(context) ? 32.00 : 48.00;

  static double borderRadius(BuildContext context) => Device.isMobile(context)
      ? 24.00
      : Device.isTablet(context)
      ? 32.00
      : 48.00;
}

class CustomPadding {
  static double pageHorizontal(BuildContext context) => Device.isMobile(context)
      ? 24.00
      : Device.isTablet(context)
      ? 40.00
      : Device.isLaptop(context)
      ? 64.00
      : 96.00;

  static double sectionVertical(BuildContext context) =>
      Device.isMobile(context)
      ? 40.00
      : Device.isTablet(context)
      ? 56.00
      : 64.00;

  static double containerVertical(BuildContext context) =>
      Device.isMobile(context)
      ? 32.00
      : Device.isTablet(context)
      ? 48.00
      : Device.isLaptop(context)
      ? 56
      : 64.00;

  static double containerHorizontal(BuildContext context) =>
      Device.isMobile(context)
      ? 16.00
      : Device.isTablet(context)
      ? 30.00
      : 56.00;

  static double containerSmall(BuildContext context) => Device.isMobile(context)
      ? 16.00
      : Device.isTablet(context)
      ? 20.00
      : 24.00;
}

class Spacing {
  static double hero(BuildContext context) => Device.isMobile(context)
      ? 180.00
      : Device.isTablet(context)
      ? 240.00
      : Device.isLaptop(context)
      ? 180.00
      : 240.00;
  static double extraLarge(BuildContext context) => Device.isMobile(context)
      ? 56.00
      : Device.isTablet(context)
      ? 64.00
      : Device.isLaptop(context)
      ? 96.00
      : 128.00;
  static double large(BuildContext context) => Device.isMobile(context)
      ? 40.00
      : Device.isTablet(context)
      ? 56.00
      : Device.isLaptop(context)
      ? 64.00
      : 96.00;
  static double medium(BuildContext context) => Device.isMobile(context)
      ? 32.00
      : Device.isTablet(context)
      ? 40.00
      : Device.isLaptop(context)
      ? 48.00
      : 64.00;

  static double small(BuildContext context) => Device.isMobile(context)
      ? 24.00
      : Device.isTablet(context)
      ? 32.00
      : Device.isLaptop(context)
      ? 32.00
      : 32.00;
}
