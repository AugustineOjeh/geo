import 'dart:async';
import 'package:flutter/material.dart';
import 'package:grace_ogangwu/components/buttons.dart';
import 'package:grace_ogangwu/components/section_header.dart';
import 'package:grace_ogangwu/constants/constants.dart';
import 'package:grace_ogangwu/website/widgets/process_box.dart';

Widget _header(BuildContext context) => SectionHeader.full(
  context,
  prefixText: 'How I work',
  headline: 'Every child deserves a personalized learning experience',
);

Widget _descritpion(BuildContext context) => RichText(
  text: TextSpan(
    style: CustomTextStyle.headlineSmall(context, color: CustomColors.text),
    children: [
      TextSpan(
        text: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. ',
      ),
      TextSpan(
        style: TextStyle(color: CustomColors.black),
        text: 'Suspendisse a purus id justo.',
      ),
    ],
  ),
);

const _box1Content = <String, String>{
  'prefix': '01',
  'title': 'Tell me about your child by completing a 3-min student assessment.',
  'image': '', // TODO: Add image file.
  'description':
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse a purus id justo egestas fermentum dictum ut arcu. Donec at ipsum quis dui ullamcorper suscipit vitae et ex.',
};
const _box2Content = <String, String>{
  'prefix': '02',
  'title': 'Tell me about your child by completing a 3-min student assessment.',
  'image': '', // TODO: Add image file.
  'description':
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse a purus id justo egestas fermentum dictum ut arcu. Donec at ipsum quis dui ullamcorper suscipit vitae et ex.',
};
const _box3Content = <String, String>{
  'prefix': '03',
  'title': 'Tell me about your child by completing a 3-min student assessment.',
  'image': '', // TODO: Add image file.
  'description':
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse a purus id justo egestas fermentum dictum ut arcu. Donec at ipsum quis dui ullamcorper suscipit vitae et ex.',
};

class HowIWorkSection extends StatefulWidget {
  const HowIWorkSection({required this.navigate, super.key});
  final void Function(GlobalKey) navigate;

  @override
  State<HowIWorkSection> createState() => _HowIWorkSectionState();
}

class _HowIWorkSectionState extends State<HowIWorkSection> {
  int _focusedIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(
      Duration(seconds: 10),
      (Timer t) => setState(() => _focusedIndex = (_focusedIndex + 1) % 3),
    );
  }

  void _changeFocus(int index) {
    setState(() => _focusedIndex = index);
    _timer?.cancel();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Container(
    constraints: BoxConstraints(maxWidth: 1500),
    padding: EdgeInsets.symmetric(
      horizontal: CustomPadding.pageHorizontal(context),
      vertical: CustomPadding.sectionVertical(context),
    ),
    child: Device.isMobile(context)
        ? _mobileView(context, navigate: widget.navigate)
        : Device.isTablet(context)
        ? _tabletView(context, navigate: widget.navigate)
        : _desktopView(context, navigate: widget.navigate),
  );

  Widget _mobileView(
    BuildContext context, {
    required void Function(GlobalKey) navigate,
  }) => Column(
    spacing: 24,
    children: [
      _header(context),
      _descritpion(context),
      ProcessBox(
        padding: EdgeInsets.fromLTRB(20, 24, 0, 0),
        onTap: () => _changeFocus(0),
        prefix: _box1Content['prefix']!,
        title: _box1Content['title']!,
        description: _box1Content['description']!,
        hideDescrition: false,
        isMobile: true,
        image: _box1Content['image']!,
      ),
      ProcessBox(
        padding: EdgeInsets.fromLTRB(20, 24, 0, 0),
        onTap: () => _changeFocus(1),
        prefix: _box2Content['prefix']!,
        title: _box2Content['title']!,
        description: _box2Content['description']!,
        hideDescrition: false,
        isMobile: true,
        image: _box2Content['image']!,
      ),
      ProcessBox(
        padding: EdgeInsets.fromLTRB(20, 24, 0, 0),
        onTap: () => _changeFocus(2),
        prefix: _box3Content['prefix']!,
        title: _box3Content['title']!,
        description: _box3Content['description']!,
        hideDescrition: false,
        isMobile: true,
        image: _box3Content['image']!,
      ),
      CustomButton.primary(
        context,
        label: 'Book a class',
        onTap: () => navigate(SectionKeys.bookClass),
      ),
    ],
  );
  Widget _desktopView(
    BuildContext context, {
    required void Function(GlobalKey) navigate,
  }) => Column(
    spacing: Spacing.large(context),
    children: [
      Row(
        spacing: 64,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(child: _header(context)),
          Expanded(child: _descritpion(context)),
        ],
      ),
      Row(
        spacing: 24,
        children: [
          Expanded(
            flex: _focusedIndex != 0 ? 1 : 2,
            child: ProcessBox(
              onTap: () => _changeFocus(0),
              padding: EdgeInsets.fromLTRB(20, 24, 0, 0),
              prefix: _box1Content['prefix']!,
              title: _box1Content['title']!,
              description: _box1Content['description']!,
              hideDescrition: _focusedIndex != 0,
              isSelected: _focusedIndex == 0,
              isMobile: false,
              image: _box1Content['image']!,
            ),
          ),
          Expanded(
            flex: _focusedIndex != 1 ? 1 : 2,
            child: ProcessBox(
              onTap: () => _changeFocus(1),
              padding: EdgeInsets.fromLTRB(20, 24, 0, 0),
              prefix: _box2Content['prefix']!,
              title: _box2Content['title']!,
              description: _box2Content['description']!,
              hideDescrition: _focusedIndex != 0,
              isMobile: false,
              isSelected: _focusedIndex == 1,
              image: _box2Content['image']!,
            ),
          ),
          Expanded(
            flex: _focusedIndex != 2 ? 1 : 2,
            child: ProcessBox(
              onTap: () => _changeFocus(2),
              padding: EdgeInsets.fromLTRB(20, 24, 0, 0),
              prefix: _box3Content['prefix']!,
              title: _box3Content['title']!,
              description: _box3Content['description']!,
              hideDescrition: _focusedIndex != 0,
              isMobile: false,
              isSelected: _focusedIndex == 2,
              image: _box3Content['image']!,
            ),
          ),
        ],
      ),
      CustomButton.primary(
        context,
        label: 'Book a class',
        onTap: () => navigate(SectionKeys.bookClass),
      ),
    ],
  );

  Widget _tabletView(
    BuildContext context, {
    required void Function(GlobalKey) navigate,
  }) => Column(
    spacing: 48,
    children: [
      Row(
        spacing: 48,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(child: _header(context)),
          Expanded(child: _descritpion(context)),
        ],
      ),
      Column(
        spacing: 24,
        children: [
          Row(
            spacing: 24,
            children: [
              Expanded(
                child: ProcessBox(
                  onTap: () => _changeFocus(0),
                  padding: EdgeInsets.fromLTRB(20, 24, 0, 0),
                  prefix: _box1Content['prefix']!,
                  title: _box1Content['title']!,
                  description: _box1Content['description']!,
                  hideDescrition: false,
                  isSelected: _focusedIndex == 0,
                  isMobile: false,
                  image: _box1Content['image']!,
                ),
              ),
              Expanded(
                child: ProcessBox(
                  onTap: () => _changeFocus(1),
                  padding: EdgeInsets.fromLTRB(20, 24, 0, 0),
                  prefix: _box2Content['prefix']!,
                  title: _box2Content['title']!,
                  description: _box2Content['description']!,
                  hideDescrition: false,
                  isMobile: false,
                  isSelected: _focusedIndex == 1,
                  image: _box2Content['image']!,
                ),
              ),
            ],
          ),
          ProcessBox(
            onTap: () => _changeFocus(2),
            padding: EdgeInsets.fromLTRB(20, 24, 0, 0),
            prefix: _box3Content['prefix']!,
            title: _box3Content['title']!,
            description: _box3Content['description']!,
            hideDescrition: false,
            isMobile: false,
            isSelected: _focusedIndex == 2,
            image: _box3Content['image']!,
          ),
        ],
      ),
      CustomButton.primary(
        context,
        label: 'Book a class',
        onTap: () => navigate(SectionKeys.bookClass),
      ),
    ],
  );
}
