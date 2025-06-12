import 'package:flutter/material.dart';
import 'package:grace_ogangwu/app/core/navigation_manager.dart';
import 'package:grace_ogangwu/app/core/student_model.dart';
import 'package:grace_ogangwu/app/helpers/app_helper.dart';
import 'package:grace_ogangwu/components/components.dart';
import 'package:grace_ogangwu/constants/constants.dart';

class QuestionniarePage extends StatefulWidget {
  const QuestionniarePage({
    required this.student,
    required this.tier,
    required this.bookingCount,
    super.key,
  });
  final Student student;
  final String tier;
  final int bookingCount;

  @override
  State<QuestionniarePage> createState() => _QuestionniarePageState();
}

class _QuestionniarePageState extends State<QuestionniarePage> {
  final _formKey = GlobalKey<FormState>();
  bool _loading = false;

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
            prefixText: 'Introductory questionnaire',
            headline:
                'To enable me design a personalized learning experience, complete this 2-minute questionnaire',
          ),
          Form(
            key: _formKey,
            child: Column(
              spacing: 24,
              children: [
                _studentBox(context, student: widget.student),
                // CustomFields.text(
                //   context,
                //   label: 'Student name',
                //   controller: _nameController,
                //   validator: (value) {
                //     if (value == null || value.trim().isEmpty) {
                //       return 'Required';
                //     }
                //     return null;
                //   },
                // ),
              ],
            ),
          ),
          CustomButton.primary(
            context,
            isFullWidth: true,
            isLoading: _loading,
            label: 'Submit',
            onTap: _submit,
          ),
        ],
      ),
    ),
  );

  bool _validateForm() {
    return _formKey.currentState?.validate() ?? false;
  }

  void _submit() async {
    if (!_validateForm()) return;
    setState(() => _loading = true);
    final data = <String, String>{};
    try {
      final res = await AppHelper.submitQuestionnaire(context, data: data);
      if (!res) return;
      NavigationManager.pushReplacement(
        PageNames.bookingCompleted,
        arguments: {
          'student': widget.student,
          'sessions': widget.bookingCount,
          'tier': widget.tier,
        },
      );
    } finally {
      setState(() => _loading = false);
    }
  }
}

Widget _studentBox(BuildContext context, {required Student student}) => Column(
  spacing: 16,
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Text('Student', style: CustomTextStyle.bodyMedium(context)),
    Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: BoxDecoration(
        color: CustomColors.primary,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        spacing: 24,
        children: [
          Expanded(
            child: Text(
              '${student.name} (${student.age})',
              style: CustomTextStyle.headlineSmall(
                context,
                color: CustomColors.foreground,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          CustomButton.arrowIcon(context, isRight: true, onTap: () {}),
        ],
      ),
    ),
  ],
);
