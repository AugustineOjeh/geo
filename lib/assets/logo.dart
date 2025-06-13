import 'package:flutter/material.dart';
import 'package:grace_ogangwu/constants/sizes.dart';
import 'package:grace_ogangwu/constants/styles.dart';

Widget logo(BuildContext context, {required bool isBlack}) => SizedBox(
  child: Column(
    spacing: 0,
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Grace',
        style:
            CustomTextStyle.headlineMedium(
              context,
              color: isBlack ? null : CustomColors.foreground,
            ).copyWith(
              fontWeight: CustomFontWeight.regular,
              height: 0.68,
              letterSpacing: FontSizes.headlineMedium(context) * -0.05,
            ),
      ),
      Text(
        'Ogangwu',
        style:
            CustomTextStyle.headlineMedium(
              context,
              color: isBlack ? null : CustomColors.foreground,
            ).copyWith(
              fontWeight: CustomFontWeight.regular,
              height: 0.68,
              letterSpacing: FontSizes.headlineMedium(context) * -0.05,
            ),
      ),
    ],
  ),
);
