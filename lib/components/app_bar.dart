import 'package:flutter/material.dart';
import 'package:grace_ogangwu/assets/logo.dart';
import 'package:grace_ogangwu/components/buttons.dart';
import 'package:grace_ogangwu/constants/keys.dart';
import 'package:grace_ogangwu/constants/sizes.dart';
import 'package:grace_ogangwu/constants/styles.dart';
import 'package:grace_ogangwu/website/pages/auth_page.dart';

class CustomAppBar {
  static Widget dynamic(
    BuildContext context, {
    required void Function(GlobalKey) navigate,
  }) => Device.isMobile(context)
      ? CustomAppBar.mobile(context)
      : Device.isTablet(context)
      ? CustomAppBar.tablet(context, navigate: navigate)
      : CustomAppBar.desktop(context, navigate: navigate);

  /// Wide appBar with middle navbar
  static Widget desktop(
    BuildContext context, {
    required void Function(GlobalKey) navigate,
  }) => SizedBox(
    width: double.infinity,
    child: Row(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      spacing: 24,
      children: [
        logo(context, isBlack: false),
        Expanded(
          child: Center(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32),
                border: Border.all(
                  width: 1,
                  color: CustomColors.foreground.withValues(alpha: 0.2),
                ),
              ),
              child: IntrinsicWidth(
                child: Row(
                  spacing: 16,
                  children: [
                    customTextButton(
                      context,
                      onTap: () => navigate(SectionKeys.aboutMe),
                      text: 'About me',
                    ),
                    customTextButton(
                      context,
                      onTap: () => navigate(SectionKeys.services),
                      text: 'Services',
                    ),
                    customTextButton(
                      context,
                      onTap: () => navigate(SectionKeys.footer),
                      text: 'Contact me',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          child: Row(
            spacing: 16,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // customTextButton(
              //   context,
              //   onTap: () => Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => AppPage(showSignUpWidget: false),
              //     ),
              //   ),
              //   text: 'Sign in',
              //   hasIcon: true,
              // ),
              SizedBox(
                width: 204,
                child: CustomButton.secondary(
                  context,
                  label: 'Book a trial class',
                  onTap: () => navigate(SectionKeys.bookClass),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
  static Widget tablet(
    BuildContext context, {
    required void Function(GlobalKey) navigate,
  }) => SizedBox(
    width: double.infinity,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      spacing: 32,
      children: [
        logo(context, isBlack: false),
        IntrinsicWidth(
          child: Row(
            spacing: 16,
            children: [
              customTextButton(
                context,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AuthPage(showSignUpWidget: false),
                  ),
                ),
                text: 'Sign in',
                hasIcon: true,
              ),
              SizedBox(
                width: 204,
                child: CustomButton.secondary(
                  context,
                  label: 'Book a trial class',
                  onTap: () => navigate(SectionKeys.bookClass),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
  static Widget mobile(BuildContext context) => SizedBox(
    width: double.infinity,
    child: Row(
      spacing: 32,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        logo(context, isBlack: false),
        CustomButton.icon(
          context,
          icon: Icons.dehaze,
          onTap: () {
            // TODO: Open popup menu
          },
        ),
      ],
    ),
  );
  static AppBar app(BuildContext context) => AppBar(
    automaticallyImplyLeading: false,
    backgroundColor: Colors.transparent,
    title: Container(
      margin: EdgeInsets.symmetric(
        horizontal: CustomPadding.pageHorizontal(context),
        vertical: 32,
      ),
      child: logo(context, isBlack: false),
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
          ).copyWith(fontWeight: CustomFontWeight.regular),
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
