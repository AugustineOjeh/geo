import 'package:flutter/material.dart';
import 'package:grace_ogangwu/app/core/navigation_manager.dart';
import 'package:grace_ogangwu/app/core/student_model.dart';
import 'package:grace_ogangwu/app/helpers/app_helper.dart';
import 'package:grace_ogangwu/components/components.dart';
import 'package:grace_ogangwu/constants/styles.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({
    required this.student,
    required this.bookingId,
    required this.tier,
    required this.bookingCount,
    super.key,
  });
  final Student student;
  final String bookingId;
  final String tier;
  final int bookingCount;

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  bool _loading = false;
  int _bookedSlots = 0;

  @override
  void initState() {
    super.initState();
    // TODO: Implement calendar webview and updated booked slots with responses.
  }

  void _onBookingCompleted() async {
    setState(() => _loading = true);
    try {
      final res = await AppHelper.checkStudentQuestionnaire(
        context,
        studentId: widget.student.id,
      );
      if (!res) {
        NavigationManager.pushReplacement(
          PageNames.questionnaire,
          arguments: {'student': widget.student},
        );
      } else {
        NavigationManager.pushReplacement(
          PageNames.bookingCompleted,
          arguments: {
            'student': widget.student,
            'sessions': widget.bookingCount,
            'tier': widget.tier,
          },
        );
      }
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) => SizedBox(
    width: double.infinity,
    child: Column(
      spacing: 32,
      children: [
        SectionHeader.full(
          context,
          prefixText: widget.bookingCount > 1
              ? 'Schedule class #${_bookedSlots + 1}'
              : 'Schedule class',
          headline: 'Select dates and time',
        ),
        _loading
            ? SizedBox(
                child: Center(
                  child: CircularProgressIndicator(
                    color: CustomColors.primary,
                    strokeWidth: 2,
                  ),
                ),
              )
            : SizedBox(
                // TODO: Implement the Calendly booking UI
              ),
      ],
    ),
  );
}
