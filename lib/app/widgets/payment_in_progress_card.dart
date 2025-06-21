import 'package:flutter/material.dart';
import 'package:grace_ogangwu/constants/sizes.dart';
import 'package:grace_ogangwu/constants/styles.dart';

class PaymentInProgressCard extends StatelessWidget {
  const PaymentInProgressCard({required this.confirmingPayment, super.key});
  final bool confirmingPayment;

  @override
  Widget build(BuildContext context) => Container(
    width: double.infinity,
    height: Device.screenHeight(context) - 240,

    decoration: BoxDecoration(
      color: CustomColors.background.withValues(alpha: 0.7),
    ),
    padding: EdgeInsets.symmetric(
      horizontal: CustomPadding.pageHorizontal(context),
      vertical: 32,
    ),
    child: Container(
      constraints: Device.isMobile(context)
          ? null
          : BoxConstraints(maxWidth: 320),
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      decoration: BoxDecoration(
        color: CustomColors.foreground,
        border: Border.all(
          width: 1,
          color: CustomColors.black.withValues(alpha: 0.15),
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        spacing: 16,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            confirmingPayment
                ? 'Confirming your payment...'
                : 'Payment in progress.',
            style: CustomTextStyle.bodyLarge(
              context,
              color: CustomColors.black,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(),
          Text(
            confirmingPayment
                ? 'This will take a few seconds.'
                : 'Complete your payment on the checkout tab.',
            style: CustomTextStyle.bodyMedium(context),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16),
          SizedBox(
            height: 24,
            width: 24,
            child: CircularProgressIndicator(
              color: CustomColors.primary,
              strokeWidth: 2,
            ),
          ),
          SizedBox(height: 16),
          Text(
            'Please, DO NOT reload this page.',
            style: CustomTextStyle.bodyMedium(context),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ),
  );
}
