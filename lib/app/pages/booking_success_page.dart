import 'package:flutter/material.dart';
import 'package:grace_ogangwu/app/core/navigation_manager.dart';
import 'package:grace_ogangwu/app/core/student_model.dart';
import 'package:grace_ogangwu/components/components.dart';
import 'package:grace_ogangwu/constants/constants.dart';

class BookingSuccessPage extends StatelessWidget {
  const BookingSuccessPage({
    required this.bookingCount,
    required this.student,
    required this.tier,
    super.key,
  });
  final int bookingCount;
  final Student student;
  final String tier;

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
          Text(
            'Classes booked successfully!',
            style: CustomTextStyle.headlineMedium(context),
          ),
          Text(
            'Check the calendar event for each class scheduled class for link to join the class.',
            style: CustomTextStyle.headlineSmall(
              context,
              color: CustomColors.text,
            ),
          ),

          Container(
            width: double.infinity,
            padding: EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: CustomColors.foreground,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 32,
              children: [
                _data(
                  context,
                  prefix: 'student',
                  info: '${student.name} (${student.age})',
                ),
                _data(context, prefix: 'Plan', info: tier),
                _data(
                  context,
                  prefix: 'Sessions',
                  info: bookingCount.toString(),
                ),
                CustomButton.primary(
                  context,
                  label: 'Book another class',
                  onTap: () =>
                      NavigationManager.pushReplacement(PageNames.booking),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _data(
  BuildContext context, {
  required String prefix,
  required String info,
}) => Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  spacing: 12,
  children: [
    Text(prefix, style: CustomTextStyle.bodyMedium(context)),
    Text(info, style: CustomTextStyle.headlineSmall(context)),
  ],
);
