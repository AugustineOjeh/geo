import 'package:flutter/material.dart';
import 'package:grace_ogangwu/assets/logo.dart';
import 'package:grace_ogangwu/components/buttons.dart';
import 'package:grace_ogangwu/constants/styles.dart';

class CustomAppBar {
  static AppBar desktop(BuildContext context) => AppBar(
    automaticallyImplyLeading: false,
    backgroundColor: Colors.transparent,
    title: Container(
      margin: EdgeInsets.only(top: 32),
      width: double.infinity,
      child: SizedBox(
        width: double.infinity,
        child: Row(
          children: [
            SizedBox(child: logo(context, isBlack: false)),
            Spacer(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32),
                border: Border.all(
                  width: 1,
                  color: CustomColors.foreground.withValues(alpha: 0.2),
                ),
              ),
              child: Row(
                spacing: 40,
                children: [
                  customTextButton(
                    context,
                    onTap: () {
                      // TODO: Navigate to top
                    },
                    text: 'Home',
                  ),
                  customTextButton(
                    context,
                    onTap: () {
                      // TODO: Navigate to About me
                    },
                    text: 'About me',
                  ),
                  customTextButton(
                    context,
                    onTap: () {
                      // TODO: Navigate to Services
                    },
                    text: 'Services',
                  ),
                  customTextButton(
                    context,
                    onTap: () {
                      // TODO: Open overlay for social contacts
                    },
                    text: 'Contact me',
                  ),
                ],
              ),
            ),
            Spacer(),
            SizedBox(
              child: Row(
                spacing: 32,
                children: [
                  customTextButton(
                    context,
                    onTap: () {
                      // TODO: Implement Auth
                    },
                    text: 'Sign in',
                    hasIcon: true,
                  ),
                  CustomButton.secondary(
                    context,
                    label: 'Book a trial class',
                    onTap: () {
                      // TODO: Implement Auth
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
  static AppBar tablet(BuildContext context) => AppBar(
    automaticallyImplyLeading: false,
    backgroundColor: Colors.transparent,
    title: Container(
      margin: EdgeInsets.only(top: 32),
      width: double.infinity,
      child: SizedBox(
        width: double.infinity,
        child: Row(
          children: [
            SizedBox(child: logo(context, isBlack: false)),
            Spacer(),
            SizedBox(
              child: Row(
                spacing: 32,
                children: [
                  customTextButton(
                    context,
                    onTap: () {
                      // TODO: Implement Auth
                    },
                    text: 'Sign in',
                    hasIcon: true,
                  ),
                  CustomButton.secondary(
                    context,
                    label: 'Book a trial class',
                    onTap: () {
                      // TODO: Implement Auth
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
  static AppBar mobile(BuildContext context) => AppBar(
    automaticallyImplyLeading: false,
    backgroundColor: Colors.transparent,
    title: Container(
      margin: EdgeInsets.only(top: 32),
      width: double.infinity,
      child: SizedBox(
        width: double.infinity,
        child: Row(
          children: [
            SizedBox(child: logo(context, isBlack: false)),
            Spacer(),
            SizedBox(
              child: CustomButton.icon(
                context,
                icon: Icons.dehaze,
                onTap: () {
                  // TODO: Open popup menu
                },
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget customTextButton(
  BuildContext context, {
  required VoidCallback onTap,
  required String text,
  bool hasIcon = false,
}) => TextButton(
  onPressed: onTap,
  style: TextButton.styleFrom(
    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    backgroundColor: Colors.transparent,
    visualDensity: VisualDensity.compact,
    shadowColor: Colors.transparent,
    elevation: 0,
    overlayColor: Colors.transparent,
  ),
  child: !hasIcon
      ? Text(
          text,
          style: CustomTextStyle.bodyMedium(
            context,
            color: CustomColors.background,
          ),
        )
      : Row(
          spacing: 12,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              text,
              style: CustomTextStyle.bodyMedium(
                context,
                color: CustomColors.background,
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: CustomColors.background,
            ),
          ],
        ),
);
