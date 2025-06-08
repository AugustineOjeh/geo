import 'package:flutter/material.dart';
import 'package:grace_ogangwu/constants/sizes.dart';
import 'package:grace_ogangwu/constants/styles.dart';

class SectionHeader {
  static Widget prefix(
    BuildContext context, {
    required String text,
    bool isWhite = false,
  }) => Row(
    mainAxisSize: MainAxisSize.min,
    spacing: 4,
    children: [
      Icon(
        Icons.keyboard_double_arrow_left,
        size: 14,
        color: isWhite ? CustomColors.background : CustomColors.black,
      ),
      Text(
        text,
        style: CustomTextStyle.bodyLarge(
          context,
          color: isWhite ? CustomColors.background : CustomColors.black,
        ),
      ),
      Icon(
        Icons.keyboard_double_arrow_right,
        size: 14,
        color: isWhite ? CustomColors.background : CustomColors.black,
      ),
    ],
  );
  static Widget full(
    BuildContext context, {
    required String prefixText,
    required String headline,
    bool isWhite = false,
  }) => Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    spacing: Spacing.small(context),
    children: [
      prefix(context, text: prefixText, isWhite: isWhite),
      Text(headline, style: CustomTextStyle.headlineLarge(context)),
    ],
  );
}
