import 'package:flutter/material.dart';
import 'package:grace_ogangwu/app/core/navigation_manager.dart';
import 'package:grace_ogangwu/app/core/student_model.dart';
import 'package:grace_ogangwu/app/helpers/app_helper.dart';
import 'package:grace_ogangwu/app/widgets/calendly_iframe.dart';
import 'package:grace_ogangwu/components/components.dart';
import 'package:grace_ogangwu/constants/styles.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
  late String _calendlyUrl;

  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() {
    final user = Supabase.instance.client.auth.currentUser;
    setState(
      () => _calendlyUrl =
          'https://calendly.com/g-ogangwu/book-premium-class?email=${user!.email}&name=${widget.student.name}&a1=student_${widget.student.id}&a2=booking_${widget.bookingId}&hide_email=1&hide_name=1',
    );
  }

  @override
  Widget build(BuildContext context) => SizedBox(
    width: double.infinity,
    child: Column(
      spacing: 32,
      children: [
        SectionHeader.app(
          context,
          isCentered: true,
          prefixText: 'Schedule classes',
          headline: 'Select date and time for class ${_bookedSlots + 1}',
        ),
        _loading
            ? Center(
                child: CircularProgressIndicator(
                  color: CustomColors.primary,
                  strokeWidth: 2,
                ),
              )
            : SizedBox(
                child: CalendlyIframe(
                  iframeUrl: _calendlyUrl,
                  onEventScheduled: _onSessionBooked,
                ),
              ),
      ],
    ),
  );

  void _onSessionBooked() async {
    if (_bookedSlots >= widget.bookingCount) {
      _onBookingCompleted();
      return;
    }
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
