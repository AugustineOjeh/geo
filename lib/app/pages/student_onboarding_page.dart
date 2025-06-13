import 'package:flutter/material.dart';
import 'package:grace_ogangwu/app/helpers/app_helper.dart';
import 'package:grace_ogangwu/components/components.dart';
import 'package:grace_ogangwu/constants/constants.dart';

class StudentOnboardingPage extends StatefulWidget {
  const StudentOnboardingPage({
    required this.userFirstName,
    this.bookingCount,
    this.tier,
    this.tierPrice,
    super.key,
  });
  final String userFirstName;
  final double? tierPrice;
  final String? tier;
  final int? bookingCount;

  @override
  State<StudentOnboardingPage> createState() => _StudentOnboardingPageState();
}

class _StudentOnboardingPageState extends State<StudentOnboardingPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  int _age = 5;
  bool _loading = false;

  bool _validateForm() {
    return _formKey.currentState?.validate() ?? false;
  }

  void _increment() => setState(() => _age++);
  void _decrement() {
    if (_age <= 5) return;
    setState(() => _age--);
  }

  void _submit() async {
    if (!_validateForm()) return;
    setState(() => _loading = true);
    try {
      await AppHelper.addStudent(
        context,
        name: _nameController.text.trim(),
        age: _age,
        tier: widget.tier,
        bookingCount: widget.bookingCount,
        price: widget.tierPrice,
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
          SectionHeader.full(
            context,
            prefixText: 'Hi, ${widget.userFirstName}',
            headline: 'Add a student',
          ),
          Form(
            key: _formKey,
            child: Column(
              spacing: 24,
              children: [
                CustomFields.text(
                  context,
                  label: 'Student name',
                  controller: _nameController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Required';
                    }
                    return null;
                  },
                ),
                _ageCounter(
                  context,
                  count: _age,
                  increment: _increment,
                  decrement: _decrement,
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

Widget _ageCounter(
  BuildContext context, {
  required int count,
  required VoidCallback increment,
  required VoidCallback decrement,
}) => Row(
  mainAxisSize: MainAxisSize.min,
  spacing: 8,
  children: [
    Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        height: 55,
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            width: 1,
            color: CustomColors.black.withValues(alpha: 0.2),
          ),
        ),
        child: Text(
          count.toString(),
          style: CustomTextStyle.bodyLarge(context),
        ),
      ),
    ),
    CustomButton.icon(context, onTap: decrement, size: 32, icon: Icons.remove),
    CustomButton.icon(
      context,
      onTap: increment,
      isPrimary: true,
      size: 32,
      icon: Icons.add,
    ),
  ],
);
