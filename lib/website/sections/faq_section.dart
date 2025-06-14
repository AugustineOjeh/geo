import 'package:flutter/material.dart';
import 'package:grace_ogangwu/components/section_header.dart';
import 'package:grace_ogangwu/constants/faqs.dart';
import 'package:grace_ogangwu/constants/sizes.dart';
import 'package:grace_ogangwu/website/widgets/q_and_a.dart';

class FaqSection extends StatefulWidget {
  const FaqSection({super.key});

  @override
  State<FaqSection> createState() => _FaqSectionState();
}

class _FaqSectionState extends State<FaqSection> {
  int? _visibleAnswerIndex;
  final _listOfPairs = <Map<String, dynamic>>[];

  @override
  void initState() {
    super.initState();
    final pairs = Faqs.questionAnswerPairs(context);
    _listOfPairs.addAll(pairs);
  }

  void _toggleAnswer(int index) {
    if (_visibleAnswerIndex == index) {
      setState(() => _visibleAnswerIndex = null);
    } else {
      setState(() => _visibleAnswerIndex = index);
    }
  }

  @override
  Widget build(BuildContext context) => Container(
    constraints: BoxConstraints(maxWidth: 1500),
    padding: EdgeInsets.symmetric(
      horizontal: CustomPadding.pageHorizontal(context),
      vertical: CustomPadding.sectionVertical(context),
    ),
    child: Column(
      spacing: Spacing.medium(context),
      children: [
        SectionHeader.full(
          context,
          isCentered: true,
          prefixText: 'FAQs',
          headline: 'Your concerns, addressed',
        ),
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 720),
          child: ListView.builder(
            itemCount: _listOfPairs.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final pair = _listOfPairs[index];
              final answerIsVisible =
                  _visibleAnswerIndex != null && _visibleAnswerIndex == index;
              return QAndA(
                questionAnswerPair: pair,
                answerIsVisible: answerIsVisible,
                toggleAnswer: () => _toggleAnswer(index),
              );
            },
          ),
        ),
      ],
    ),
  );
}
