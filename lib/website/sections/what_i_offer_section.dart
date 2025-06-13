import 'package:flutter/material.dart';
import 'package:grace_ogangwu/components/section_header.dart';
import 'package:grace_ogangwu/constants/sizes.dart';
import 'package:grace_ogangwu/constants/styles.dart';

const String _headline = 'Who this is for';

// TODO: Update the copy for description
Widget _description(BuildContext context) => RichText(
  text: TextSpan(
    style: CustomTextStyle.headlineSmall(context, color: CustomColors.text),
    children: [
      TextSpan(
        text:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse a purus id justo. ',
      ),
      TextSpan(
        style: TextStyle(color: CustomColors.black),
        text:
            'Donec at ipsum quis dui ullamcorper suscipit vitae et ex. Integer ut purus tempor, tristique.',
      ),
    ],
  ),
);

const _box1Content = <String, String>{
  'image': 'lib/assets/images/english_students.jpg',
  'title': 'Early-grade learners',
  'description':
      'Kids under 7 years old ready to learn the fundamentals of reading and writing the English Language.',
};

const _box2Content = <String, String>{
  'image': 'lib/assets/images/non_english_students.jpg',
  'title': 'Speakers of other languages',
  'description':
      'Non-English kids and adolescents hungry to acquire the skills to communicate in English.',
};

const _box3Content = <String, String>{
  'image': 'lib/assets/images/high_achievers.jpg',
  'title': 'High achievers',
  'description':
      '7 to 15 years-olds eager to refine their grammar, improve spelling, and compete in a range of English-related competitions.',
};

Widget _mobileView(BuildContext context) => Container(
  width: double.infinity,
  padding: EdgeInsets.symmetric(
    horizontal: CustomPadding.containerHorizontal(context),
    vertical: CustomPadding.containerVertical(context),
  ),
  decoration: BoxDecoration(
    color: CustomColors.foreground,
    borderRadius: CustomSizes.borderRadius(context),
  ),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    spacing: 32,
    children: [
      SectionHeader.full(
        context,
        prefixText: 'What I offer',
        headline: _headline,
      ),
      _description(context),
      _targetStudents(
        context,
        title: _box1Content['title']!,
        description: _box1Content['description']!,
        image: _box1Content['image']!,
      ),
      _targetStudents(
        context,
        title: _box2Content['title']!,
        description: _box2Content['description']!,
        image: _box2Content['image']!,
      ),
      _targetStudents(
        context,
        title: _box3Content['title']!,
        description: _box3Content['description']!,
        image: _box3Content['image']!,
      ),
    ],
  ),
);

Widget _desktopView(BuildContext context) => Container(
  width: double.infinity,
  padding: EdgeInsets.symmetric(
    horizontal: CustomPadding.containerHorizontal(context),
    vertical: CustomPadding.containerVertical(context),
  ),
  decoration: BoxDecoration(
    color: CustomColors.foreground,
    borderRadius: CustomSizes.borderRadius(context),
  ),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    spacing: 32,
    children: [
      Row(
        spacing: Spacing.small(context),
        children: [
          Expanded(
            child: SizedBox(
              child: Column(
                spacing: 32,
                children: [
                  SectionHeader.full(
                    context,
                    prefixText: 'What I offer',
                    headline: _headline,
                  ),
                  _description(context),
                ],
              ),
            ),
          ),
          Expanded(
            child: _targetStudents(
              context,
              title: _box1Content['title']!,
              description: _box1Content['description']!,
              image: _box1Content['image']!,
            ),
          ),
        ],
      ),
      Row(
        spacing: Spacing.small(context),
        children: [
          Expanded(
            child: _targetStudents(
              context,
              title: _box2Content['title']!,
              description: _box2Content['description']!,
              image: _box2Content['image']!,
            ),
          ),
          Expanded(
            child: _targetStudents(
              context,
              title: _box3Content['title']!,
              description: _box3Content['description']!,
              image: _box3Content['image']!,
            ),
          ),
        ],
      ),
    ],
  ),
);

Widget _targetStudents(
  BuildContext context, {
  required String title,
  required String description,
  required String image,
}) => Container(
  width: double.infinity,
  alignment: Alignment.bottomLeft,
  padding: EdgeInsets.symmetric(
    horizontal: Device.isMobile(context) ? 16 : 24,
    vertical: Device.isTablet(context) ? 16 : 24,
  ),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(32),
    image: DecorationImage(image: AssetImage(image)),
  ),
  child: Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    spacing: 12,
    children: [
      Text(
        title,
        style: CustomTextStyle.headlineSmall(
          context,
        ).copyWith(fontSize: 24, color: CustomColors.foreground),
      ),
      Text(
        description,
        style: CustomTextStyle.bodyMedium(
          context,
          color: CustomColors.foreground,
        ),
      ),
    ],
  ),
);

class WhatIOfferSection extends StatelessWidget {
  const WhatIOfferSection({super.key});

  @override
  Widget build(BuildContext context) => Container(
    constraints: BoxConstraints(maxWidth: 1500),
    padding: EdgeInsets.symmetric(
      horizontal: CustomPadding.pageHorizontal(context),
      vertical: CustomPadding.sectionVertical(context),
    ),
    child: Device.isMobile(context)
        ? _mobileView(context)
        : _desktopView(context),
  );
}
