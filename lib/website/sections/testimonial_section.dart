import 'dart:async';
import 'package:flutter/material.dart';
import 'package:grace_ogangwu/components/buttons.dart';
import 'package:grace_ogangwu/components/section_header.dart';
import 'package:grace_ogangwu/constants/sizes.dart';
import 'package:grace_ogangwu/constants/styles.dart';
import 'package:grace_ogangwu/constants/testimonials.dart';

const _headline = 'Testimonials & social proof';

class TestimonialSection extends StatefulWidget {
  const TestimonialSection({super.key});

  @override
  State<TestimonialSection> createState() => _TestimonialSectionState();
}

class _TestimonialSectionState extends State<TestimonialSection> {
  int _focusedIndex = 0;
  Timer? _timer;
  static const List<Map<String, String>> _testimonials = Testimonials.main;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(
      Duration(seconds: 15),
      (Timer t) => setState(
        () => _focusedIndex = (_focusedIndex + 1) % _testimonials.length,
      ),
    );
  }

  void _nextIndex() {
    setState(() => _focusedIndex = (_focusedIndex + 1) % _testimonials.length);
    _timer?.cancel();
    _startTimer();
  }

  void _previousIndex() {
    setState(() => _focusedIndex = (_focusedIndex - 1) % _testimonials.length);
    _timer?.cancel();
    _startTimer();
  }

  @override
  Widget build(BuildContext context) => Container(
    constraints: BoxConstraints(maxWidth: 1500),
    padding: EdgeInsets.only(
      left: Device.isMobile(context)
          ? 16
          : CustomPadding.pageHorizontal(context),
      top: CustomPadding.sectionVertical(context),
      bottom: CustomPadding.sectionVertical(context),
    ),
    child: Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        left: CustomPadding.containerHorizontal(context),
        right: CustomPadding.pageHorizontal(context),
        top: CustomPadding.containerVertical(context),
        bottom: CustomPadding.containerVertical(context),
      ),
      decoration: BoxDecoration(
        color: CustomColors.foreground,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(CustomSizes.borderRadius(context)),
          bottomLeft: Radius.circular(CustomSizes.borderRadius(context)),
        ),
      ),
      child: Device.isMobile(context)
          ? _mobileView(_testimonials[_focusedIndex])
          : Device.isTablet(context)
          ? _tabletView(_testimonials[_focusedIndex])
          : _desktopView(_testimonials[_focusedIndex]),
    ),
  );

  Widget _mobileView(Map<String, String> testimonial) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    spacing: 32,
    children: [
      SectionHeader.full(
        context,
        isCentered: true,
        prefixText: 'Testimonials',
        headline: _headline,
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 24,
        children: [
          Container(
            width: double.infinity,
            height: 224,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32),
              image: DecorationImage(
                image: AssetImage(testimonial['image'] as String),
                fit: BoxFit.contain,
              ),
            ),
          ),
          _nameAndLocation(
            context,
            name: testimonial['name'] as String,
            location: testimonial['location'] as String,
          ),
          _stars(),
          Container(
            width: double.infinity,
            height: 1,
            color: CustomColors.black.withValues(alpha: 0.2),
          ),
          Text(
            testimonial['comment'] as String,
            style: CustomTextStyle.headlineSmall(
              context,
            ).copyWith(fontSize: 24, fontFamily: CustomFontFamily.sans),
          ),
        ],
      ),
      _navigations(context, next: _nextIndex, previous: _previousIndex),
    ],
  );
  Widget _tabletView(Map<String, String> testimonial) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    spacing: 48,
    children: [
      SectionHeader.full(
        context,
        isCentered: true,
        prefixText: 'Testimonials',
        headline: _headline,
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 24,
        children: [
          Container(
            width: double.infinity,
            height: 400,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32),
              image: DecorationImage(
                image: AssetImage(testimonial['image'] as String),
                fit: BoxFit.contain,
              ),
            ),
          ),
          Row(
            spacing: 32,
            children: [
              Expanded(
                child: _nameAndLocation(
                  context,
                  name: testimonial['name'] as String,
                  location: testimonial['location'] as String,
                ),
              ),
              _stars(),
            ],
          ),
          Container(
            width: double.infinity,
            height: 1,
            color: CustomColors.black.withValues(alpha: 0.2),
          ),
          Text(
            testimonial['comment'] as String,
            style: CustomTextStyle.headlineSmall(
              context,
            ).copyWith(fontSize: 24, fontFamily: CustomFontFamily.sans),
          ),
        ],
      ),
      _navigations(context, next: _nextIndex, previous: _previousIndex),
    ],
  );

  Widget _desktopView(Map<String, String> testimonial) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    spacing: 48,
    children: [
      SectionHeader.full(
        context,
        isCentered: true,
        prefixText: 'Testimonials',
        headline: _headline,
      ),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: Spacing.medium(context),
        children: [
          Container(
            width: 600,
            height: 400,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32),
              image: DecorationImage(
                image: AssetImage(testimonial['image'] as String),
                fit: BoxFit.contain,
              ),
            ),
          ),
          Column(
            spacing: 24,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                spacing: 32,
                children: [
                  Expanded(
                    child: _nameAndLocation(
                      context,
                      name: testimonial['name'] as String,
                      location: testimonial['location'] as String,
                    ),
                  ),
                  _stars(),
                ],
              ),
              Container(
                width: double.infinity,
                height: 1,
                color: CustomColors.black.withValues(alpha: 0.2),
              ),
              Text(
                testimonial['comment'] as String,
                style: CustomTextStyle.headlineSmall(
                  context,
                ).copyWith(fontSize: 24, fontFamily: CustomFontFamily.sans),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 40),
            child: _navigations(
              context,
              next: _nextIndex,
              previous: _previousIndex,
            ),
          ),
        ],
      ),
    ],
  );
}

Widget _nameAndLocation(
  BuildContext context, {
  required String name,
  required String location,
}) => SizedBox(
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    spacing: 4,
    children: [
      Text(
        name,
        style: CustomTextStyle.headlineSmall(context).copyWith(fontSize: 24),
      ),
      Row(
        spacing: 8,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.flag, color: CustomColors.primary, size: 20),
          Text(
            location,
            style: CustomTextStyle.bodyMedium(
              context,
            ).copyWith(fontWeight: CustomFontWeight.regular),
          ),
        ],
      ),
    ],
  ),
);

Widget _stars() => Row(
  spacing: 4,
  mainAxisSize: MainAxisSize.min,
  children: [_starIcon(), _starIcon(), _starIcon(), _starIcon(), _starIcon()],
);

Widget _starIcon() => Icon(Icons.star_rate, size: 20, color: Colors.amber);

Widget _navigations(
  BuildContext context, {
  required VoidCallback next,
  required VoidCallback previous,
}) => Row(
  mainAxisAlignment: MainAxisAlignment.center,
  spacing: 16,
  children: [
    CustomButton.arrowIcon(context, isLeft: true, onTap: previous),
    CustomButton.arrowIcon(context, isPrimary: true, onTap: next),
  ],
);
