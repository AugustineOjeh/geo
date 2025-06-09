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
    SectionHeader.full(context, prefixText: 'About me', headline: _headline),
    _headshot(),
    Text(_aboutText, style: CustomTextStyle.bodyMedium(context)),
    CustomButton.primary(context, label: 'Read my full story', onTap: () {}),
  ],
);

Widget _aboutDesktop(BuildContext context) => Row(
  spacing: Spacing.extraLarge(context),
  children: [
    _headshot(),
    Expanded(
      child: SizedBox(
        child: Column(
          spacing: 32,
          children: [
            SectionHeader.full(
              context,
              prefixText: 'About me',
              headline: 'Grace\'s experience & expertise',
            ),
            Text(_aboutText, style: CustomTextStyle.bodyMedium(context)),
            CustomButton.primary(
              context,
              label: 'Read my full story',
              onTap: () {},
            ),
          ],
        ),
      ),
    ),
  ],
);

Widget _headshot() => Column(
  spacing: 12,
  children: [
    Container(
      width: 300,
      height: 500,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        image: DecorationImage(
          image: AssetImage('lib/assets/images/headshot.jpg'),
          fit: BoxFit.fill,
        ),
      ),
    ),
    Container(
      height: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        image: DecorationImage(
          image: AssetImage('lib/assets/images/signature.jpg'),
          fit: BoxFit.fill,
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
