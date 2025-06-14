import 'package:flutter/material.dart';
import 'package:grace_ogangwu/components/buttons.dart';
import 'package:grace_ogangwu/constants/sizes.dart';
import 'package:grace_ogangwu/constants/styles.dart';

class QAndA extends StatelessWidget {
  const QAndA({
    required this.questionAnswerPair,
    required this.answerIsVisible,
    required this.toggleAnswer,
    super.key,
  });
  final Map<String, dynamic> questionAnswerPair;
  final VoidCallback toggleAnswer;
  final bool answerIsVisible;

  @override
  Widget build(BuildContext context) => AnimatedContainer(
    duration: Duration(milliseconds: 500),
    curve: Curves.easeInOut,
    width: double.infinity,
    padding: EdgeInsets.symmetric(vertical: 20),
    decoration: BoxDecoration(
      border: Border(
        bottom: BorderSide(
          width: 1,
          color: CustomColors.black.withValues(alpha: 0.07),
        ),
      ),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      spacing: 16,
      children: [
        GestureDetector(
          onTap: toggleAnswer,
          child: Row(
            spacing: Device.isMobile(context) ? 32 : 64,
            children: [
              Expanded(
                child: Text(
                  questionAnswerPair['question'] as String,
                  style: CustomTextStyle.bodyLarge(
                    context,
                  ).copyWith(fontSize: 20, color: CustomColors.black),
                ),
              ),
              CustomButton.icon(
                context,
                onTap: toggleAnswer,
                size: 20,
                icon: answerIsVisible ? Icons.remove : Icons.add,
              ),
            ],
          ),
        ),
        if (answerIsVisible)
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(right: Device.isMobile(context) ? 32 : 96),
            child: questionAnswerPair['answer'] as Widget,
          ),
      ],
    ),
  );
}
