import 'package:flutter/material.dart';
import 'package:grace_ogangwu/components/fields.dart';
import 'package:grace_ogangwu/constants/sizes.dart';
import 'package:grace_ogangwu/constants/styles.dart';

class NewsletterSubscription extends StatefulWidget {
  const NewsletterSubscription({super.key});

  @override
  State<NewsletterSubscription> createState() => _NewsletterSubscriptionState();
}

class _NewsletterSubscriptionState extends State<NewsletterSubscription> {
  final _controller = TextEditingController();

  void _submit() {
    // TODO: Implement waitlist joining
  }

  @override
  Widget build(BuildContext context) => SizedBox(
    width: Device.isMobile(context) ? double.infinity : 300,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      spacing: 32,
      children: [
        Text(
          'Subscribe to my newsletter',
          style: CustomTextStyle.headlineSmall(
            context,
            color: CustomColors.background.withValues(alpha: 0.8),
          ),
        ),
        CustomFields.newsletterInput(
          context,
          controller: _controller,
          submit: _submit,
        ),
      ],
    ),
  );
}
