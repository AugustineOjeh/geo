import 'package:flutter/material.dart';
import 'package:grace_ogangwu/app/helpers/app_helper.dart';
import 'package:grace_ogangwu/components/components.dart';
import 'package:grace_ogangwu/constants/constants.dart';

class UserOnboardingPage extends StatefulWidget {
  const UserOnboardingPage({
    this.bookingCount,
    this.tier,
    this.tierPrice,
    super.key,
  });
  final double? tierPrice;
  final String? tier;
  final int? bookingCount;

  @override
  State<UserOnboardingPage> createState() => _UserOnboardingPageState();
}

class _UserOnboardingPageState extends State<UserOnboardingPage> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  bool _loading = false;

  bool _validateForm() {
    return _formKey.currentState?.validate() ?? false;
  }

  void _submit() async {
    if (!_validateForm()) return;
    setState(() => _loading = true);
    try {
      await AppHelper.updateUserData(
        context,
        firstName: _firstNameController.text.trim(),
        lastName: _lastNameController.text.trim(),
        tier: widget.tier,
        price: widget.tierPrice,
        bookingCount: widget.bookingCount,
      );
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) => Container(
    constraints: Device.isMobile(context)
        ? null
        : BoxConstraints(maxWidth: 320),
    child: SizedBox(
      width: double.infinity,
      child: Column(
        spacing: 32,
        children: [
          SectionHeader.app(
            context,
            prefixText: 'Hi, I\'m Grace Ogangwu',
            headline: 'What should I call you?',
          ),
          Form(
            key: _formKey,
            child: Column(
              spacing: 24,
              children: [
                CustomFields.text(
                  context,
                  label: 'First name',
                  controller: _firstNameController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Required';
                    }
                    return null;
                  },
                ),
                CustomFields.text(
                  context,
                  label: 'Last name',
                  controller: _lastNameController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Required';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          CustomButton.primary(
            context,
            isLoading: _loading,
            label: 'Save',
            onTap: _submit,
          ),
        ],
      ),
    ),
  );
}
