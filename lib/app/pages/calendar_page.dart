import 'package:flutter/material.dart';
import 'package:grace_ogangwu/app/core/navigation_manager.dart';
import 'package:grace_ogangwu/app/core/student_model.dart';
import 'package:grace_ogangwu/app/helpers/app_helper.dart';
import 'package:grace_ogangwu/components/components.dart';
import 'package:grace_ogangwu/constants/styles.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:webview_flutter/webview_flutter.dart';

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
  bool _loadingPage = false;
  int _bookedSlots = 0;
  late String _email;
  late WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() {
    final user = Supabase.instance.client.auth.currentUser;
    setState(() {
      _loadingPage = true;
      _email = user!.email!;
      _controller = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..addJavaScriptChannel(
          'FlutterWebViewPlugin',
          onMessageReceived: (message) async {
            if (message.message == 'event_scheduled') _onSessionBooked();
          },
        )
        ..loadHtmlString(
          _calendlyEmbedHtml(
            name: widget.student.name,
            email: _email,
            studentId: widget.student.id,
            bookingId: widget.bookingId,
          ),
        );
    });
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
        _loadingPage || _loading
            ? Center(
                child: CircularProgressIndicator(
                  color: CustomColors.primary,
                  strokeWidth: 2,
                ),
              )
            : SizedBox(child: WebViewWidget(controller: _controller)),
      ],
    ),
  );
  String _calendlyEmbedHtml({
    required String name,
    required String email,
    required String studentId,
    required String bookingId,
  }) {
    return '''
   <!DOCTYPE html>
<html>
  <head>
    <script src="https://assets.calendly.com/assets/external/widget.js" type="text/javascript"></script>
  </head>
  <body>
    <div id="calendly-container"></div>

    <script type="text/javascript">
      function loadCalendly() {
        Calendly.initInlineWidget({
          url: 'https://calendly.com/g-ogangwu/book-premium-class',
          parentElement: document.getElementById('calendly-container'),
          prefill: {
            name: "$name",
            email: "$email",
            customAnswers: {
              a1: "student_id: $studentId",
              a2: "booking_id: $bookingId"
            }
          },
          utm: {},
        });
      }

      window.addEventListener('message', function(e) {
        if (e.origin === "https://calendly.com" && e.data.event === "calendly.event_scheduled") {
          // Send message to Flutter
          if (window.FlutterWebviewPlugin) {
            window.FlutterWebviewPlugin.postMessage("event_scheduled");
          } else if (window.flutter_inappwebview) {
            window.flutter_inappwebview.callHandler('eventScheduled');
          } else {
            window.parent.postMessage("event_scheduled", "*");
          }
        }
      });

      loadCalendly();
    </script>
  </body>
</html>
    ''';
  }

  void _onSessionBooked() async {
    if (_bookedSlots >= widget.bookingCount) {
      _onBookingCompleted();
      return;
    }
    final newSlotCount = _bookedSlots + 1;
    final res = await AppHelper.updateBookedSlots(
      context,
      data: newSlotCount,
      bookingId: widget.bookingId,
    );
    if (res == null && mounted) {
      CustomSnackbar.main(
        context,
        message:
            'Something went wrong. Continue booking while we rectify things',
      );
    }
    setState(() => _bookedSlots = newSlotCount);
    _reloadCalendly();
  }

  void _reloadCalendly() {
    _controller.runJavaScript('loadCalendly();');
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
