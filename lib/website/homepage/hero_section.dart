import 'package:flutter/material.dart';
import 'package:grace_ogangwu/components/app_bar.dart';
import 'package:grace_ogangwu/components/buttons.dart';
import 'package:grace_ogangwu/components/section_header.dart';
import 'package:grace_ogangwu/constants/sizes.dart';
import 'package:grace_ogangwu/constants/styles.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) => Container(
    width: double.infinity,
    alignment: Alignment.topCenter,
    decoration: BoxDecoration(
      // TODO: Add background image
    ),
    child: Container(
      padding: EdgeInsets.symmetric(
        horizontal: CustomPadding.pageHorizontal(context),
      ),
      constraints: BoxConstraints(maxWidth: 1500),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomAppBar.dynamic(context),
          SizedBox(height: Spacing.hero(context)),
          CustomButton.secondary(
            context,
            label: 'Book a class',
            onTap: () {
              // Implement Auth
            },
          ),
          SizedBox(height: 48),
          SectionHeader.prefix(
            context,
            text:
                'Grace Ogangwu: TESOL-certified English Literacy Teacher for early-stage learners',
            isWhite: true,
          ),
          SizedBox(height: 48),
          Text('Literacy Begins Here.', style: CustomTextStyle.title(context)),
          SizedBox(height: 48),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                height: 5,
                width: Device.screenWidth(context) / 4,
                color: CustomColors.foreground,
              ),
              Expanded(
                child: Container(
                  height: 3,
                  color: CustomColors.foreground.withValues(alpha: 0.2),
                ),
              ),
            ],
          ),
          SizedBox(height: 32),
          Device.isMobile(context)
              ? _mobileProposition(context)
              : Device.isTablet(context)
              ? _tabletProposition(context)
              : _desktopProposition(context),
          // More widgets
        ],
      ),
    ),
  );
}

Widget _mobileProposition(BuildContext context) => Column(
  spacing: 48,
  mainAxisSize: MainAxisSize.min,
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    _uvp(
      context,
      number: 1,
      title: '13k',
      description: [
        TextSpan(text: 'Hours of'),
        TextSpan(
          text: ' teaching experience',
          style: TextStyle(fontWeight: CustomFontWeight.bold),
        ),
      ],
    ),
    _uvp(
      context,
      number: 2,
      title: '100+',
      description: [
        TextSpan(
          text: 'Successful learners ',
          style: TextStyle(fontWeight: CustomFontWeight.bold),
        ),
        TextSpan(text: 'and satisfied parents'),
      ],
    ),
    _uvp(
      context,
      number: 3,
      title: '10+',
      description: [
        TextSpan(
          text: 'Awards ',
          style: TextStyle(fontWeight: CustomFontWeight.bold),
        ),
        TextSpan(text: 'and certifications'),
      ],
    ),
    _uvp(
      context,
      number: 3,
      title: 'Diverse culture',
      description: [
        TextSpan(text: 'Teaches students across'),
        TextSpan(
          text: ' 5 different cultures ',
          style: TextStyle(fontWeight: CustomFontWeight.bold),
        ),
        TextSpan(text: 'and languages'),
      ],
    ),
  ],
);

Widget _tabletProposition(BuildContext context) => SizedBox(
  width: double.infinity,
  child: Column(
    spacing: 48,
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        spacing: 14,
        children: [
          Expanded(
            child: SizedBox(
              child: _uvp(
                context,
                number: 1,
                title: '13k',
                description: [
                  TextSpan(text: 'Hours of'),
                  TextSpan(
                    text: ' teaching experience',
                    style: TextStyle(fontWeight: CustomFontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: SizedBox(
              child: _uvp(
                context,
                number: 2,
                title: '100+',
                description: [
                  TextSpan(
                    text: 'Successful learners ',
                    style: TextStyle(fontWeight: CustomFontWeight.bold),
                  ),
                  TextSpan(text: 'and satisfied parents'),
                ],
              ),
            ),
          ),
        ],
      ),
      Row(
        spacing: 14,
        children: [
          Expanded(
            child: SizedBox(
              child: _uvp(
                context,
                number: 3,
                title: '10+',
                description: [
                  TextSpan(
                    text: 'Awards ',
                    style: TextStyle(fontWeight: CustomFontWeight.bold),
                  ),
                  TextSpan(text: 'and certifications'),
                ],
              ),
            ),
          ),
          Expanded(
            child: SizedBox(
              child: _uvp(
                context,
                number: 3,
                title: 'Diverse culture',
                description: [
                  TextSpan(text: 'Teaches students across'),
                  TextSpan(
                    text: ' 5 different cultures ',
                    style: TextStyle(fontWeight: CustomFontWeight.bold),
                  ),
                  TextSpan(text: 'and languages'),
                ],
              ),
            ),
          ),
        ],
      ),
    ],
  ),
);

Widget _desktopProposition(BuildContext context) => SizedBox(
  width: double.infinity,
  child: Row(
    spacing: 48,
    children: [
      Expanded(
        child: SizedBox(
          child: _uvp(
            context,
            number: 1,
            title: '13k',
            description: [
              TextSpan(text: 'Hours of'),
              TextSpan(
                text: ' teaching experience',
                style: TextStyle(fontWeight: CustomFontWeight.bold),
              ),
            ],
          ),
        ),
      ),
      Expanded(
        child: SizedBox(
          child: _uvp(
            context,
            number: 2,
            title: '100+',
            description: [
              TextSpan(
                text: 'Successful learners ',
                style: TextStyle(fontWeight: CustomFontWeight.bold),
              ),
              TextSpan(text: 'and satisfied parents'),
            ],
          ),
        ),
      ),
      Expanded(
        child: SizedBox(
          child: _uvp(
            context,
            number: 3,
            title: '10+',
            description: [
              TextSpan(
                text: 'Awards ',
                style: TextStyle(fontWeight: CustomFontWeight.bold),
              ),
              TextSpan(text: 'and certifications'),
            ],
          ),
        ),
      ),
      Expanded(
        child: SizedBox(
          child: _uvp(
            context,
            number: 3,
            title: 'Diverse culture',
            description: [
              TextSpan(text: 'Teaches students across'),
              TextSpan(
                text: ' 5 different cultures ',
                style: TextStyle(fontWeight: CustomFontWeight.bold),
              ),
              TextSpan(text: 'and languages'),
            ],
          ),
        ),
      ),
    ],
  ),
);

Widget _uvp(
  BuildContext context, {
  required int number,
  required String title,
  required List<TextSpan> description,
}) => Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  mainAxisSize: MainAxisSize.min,
  spacing: 12,
  children: [
    Row(
      mainAxisSize: MainAxisSize.min,
      spacing: 16,
      children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              width: 1,
              color: CustomColors.foreground.withValues(alpha: 0.4),
            ),
          ),
          child: Text(
            number.toString(),
            style: CustomTextStyle.bodyMedium(
              context,
              color: CustomColors.foreground.withValues(alpha: 0.4),
            ),
          ),
        ),
        Text(
          title,
          style: CustomTextStyle.headlineSmall(
            context,
          ).copyWith(fontSize: 40, color: CustomColors.foreground),
        ),
      ],
    ),
    RichText(
      text: TextSpan(
        children: description,
        style: CustomTextStyle.bodyLarge(
          context,
          color: CustomColors.foreground,
        ),
      ),
    ),
  ],
);
