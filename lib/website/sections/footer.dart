import 'package:flutter/material.dart';
import 'package:grace_ogangwu/assets/logo.dart';
import 'package:grace_ogangwu/components/buttons.dart';
import 'package:grace_ogangwu/constants/constants.dart';
import 'package:grace_ogangwu/website/widgets/newsletter_subscription.dart';
import 'package:ionicons/ionicons.dart';

class Footer extends StatelessWidget {
  const Footer({required this.backToTop, required this.navigate, super.key});
  final VoidCallback backToTop;
  final void Function(GlobalKey) navigate;

  @override
  Widget build(BuildContext context) => Container(
    constraints: BoxConstraints(maxWidth: 1500),
    padding: EdgeInsets.only(
      left: CustomPadding.pageHorizontal(context),
      right: CustomPadding.pageHorizontal(context),
      top: CustomPadding.sectionVertical(context),
    ),
    child: Device.isMobile(context)
        ? _mobileView(context, backToTop: backToTop, navigate: navigate)
        : _desktopView(context, backToTop: backToTop, navigate: navigate),
  );
}

Widget _mobileView(
  BuildContext context, {
  required VoidCallback backToTop,
  required void Function(GlobalKey) navigate,
}) => Column(
  mainAxisSize: MainAxisSize.min,
  spacing: 64,
  children: [
    _cta(context, navigate: navigate),
    Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(16, 48, 16, 24),
      decoration: BoxDecoration(
        color: CustomColors.black,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 48,
        children: [
          NewsletterSubscription(),
          _footerLogo(context),
          Container(
            width: double.infinity,
            height: 1,
            color: CustomColors.background.withValues(alpha: 0.15),
          ),
          Center(
            child: Column(
              spacing: 16,
              children: [
                Text(
                  'Copyright © OCCL, ${DateTime.now().year.toString()}',
                  style: CustomTextStyle.bodyMedium(context),
                ),
                GestureDetector(
                  onTap: backToTop,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    spacing: 12,
                    children: [
                      Text(
                        'Back to top',
                        style: CustomTextStyle.bodyMedium(context),
                      ),
                      CustomButton.icon(
                        context,
                        onTap: backToTop,
                        icon: Icons.arrow_upward,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  ],
);

Widget _desktopView(
  BuildContext context, {
  required VoidCallback backToTop,
  required void Function(GlobalKey) navigate,
}) => Padding(
  padding: const EdgeInsets.only(top: 200),
  child: Stack(
    clipBehavior: Clip.none,
    children: [
      Container(
        width: double.infinity,
        padding: EdgeInsets.fromLTRB(40, 200, 40, 32),
        decoration: BoxDecoration(
          color: CustomColors.black,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 40,
          children: [
            Row(
              spacing: 48,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _footerLogo(context),
                Spacer(),
                Flexible(child: NewsletterSubscription()),
              ],
            ),
            Container(
              width: double.infinity,
              height: 1,
              color: CustomColors.background.withValues(alpha: 0.15),
            ),
            Row(
              spacing: 48,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Copyright © OCCL, ${DateTime.now().year.toString()}',
                  style: CustomTextStyle.bodyMedium(context),
                ),
                Spacer(),
                GestureDetector(
                  onTap: backToTop,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    spacing: 12,
                    children: [
                      Text(
                        'Back to top',
                        style: CustomTextStyle.bodyMedium(context),
                      ),
                      CustomButton.icon(
                        context,
                        onTap: backToTop,
                        icon: Icons.arrow_upward,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      Positioned(
        top: Device.isTablet(context) ? -200 : -220,
        left: 0,
        right: 0,
        child: Center(child: _cta(context, navigate: navigate)),
      ),
    ],
  ),
);

Widget _footerLogo(BuildContext context) => SizedBox(
  width: 240,
  child: Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    spacing: 16,
    children: [
      logo(context, isBlack: false),
      Row(
        spacing: 12,
        children: [
          CustomButton.footerSocials(
            context,
            icon: Ionicons.logo_linkedin,
            url: '#',
          ),
          CustomButton.footerSocials(
            context,
            icon: Ionicons.logo_facebook,
            url: '#',
          ),
          CustomButton.footerSocials(
            context,
            icon: Ionicons.logo_instagram,
            url: '#',
          ),
          CustomButton.footerSocials(
            context,
            icon: Ionicons.logo_youtube,
            url: '#',
          ),
          CustomButton.footerSocials(
            context,
            icon: Ionicons.logo_tiktok,
            url: '#',
          ),
        ],
      ),
      Text(
        'Managed by Ojehs, Inc. (a subsidiary of OCCL)',
        style: CustomTextStyle.bodyMedium(context),
      ),
    ],
  ),
);

Widget _cta(
  BuildContext context, {
  required void Function(GlobalKey) navigate,
}) => Container(
  width: double.infinity,
  margin: Device.isMobile(context)
      ? null
      : EdgeInsets.symmetric(horizontal: Device.isTablet(context) ? 40 : 96),
  padding: EdgeInsets.symmetric(
    horizontal: CustomPadding.pageHorizontal(context),
    vertical: Spacing.large(context),
  ),
  alignment: Alignment.centerLeft,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(32),
    image: DecorationImage(
      image: AssetImage('lib/assets/images/footer_background.png'),
      fit: BoxFit.fill,
    ),
  ),
  child: SizedBox(
    width: Device.isMobile(context)
        ? double.infinity
        : Device.isTablet(context)
        ? 400
        : 500,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      spacing: 40,
      children: [
        Text(
          'Give the gift of English Literacy',
          style: CustomTextStyle.headlineMedium(context).copyWith(
            fontSize: Device.isMobile(context) || Device.isTablet(context)
                ? 48
                : 64,
            color: CustomColors.foreground,
          ),
        ),
        SizedBox(
          width: 320,
          child: CustomButton.primary(
            context,
            label: 'Book the first class 50% OFF',
            onTap: () => navigate(SectionKeys.bookClass),
          ),
        ),
      ],
    ),
  ),
);
