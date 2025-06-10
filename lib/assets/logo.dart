import 'package:flutter/material.dart';
import 'package:grace_ogangwu/constants/styles.dart';

Widget logo(BuildContext context, {required bool isBlack}) => SizedBox(
  child: Column(
    spacing: -2,
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Grace',
        style: CustomTextStyle.headlineMedium(
          context,
          color: isBlack ? null : CustomColors.foreground,
        ),
      ),
      Text(
        'Ogangwu',
        style: CustomTextStyle.headlineMedium(
          context,
          color: isBlack ? null : CustomColors.foreground,
        ),
      ),
    ],
  ),
);
