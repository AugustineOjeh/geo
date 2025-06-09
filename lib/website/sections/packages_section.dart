import 'package:flutter/material.dart';
import 'package:grace_ogangwu/components/section_header.dart';
import 'package:grace_ogangwu/constants/offers.dart';
import 'package:grace_ogangwu/constants/sizes.dart';
import 'package:grace_ogangwu/constants/styles.dart';
import 'package:grace_ogangwu/website/widgets/booking_plan.dart';

const String _headline = 'Pay less per class when you book more';
Widget _description(BuildContext context) => RichText(
  text: TextSpan(
    style: CustomTextStyle.headlineSmall(context, color: CustomColors.text),
    children: [
      TextSpan(
        text: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. ',
      ),
      TextSpan(
        text: 'Suspendisse a purus id justo. ',
        style: TextStyle(color: CustomColors.black),
      ),
      TextSpan(
        text: 'Donec at ipsum quis dui ullamcorper suscipit vitae et ex.',
      ),
    ],
  ),
);

class PackagesSection extends StatefulWidget {
  const PackagesSection({super.key});

  @override
  State<PackagesSection> createState() => _PackagesSectionState();
}

class _PackagesSectionState extends State<PackagesSection> {
  void _onButtonTap(int price, String tier) {
    // TODO: Implement Auth and pass price and tier into app for booking.
  }

  @override
  Widget build(BuildContext context) => Container(
    constraints: BoxConstraints(maxWidth: 1500),
    padding: EdgeInsets.symmetric(
      horizontal: CustomPadding.pageHorizontal(context),
      vertical: CustomPadding.sectionVertical(context),
    ),
    child: Device.isMobile(context)
        ? _mobileView(context, _onButtonTap)
        : Device.isTablet(context)
        ? _tabletView(context, _onButtonTap)
        : _desktopView(context, _onButtonTap),
  );
}

Widget _mobileView(
  BuildContext context,
  void Function(int, String) onButtonTap,
) => Column(
  spacing: 24,
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    SectionHeader.full(
      context,
      prefixText: 'Book classes',
      headline: _headline,
    ),
    _description(context),
    SizedBox(),
    BookingPlan(
      planName: 'Basic',
      price: 20,
      minimumBooking: 1,
      onButtonTap: onButtonTap,
      benefits: Offers.basic,
      benefitPrefix: '50% OFF YOUR FIRST BOOKING',
    ),
    BookingPlan(
      planName: 'Standard',
      price: 17,
      discount: 15,
      minimumBooking: 10,
      onButtonTap: onButtonTap,
      benefits: Offers.standard,
      benefitPrefix: 'Everything in Basic plus:',
    ),
    BookingPlan(
      planName: 'Premium',
      discount: 25,
      isPopular: true,
      price: 15,
      minimumBooking: 20,
      onButtonTap: onButtonTap,
      benefits: Offers.premium,
      benefitPrefix: 'Everything in Standard plus:',
    ),
    BookingPlan(
      planName: 'Special',
      price: 0,
      isCustom: true,
      onButtonTap: onButtonTap,
      benefits: Offers.special,
      benefitPrefix: 'Everything in Premium plus:',
    ),
  ],
);

Widget _tabletView(
  BuildContext context,
  void Function(int, String) onButtonTap,
) => Column(
  spacing: 24,
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Row(
      spacing: 48,
      children: [
        Expanded(
          child: SizedBox(
            child: SectionHeader.full(
              context,
              prefixText: 'Book classes',
              headline: _headline,
            ),
          ),
        ),
        Expanded(child: SizedBox(child: _description(context))),
      ],
    ),
    SizedBox(height: 8),
    Row(
      spacing: 32,
      children: [
        Expanded(
          child: BookingPlan(
            planName: 'Basic',
            price: 20,
            minimumBooking: 1,
            onButtonTap: onButtonTap,
            benefits: Offers.basic,
            benefitPrefix: '50% OFF YOUR FIRST BOOKING',
          ),
        ),
        Expanded(
          child: BookingPlan(
            planName: 'Standard',
            price: 17,
            discount: 15,
            minimumBooking: 10,
            onButtonTap: onButtonTap,
            benefits: Offers.standard,
            benefitPrefix: 'Everything in Basic plus:',
          ),
        ),
      ],
    ),
    Row(
      spacing: 32,
      children: [
        Expanded(
          child: BookingPlan(
            planName: 'Premium',
            discount: 25,
            isPopular: true,
            price: 15,
            minimumBooking: 20,
            onButtonTap: onButtonTap,
            benefits: Offers.premium,
            benefitPrefix: 'Everything in Standard plus:',
          ),
        ),
        Expanded(
          child: BookingPlan(
            planName: 'Special',
            price: 0,
            isCustom: true,
            onButtonTap: onButtonTap,
            benefits: Offers.special,
            benefitPrefix: 'Everything in Premium plus:',
          ),
        ),
      ],
    ),
  ],
);

Widget _desktopView(
  BuildContext context,
  void Function(int, String) onButtonTap,
) => Column(
  spacing: Spacing.extraLarge(context),
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Row(
      spacing: Spacing.extraLarge(context),
      children: [
        Expanded(
          child: SizedBox(
            child: SectionHeader.full(
              context,
              prefixText: 'Book classes',
              headline: _headline,
            ),
          ),
        ),
        Expanded(child: SizedBox(child: _description(context))),
      ],
    ),
    Row(
      spacing: 24,
      children: [
        Expanded(
          child: BookingPlan(
            planName: 'Basic',
            price: 20,
            minimumBooking: 1,
            onButtonTap: onButtonTap,
            benefits: Offers.basic,
            benefitPrefix: '50% OFF YOUR FIRST BOOKING',
          ),
        ),
        Expanded(
          child: BookingPlan(
            planName: 'Standard',
            price: 17,
            discount: 15,
            minimumBooking: 10,
            onButtonTap: onButtonTap,
            benefits: Offers.standard,
            benefitPrefix: 'Everything in Basic plus:',
          ),
        ),
        Expanded(
          child: BookingPlan(
            planName: 'Premium',
            discount: 25,
            isPopular: true,
            price: 15,
            minimumBooking: 20,
            onButtonTap: onButtonTap,
            benefits: Offers.premium,
            benefitPrefix: 'Everything in Standard plus:',
          ),
        ),
        Expanded(
          child: BookingPlan(
            planName: 'Special',
            price: 0,
            isCustom: true,
            onButtonTap: onButtonTap,
            benefits: Offers.special,
            benefitPrefix: 'Everything in Premium plus:',
          ),
        ),
      ],
    ),
  ],
);
