import 'package:flutter/material.dart';
import 'package:grace_ogangwu/components/fields.dart';
import 'package:grace_ogangwu/constants/sizes.dart';
import 'package:grace_ogangwu/constants/styles.dart';
import 'package:grace_ogangwu/website/helpers/website_helper.dart';

class NewsletterSubscription extends StatefulWidget {
  const NewsletterSubscription({super.key});

  @override
  State<NewsletterSubscription> createState() => _NewsletterSubscriptionState();
}

class _NewsletterSubscriptionState extends State<NewsletterSubscription> {
  final _formKey = GlobalKey<FormState>();
  final _controller = TextEditingController();
  bool _loading = false;
  String? _message;

  bool _validateForm() {
    return _formKey.currentState?.validate() ?? false;
  }

  void _submit() async {
    if (!_validateForm()) return;
    setState(() => _loading = true);
    try {
      final res = await WebsiteHelper.joinWaitlist(
        context,
        email: _controller.text.trim(),
      );
      if (res) {
        setState(() => _message = 'Successful!');
      }
    } finally {
      setState(() => _loading = false);
      Future.delayed(
        Duration(seconds: 3),
        () => setState(() => _message = null),
      );
    }
  }

  @override
  Widget build(BuildContext context) => SizedBox(
    width: Device.isMobile(context) ? double.infinity : 300,
    child: Form(
      key: _formKey,
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
            loading: _loading,
            submit: _submit,
          ),
          if (_message != null)
            Text(
              _message!,
              style: CustomTextStyle.bodyMedium(
                context,
                color: CustomColors.foreground,
              ),
            ),
        ],
      ),
    ),
  );
}
