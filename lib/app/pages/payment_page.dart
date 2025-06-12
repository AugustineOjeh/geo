import 'package:flutter/material.dart';
import 'package:grace_ogangwu/app/core/navigation_manager.dart';
import 'package:grace_ogangwu/app/core/student_model.dart';
import 'package:grace_ogangwu/app/helpers/user_and_student.dart';
import 'package:grace_ogangwu/components/components.dart';
import 'package:grace_ogangwu/constants/constants.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({
    this.studentId,
    this.tier,
    this.price,
    this.bookingCount,
    super.key,
  });
  final String? studentId;
  final String? tier;
  final double? price;
  final int? bookingCount;

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  Map<String, dynamic>? _booking;
  bool _loadingPage = false;
  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() async {
    setState(() => _loadingPage = true);
    try {
      if (widget.bookingCount == null ||
          widget.tier == null ||
          widget.price == null) {
        NavigationManager.pushReplacement(PageNames.booking);
        return;
      }
      if (widget.studentId == null) {
        NavigationManager.pushReplacement(
          PageNames.chooseStudent,
          arguments: {
            'pricing': widget.price,
            'tier': widget.tier,
            'booking-count': widget.bookingCount,
          },
        );
        return;
      }
      final bookingCreated = await _createBooking();
      if (bookingCreated) {
        _checkOutOnStripe();
      }
    } finally {
      setState(() => _loadingPage = false);
    }
  }

  Future<bool> _createBooking() async {
    final res = await AppHelper.createBooking(
      context,
      tier: widget.tier!,
      studentId: widget.studentId!,
      maxSlots: widget.bookingCount!,
    );
    setState(() => _booking = res);
    return res == null ? false : true;
  }

  void _checkOutOnStripe() async {
    // TODO: Implement Stripe checkout
    // On successful pament run next method
    _onPaymentCompleted();
  }

  void _onPaymentCompleted() {
    NavigationManager.pushReplacement(
      PageNames.calendar,
      arguments: {
        'student': Student.fromMap(_booking?['students']),
        'booking-count': widget.bookingCount,
        'booking-id': _booking?['id'],
      },
    );
  }

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
            prefixText: 'Book classes',
            headline: 'Complete payment',
          ),
          _loadingPage
              ? SizedBox(
                  child: Center(
                    child: CircularProgressIndicator(
                      color: CustomColors.primary,
                      strokeWidth: 2,
                    ),
                  ),
                )
              : SizedBox(
                  // TODO: Implement the Stripe check out logic
                ),
        ],
      ),
    ),
  );
}
