import 'package:flutter/material.dart';
import 'package:grace_ogangwu/app/core/navigation_manager.dart';
import 'package:grace_ogangwu/app/core/student_model.dart';
import 'package:grace_ogangwu/app/helpers/app_helper.dart';
import 'package:grace_ogangwu/app/widgets/typeform_iframe.dart';
import 'package:grace_ogangwu/components/components.dart';
import 'package:grace_ogangwu/constants/constants.dart';

class QuestionniarePage extends StatefulWidget {
  const QuestionniarePage({required this.student, super.key});
  final Student student;

  @override
  State<QuestionniarePage> createState() => _QuestionniarePageState();
}

class _QuestionniarePageState extends State<QuestionniarePage> {
  bool _loading = false;

  @override
  Widget build(BuildContext context) => SizedBox(
    width: double.infinity,
    child: Column(
      spacing: 32,
      children: [
        SectionHeader.app(
          context,
          isCentered: true,
          prefixText: 'Introductory questionnaire',
          headline:
              'To enable me design a personalized learning experience, complete this 2-minute questionnaire',
        ),
        SizedBox(
          height: Device.screenHeight(context) - 200,
          width: double.infinity,
          child: _loading
              ? Center(
                  child: CircularProgressIndicator(
                    color: CustomColors.primary,
                    strokeWidth: 2,
                  ),
                )
              : Column(
                  spacing: 16,
                  children: [
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: 1400,
                        maxHeight: Device.screenHeight(context),
                      ),

                      child: TypeformIframe(
                        student: widget.student,
                        width: Device.isMobile(context)
                            ? double.infinity
                            : 1400,
                        height: Device.screenHeight(context) - 400,
                      ),
                    ),
                    SizedBox(
                      width: 240,
                      child: CustomButton.primary(
                        context,
                        label: 'Proceed',
                        onTap: _submit,
                      ),
                    ),
                    SizedBox(),
                  ],
                ),
        ),
      ],
    ),
  );

  void _submit() async {
    setState(() => _loading = true);

    final data = widget.student.copyWith(questionsAnswered: true);
    try {
      final res = await AppHelper.updateStudentData(context, data: data);
      if (!res) return;
      NavigationManager.pushReplacement(PageNames.bookingCompleted);
    } finally {
      setState(() => _loading = false);
    }
  }
}
