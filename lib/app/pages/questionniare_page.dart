import 'package:flutter/material.dart';
import 'package:grace_ogangwu/app/core/navigation_manager.dart';
import 'package:grace_ogangwu/app/core/student_model.dart';
import 'package:grace_ogangwu/app/helpers/app_helper.dart';
import 'package:grace_ogangwu/components/components.dart';
import 'package:grace_ogangwu/constants/constants.dart';

class QuestionniarePage extends StatefulWidget {
  const QuestionniarePage({required this.student, super.key});
  final Student student;

  @override
  State<QuestionniarePage> createState() => _QuestionniarePageState();
}

class _QuestionniarePageState extends State<QuestionniarePage> {
  final _formKey = GlobalKey<FormState>();
  String? _ageGrade;
  String? _englishIsFirstLang;
  String? _readingLevel;
  String? _writingLevel;
  String? _canHoldConversation;
  final List<String> _motivators = [];
  String? _challengeResponse;
  String? _primaryGoal;
  final _firstLanguageController = TextEditingController();
  final _improvementController = TextEditingController();
  final _noteController = TextEditingController();
  final _learningDifficultiesController = TextEditingController();
  bool _loading = false;
  bool _errorFound = false;

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
                _multipleChoiceQuestion(
                  context,
                  question: 'What is your child\'s age grade?',
                  errorFound: _errorFound && _ageGrade == null,
                  options: [
                    'Preschool (2-5)',
                    'Kindergarten',
                    'Grade 1',
                    'Grade 2',
                    'Grade 3',
                    'Others',
                  ],
                  onOptionPressed: (List<String> options, int index) =>
                      setState(() => _ageGrade = options[index]),
                  selectedOptions: [_ageGrade],
                ),
                _multipleChoiceQuestion(
                  context,
                  question: 'Is English their first language?',
                  errorFound: _errorFound && _englishIsFirstLang == null,
                  options: ['Yes', 'No'],
                  onOptionPressed: (List<String> options, int index) =>
                      setState(() => _englishIsFirstLang = options[index]),
                  selectedOptions: [_englishIsFirstLang],
                ),
                Column(
                  spacing: 16,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'If English is not their first language, please what is their first language?',
                      style: CustomTextStyle.bodyLarge(
                        context,
                        color: CustomColors.black,
                      ),
                    ),
                    CustomFields.text(
                      context,
                      controller: _firstLanguageController,
                      validator: (value) {
                        if (_englishIsFirstLang == 'Yes') return null;
                        if (value == null || value.trim().isEmpty) {
                          return 'Provide first language';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ],
                ),
                _multipleChoiceQuestion(
                  context,
                  question: 'How would you describe their reading level?',
                  options: [
                    'Pre-reader (recognizes letters/sounds)',
                    'Beginner (reads simple words)',
                    'Intermediate (reads short sentences)',
                    'Advanced (reads paragraphs fluently)',
                  ],
                  errorFound: _errorFound && _readingLevel == null,
                  onOptionPressed: (List<String> options, int index) =>
                      setState(() => _readingLevel = options[index]),
                  selectedOptions: [_readingLevel],
                ),
                _multipleChoiceQuestion(
                  context,
                  question: 'How would you describe their writing ability?',
                  options: [
                    'Scribbles/draws letters',
                    'Writes single words',
                    'Writes short sentences',
                    'Writes paragraphs with guidance',
                  ],
                  onOptionPressed: (List<String> options, int index) =>
                      setState(() => _writingLevel = options[index]),
                  selectedOptions: [_writingLevel],
                  errorFound: _errorFound && _writingLevel == null,
                ),
                _multipleChoiceQuestion(
                  context,
                  question: 'Can they hold a basic conversation in English?',
                  options: [
                    'Not yet',
                    'Yes, with simple phrases',
                    'Yes, fluently',
                  ],
                  onOptionPressed: (List<String> options, int index) =>
                      setState(() => _canHoldConversation = options[index]),
                  selectedOptions: [_canHoldConversation],
                  errorFound: _errorFound && _canHoldConversation == null,
                ),
                _multipleChoiceQuestion(
                  context,
                  question: 'What motivates your child to learn? (Select all)',
                  options: [
                    'Games/interactive activities',
                    'Stories/books',
                    'Rewards (e.g., stickers, praise)',
                    'Visual aids (videos, pictures)',
                    'Hands-on activities (e.g., writing/drawing)',
                  ],
                  onOptionPressed: (List<String> options, int index) =>
                      setState(() {
                        if (_motivators.contains(options[index])) {
                          _motivators.removeWhere((a) => a == options[index]);
                        } else {
                          _motivators.add(options[index]);
                        }
                      }),
                  selectedOptions: _motivators,
                  errorFound: _errorFound && _motivators.isEmpty,
                ),
                _multipleChoiceQuestion(
                  context,
                  question:
                      'How does your child typically respond to challenges?',
                  options: [
                    'Gets frustrated easily',
                    'Asks for help',
                    'Keeps trying independently',
                    'Avoids difficult tasks',
                  ],
                  onOptionPressed: (List<String> options, int index) =>
                      setState(() => _challengeResponse = options[index]),
                  selectedOptions: [_challengeResponse],
                  errorFound: _errorFound && _challengeResponse == null,
                ),
                _multipleChoiceQuestion(
                  context,
                  question:
                      'What is the PRIMARY goal for this private tutoring?',
                  options: [
                    'Improve reading fluency',
                    'Improve writing skills',
                    'Improve speaking confidence',
                    'Develop better grammar/vocabulary',
                    'School readiness (Kindergarten)',
                    'Learn English as second language',
                  ],
                  onOptionPressed: (List<String> options, int index) =>
                      setState(() => _primaryGoal = options[index]),
                  selectedOptions: [_primaryGoal],
                  errorFound: _errorFound && _primaryGoal == null,
                ),
                Column(
                  spacing: 16,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Share any specific areas needing improvement',
                      style: CustomTextStyle.bodyLarge(
                        context,
                        color: CustomColors.black,
                      ),
                    ),
                    CustomFields.text(
                      context,
                      controller: _improvementController,
                    ),
                  ],
                ),
                Column(
                  spacing: 16,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Does your child have any learning differences or diagnoses? (E.g., dyslexia, ADHD)',
                      style: CustomTextStyle.bodyLarge(
                        context,
                        color: CustomColors.black,
                      ),
                    ),
                    CustomFields.text(
                      context,
                      controller: _learningDifficultiesController,
                    ),
                  ],
                ),
                Column(
                  spacing: 16,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Please, feel free to share any additional information that you think should be brought to my awareness',
                      style: CustomTextStyle.bodyLarge(
                        context,
                        color: CustomColors.black,
                      ),
                    ),
                    CustomFields.text(context, controller: _noteController),
                  ],
                ),
              ],
            ),
          ),
          CustomButton.primary(
            context,
            isLoading: _loading,
            label: 'Submit',
            onTap: _submit,
          ),
        ],
      ),
    ),
  );

  bool _validateForm() {
    final formIsValid = _formKey.currentState?.validate() ?? false;
    final anMcqIsUnanswered =
        _ageGrade == null ||
        _englishIsFirstLang == null ||
        _readingLevel == null ||
        _writingLevel == null ||
        _canHoldConversation == null ||
        _motivators.isEmpty ||
        _challengeResponse == null ||
        _primaryGoal == null;
    if (anMcqIsUnanswered) {
      setState(() => _errorFound = true);
    }
    return formIsValid && !anMcqIsUnanswered;
  }

  void _submit() async {
    if (!_validateForm()) return;
    setState(() => _loading = true);
    final String firstLang = _englishIsFirstLang == 'Yes'
        ? 'English'
        : _firstLanguageController.text.trim();
    final data = <String, dynamic>{
      'student_id': widget.student.id,
      'age_grade': _ageGrade!,
      'first_language': firstLang,
      'reading_level': _readingLevel!,
      'writing_ability': _writingLevel!,
      'can_hold_conversation': _canHoldConversation!,
      'motivators': _motivators,
      'challenge_response': _challengeResponse!,
      'primary_goal': _primaryGoal!,
      'improvement_areas': _improvementController.text.trim().isEmpty
          ? null
          : _improvementController.text.trim(),
      'learning_difficulties':
          _learningDifficultiesController.text.trim().isEmpty
          ? null
          : _learningDifficultiesController.text.trim(),
      'additional_note': _noteController.text.trim().isEmpty
          ? null
          : _noteController.text.trim(),
    };
    try {
      final res = await AppHelper.submitQuestionnaire(context, data: data);
      if (!res) return;
      NavigationManager.pushReplacement(PageNames.bookingCompleted);
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

Widget _multipleChoiceQuestion(
  BuildContext context, {
  required List<String> options,
  required String question,
  required void Function(List<String>, int) onOptionPressed,
  required List<String?> selectedOptions,
  required bool errorFound,
}) => Column(
  spacing: 16,
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Text(
      question,
      style: CustomTextStyle.bodyLarge(context, color: CustomColors.black),
    ),
    if (errorFound)
      Text(
        'Please, answer this question',
        style: CustomTextStyle.bodyMedium(context, color: Colors.redAccent),
      ),
    ListView.builder(
      itemCount: options.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final op = options[index];
        final isSelected = selectedOptions.contains(op);
        return GestureDetector(
          onDoubleTap: () => onOptionPressed(options, index),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Row(
              spacing: 16,
              children: [
                Icon(
                  isSelected ? Icons.check_box : Icons.check_box_outline_blank,
                  size: 20,
                  color: CustomColors.black,
                ),
                Text(
                  op,
                  style: CustomTextStyle.bodyLarge(
                    context,
                    color: CustomColors.black,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ),
  ],
);
