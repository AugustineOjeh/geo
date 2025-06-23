import 'package:flutter/material.dart';
import 'package:grace_ogangwu/app/core/navigation_manager.dart';
import 'package:grace_ogangwu/app/core/student_model.dart';
import 'package:grace_ogangwu/app/helpers/app_helper.dart';
import 'package:grace_ogangwu/app/widgets/calendly_iframe.dart';
import 'package:grace_ogangwu/components/components.dart';
import 'package:grace_ogangwu/constants/sizes.dart';
import 'package:grace_ogangwu/constants/styles.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({
    required this.student,
    required this.bookingId,
    required this.tier,
    required this.bookingCount,
    required this.email,
    super.key,
  });
  final Student student;
  final String bookingId;
  final String tier;
  final String email;
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
  }

  @override
  Widget build(BuildContext context) => SizedBox(
    child: Column(
      spacing: 32,
      children: [
        SectionHeader.app(
          context,
          isCentered: true,
          prefixText: 'Schedule classes',
          headline: 'Select date and time for class #${_bookedSlots + 1}',
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

                      child: CalendlyIframe(
                        iframeUrl:
                            'https://calendly.com/g-ogangwu/book-premium-class?email=${widget.email}&name=${widget.student.name}&a1=student-${widget.student.id}&a2=booking-${widget.bookingId}&hide_email=1&hide_name=1&a3=slot-${_bookedSlots + 1}',
                        width: Device.isMobile(context)
                            ? double.infinity
                            : 1400,
                        height: Device.screenHeight(context) - 300,
                        onEventScheduled: _onSessionBooked,
                      ),
                    ),
                    SizedBox(
                      width: 240,
                      child: CustomButton.primary(
                        context,
                        label: (_bookedSlots + 1 >= widget.bookingCount)
                            ? 'Continue'
                            : 'Schedule class #${_bookedSlots + 2}',
                        onTap: _onSessionBooked,
                      ),
                    ),
                    SizedBox(),
                  ],
                ),
        ),
      ],
    ),
  );

  void _onSessionBooked() async {
    setState(() {
      _loading = true;
      _bookedSlots++;
    });
    try {
      final res = await AppHelper.updateBooking(
        context,
        data: {'slots_booked': _bookedSlots},
        bookingId: widget.bookingId,
      );
      if (res == null && mounted) {
        CustomSnackbar.main(
          context,
          message:
              'Something went wrong. Continue booking while we rectify things',
        );
      }
      if (_bookedSlots >= widget.bookingCount) _onBookingCompleted();
    } finally {
      setState(() => _loading = false);
    }
  }

  void _onBookingCompleted() async {
    setState(() => _loading = true);
    try {
      final res = await AppHelper.studentHasAnsweredQuestionnaire(
        context,
        studentId: widget.student.id,
      );
      if (!res) {
        NavigationManager.pushReplacement(
          PageNames.questionnaire,
          arguments: {'student': widget.student},
        );
      } else {
        NavigationManager.pushReplacement(PageNames.bookingCompleted);
      }
    } finally {
      setState(() => _loading = false);
    }
  }
}
