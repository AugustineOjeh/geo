import 'package:flutter/material.dart';
import 'package:grace_ogangwu/constants/constants.dart';
import 'package:grace_ogangwu/website/widgets/booking_plan.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AppHome extends StatefulWidget {
  const AppHome({super.key});

  @override
  State<AppHome> createState() => _AppHomeState();
}

class _AppHomeState extends State<AppHome> {
  String _firstName = '';

  @override
  void initState() {
    super.initState();
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) return;
    _firstName = user.userMetadata?['first-name'] ?? '';
  }

  void _onPackageTap(int bookingCount, double price, String tierName) {
    // TODO: Initiate booking.
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: Spacing.medium(context),
      children: [
        Text(
          'Hello, $_firstName',
          style: CustomTextStyle.headlineMedium(context),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 24,
          children: [
            Text('Book a class', style: CustomTextStyle.headlineSmall(context)),
            SizedBox(
              child: Device.isMobile(context)
                  ? _mobileView(context, _onPackageTap)
                  : Device.isTablet(context)
                  ? _tabletView(context, _onPackageTap)
                  : _desktopView(context, _onPackageTap),
            ),
          ],
        ),
      ],
    );
  }
}

Widget _mobileView(
  BuildContext context,
  void Function(int, double, String) onButtonTap,
) => Column(
  spacing: 24,
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
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
  void Function(int, double, String) onButtonTap,
) => Column(
  spacing: 24,
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
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
  void Function(int, double, String) onButtonTap,
) => Column(
  spacing: Spacing.extraLarge(context),
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
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
