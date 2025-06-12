import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:grace_ogangwu/constants/styles.dart';
import 'package:url_launcher/url_launcher.dart';

class Faqs {
  static List<Map<String, dynamic>> questionAnswerPairs(
    BuildContext context,
  ) => [
    // Question 2
    {
      'question': 'What is the duration of a class?',
      'answer': RichText(
        text: TextSpan(
          style: CustomTextStyle.bodyMedium(context),
          children: [
            TextSpan(text: 'A class runs for 45 minutes. For kids on the '),
            TextSpan(
              text: 'Special',
              style: TextStyle(color: CustomColors.black),
            ),
            TextSpan(
              text:
                  ' package, class duration may vary depending on their unique needs.',
            ),
          ],
        ),
      ),
    },
    // Question 2
    {
      'question': 'Are the classes self-paced or live?',
      'answer': RichText(
        text: TextSpan(
          style: CustomTextStyle.bodyMedium(context),
          children: [
            TextSpan(
              text:
                  'It\'s a mix of both. Classes are 1-on-1 live sessions which are recorded so that students can rewatch at any time. \n\nStudents will also have access to structured class resources (like the quizzes and Whiteboard used for the class). \n\nTo make it easy to find relevant resources, each class is shared as a Drive folder containing the session recording and accompanying resources.',
            ),
          ],
        ),
      ),
    },
    // Question 3
    {
      'question': 'Which tools are needed for learning?',
      'answer': Column(
        spacing: 4,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            spacing: 8,
            children: [
              Text('1.', style: CustomTextStyle.bodyMedium(context)),
              Expanded(
                child: SizedBox(
                  child: RichText(
                    text: TextSpan(
                      style: CustomTextStyle.bodyMedium(context),
                      children: [
                        TextSpan(
                          text:
                              'A computer with microphone and webcam feature (recommended), tablet, OR smartphone.',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            spacing: 8,
            children: [
              Text('2.', style: CustomTextStyle.bodyMedium(context)),
              Expanded(
                child: SizedBox(
                  child: RichText(
                    text: TextSpan(
                      style: CustomTextStyle.bodyMedium(context),
                      children: [
                        TextSpan(
                          text:
                              'Internet connection with speed of 1.5 Mbps or higher (test your internet speed ',
                        ),
                        linkSpan(
                          context,
                          text: 'here',
                          url: 'https://fast.com/',
                        ),
                        TextSpan(text: ').'),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            spacing: 8,
            children: [
              Text('3.', style: CustomTextStyle.bodyMedium(context)),
              Expanded(
                child: SizedBox(
                  child: RichText(
                    text: TextSpan(
                      style: CustomTextStyle.bodyMedium(context),
                      text: 'A web browser (e.g. Google Chrome).',
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            spacing: 8,
            children: [
              Text('4.', style: CustomTextStyle.bodyMedium(context)),
              Expanded(
                child: SizedBox(
                  child: RichText(
                    text: TextSpan(
                      style: CustomTextStyle.bodyMedium(context),
                      children: [
                        TextSpan(
                          text:
                              'A Gmail account for Google Meet (parents can create and manage a child account via ',
                        ),
                        linkSpan(
                          context,
                          text: 'Google Family Link',
                          url: 'https://families.google/familylink/',
                        ),
                        TextSpan(
                          text:
                              ' or students can use account of a supervisory adult).',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    },
    // Question 4
    {
      'question':
          'What happens if we experience technical issues during a class?',
      'answer': RichText(
        text: TextSpan(
          style: CustomTextStyle.bodyMedium(context),
          text:
              'Classes disrupted by technical issues can be rescheduled. Kindly reach out to discuss availability.',
        ),
      ),
    },
    // Question 5
    {
      'question': 'Can I attend or observe my child\'s sessions?',
      'answer': RichText(
        text: TextSpan(
          style: CustomTextStyle.bodyMedium(context),
          text:
              'Yes. Adult supervision is required whenever children interface with technology. As a result of this, students must be within eyeshot of a competent adult who may [not necessarily] be a parent. \n\nFor kids below 6 years old, close supervision may be necessary. For older kids, however, I recommend independence. In any case, observers are always welcome.',
        ),
      ),
    },
    // Question 6
    {
      'question': 'Which curriculum standards do you follow?',
      'answer': RichText(
        text: TextSpan(
          style: CustomTextStyle.bodyMedium(context),
          children: [
            TextSpan(
              text:
                  'My curriculum is aligned with Global Foundational Literacy Standards as defined by the ',
            ),
            linkSpan(
              context,
              text: 'International Literacy Association',
              url: 'https://www.literacyworldwide.org/',
            ),
            TextSpan(
              text:
                  ' (ILA) and United Nations. \n\nHowever, the pacing and content of the learning experience is adapted to each student\'s needs.',
            ),
          ],
        ),
      ),
    },
    // Question 7
    {
      'question': 'Are there discounts for siblings?',
      'answer': RichText(
        text: TextSpan(
          style: CustomTextStyle.bodyMedium(context),
          text: 'Yes. Contact me for Family Bundle pricing.',
        ),
      ),
    },
  ];
}

TextSpan linkSpan(
  BuildContext context, {
  required String text,
  required String url,
}) => TextSpan(
  text: text,
  mouseCursor: SystemMouseCursors.click,
  recognizer: TapGestureRecognizer()
    ..onTap = () async {
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, webOnlyWindowName: '_blank');
      }
    },
  style: TextStyle(
    color: CustomColors.black,
    decoration: TextDecoration.underline,
  ),
);

TextSpan redirectSpan(
  BuildContext context, {
  required String text,
  required VoidCallback onTap,
}) => TextSpan(
  text: text,
  mouseCursor: SystemMouseCursors.click,
  recognizer: TapGestureRecognizer()..onTap = onTap,
  style: TextStyle(
    color: CustomColors.black,
    decoration: TextDecoration.underline,
  ),
);
