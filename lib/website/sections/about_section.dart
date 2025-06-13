import 'package:flutter/material.dart';
import 'package:grace_ogangwu/components/buttons.dart';
import 'package:grace_ogangwu/components/section_header.dart';
import 'package:grace_ogangwu/constants/sizes.dart';
import 'package:grace_ogangwu/constants/styles.dart';

const String _headline = 'Grace\'s experience & expertise';

const String _aboutText =
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse a purus id justo egestas fermentum dictum ut arcu. Donec at ipsum quis dui ullamcorper suscipit vitae et ex. Integer ut purus tempor, tristique augue vehicula, pulvinar dolor. Pellentesque posuere sem ac suscipit sodales. \n\nIn congue facilisis nibh porttitor sagittis. Aliquam imperdiet justo eu imperdiet interdum. Ut non risus purus. Duis metus arcu, egestas sed eleifend quis, vulputate quis neque. Maecenas a lorem tincidunt, placerat eros vitae, euismod ante. Nunc dapibus elit eu diam pretium, ac sagittis mauris volutpat.';

Widget _aboutMobile(BuildContext context) => Column(
  spacing: 24,
  children: [
    SectionHeader.full(
      context,
      prefixText: 'About me',
      isCentered: true,
      headline: _headline,
    ),
    _headshot(),
    Text(_aboutText, style: CustomTextStyle.bodyMedium(context)),
    CustomButton.primary(context, label: 'Read my full story', onTap: () {}),
  ],
);

Widget _aboutDesktop(BuildContext context) => Row(
  spacing: Spacing.extraLarge(context),
  mainAxisSize: MainAxisSize.min,
  children: [
    _headshot(),
    Flexible(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: Device.isTablet(context) ? 428 : 500,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 32,
          children: [
            SectionHeader.full(
              context,
              prefixText: 'About me',
              headline: 'Grace\'s experience & expertise',
            ),
            Text(_aboutText, style: CustomTextStyle.bodyMedium(context)),
            SizedBox(
              width: 220,
              child: CustomButton.primary(
                context,
                label: 'Read my full story',
                onTap: () {},
              ),
            ),
          ],
        ),
      ),
    ),
  ],
);

Widget _headshot() => Column(
  spacing: 4,
  children: [
    Container(
      width: 300,
      height: 400,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        image: DecorationImage(
          image: AssetImage('lib/assets/images/headshot.jpg'),
          fit: BoxFit.cover,
        ),
      ),
    ),
    Container(
      height: 80,
      width: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        image: DecorationImage(
          image: AssetImage('lib/assets/images/signature.png'),
          fit: BoxFit.cover,
        ),
      ),
    ),
  ],
);

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) => Container(
    constraints: BoxConstraints(maxWidth: 1500),
    padding: EdgeInsets.symmetric(
      horizontal: CustomPadding.pageHorizontal(context),
      vertical: CustomPadding.sectionVertical(context),
    ),
    child: Device.isMobile(context)
        ? _aboutMobile(context)
        : _aboutDesktop(context),
  );
}
