import 'dart:async';
import 'dart:js_interop';
import 'dart:js_interop_unsafe';
import 'package:grace_ogangwu/app/widgets/payment_in_progress_card.dart';
import 'package:web/web.dart' as web;
import 'package:flutter/material.dart';
import 'package:grace_ogangwu/app/core/navigation_manager.dart';
import 'package:grace_ogangwu/app/core/student_model.dart';
import 'package:grace_ogangwu/app/helpers/app_helper.dart';
import 'package:grace_ogangwu/components/components.dart';
import 'package:grace_ogangwu/constants/constants.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({
    this.student,
    this.tier,
    this.price,
    this.bookingCount,
    super.key,
  });
  final Student? student;
  final String? tier;
  final double? price;
  final int? bookingCount;

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  StreamSubscription<web.MessageEvent>? _messageSubscription;
  Map<String, dynamic>? _booking;
  double? _amountDue;
  bool _loadingPage = false;
  bool _processingPayment = false;
  bool _showPaymentCard = false;
  bool _confirmingPayment = false;
  bool _showPaymentCancelledMessage = false;

  @override
  void initState() {
    super.initState();
    _init();
    _listenForStripePayment();
  }

  @override
  void dispose() {
    _messageSubscription?.cancel();
    super.dispose();
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
      if (widget.student == null) {
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
      final amount = widget.price! * widget.bookingCount!;
      setState(() => _amountDue = amount);
      return;
    } finally {
      setState(() => _loadingPage = false);
    }
  }

  @override
  Widget build(BuildContext context) => Stack(
    children: [
      Container(
        constraints: Device.isMobile(context)
            ? null
            : BoxConstraints(maxWidth: 320),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            spacing: 24,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SectionHeader.app(
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
                  : Column(
                      spacing: 32,
                      children: [
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: CustomColors.foreground,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: 24,
                            children: [
                              _data(
                                context,
                                prefix: 'For:',
                                info:
                                    '${widget.student!.name} (${widget.student!.age})',
                              ),
                              Row(
                                spacing: 24,
                                children: [
                                  Expanded(
                                    child: _data(
                                      context,
                                      prefix: 'Package',
                                      info: widget.tier!,
                                    ),
                                  ),
                                  Expanded(
                                    child: _data(
                                      context,
                                      prefix: 'Cost per class',
                                      info: '\$${widget.price!}',
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                spacing: 24,
                                children: [
                                  Expanded(
                                    child: _data(
                                      context,
                                      prefix: 'Classes',
                                      info: widget.bookingCount.toString(),
                                    ),
                                  ),
                                  Expanded(
                                    child: _data(
                                      context,
                                      prefix: 'Amount due',
                                      info: '\$${_amountDue.toString()}',
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        CustomButton.primary(
                          context,
                          label: 'Pay for booking: \$$_amountDue',
                          isLoading: _processingPayment,
                          onTap: _handlePayment,
                        ),
                        if (_showPaymentCancelledMessage)
                          Text(
                            'Looks like you cancelled the payment. You can try again.',
                            style: CustomTextStyle.bodyMedium(
                              context,
                              color: Colors.redAccent,
                            ),
                            textAlign: TextAlign.center,
                          ),
                      ],
                    ),
            ],
          ),
        ),
      ),
      if (_showPaymentCard)
        Positioned.fill(
          child: PaymentInProgressCard(confirmingPayment: _confirmingPayment),
        ),
    ],
  );

  Widget _data(
    BuildContext context, {
    required String prefix,
    required String info,
  }) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(prefix, style: CustomTextStyle.bodyMedium(context)),
      Text(info, style: CustomTextStyle.headlineSmall(context)),
    ],
  );

  void _handlePayment() async {
    setState(() => _processingPayment = true);
    try {
      // Fetch parent email from auth
      final user = Supabase.instance.client.auth.currentUser;
      if (user == null) {
        CustomSnackbar.main(context, message: 'User is not signed in');
        return;
      }
      // 1. Create Booking record
      final booking = await _createBooking();
      if (!booking) {
        if (!mounted) return;
        CustomSnackbar.main(
          context,
          message: 'Failed to create booking. Try again',
        );
        return;
      }
      // 2. Create Checkout Session
      if (!mounted) return;
      final sessionUrl = await AppHelper.createCheckoutSession(
        context,
        tierPrice: (widget.price! * 100),
        studentId: widget.student!.id,
        userId: user.id,
        currency: 'usd',
        bookingId: _booking!['id'],
        sessionCount: widget.bookingCount!,
        tier: widget.tier!,
        parentEmail: user.email!,
      );
      if (sessionUrl == null) {
        if (mounted) {
          CustomSnackbar.main(context, message: 'Checkout failed. Try again!');
        }
        return;
      }
      // 3. Open checkout window
      web.window.open(sessionUrl, 'Stripe Checkout');
      _showPaymentInProgressCard();
    } catch (e) {
      if (!mounted) return;
      CustomSnackbar.main(
        context,
        message: 'Payment failed unexpectedly. Try again.',
      );
      rethrow;
    } finally {
      setState(() => _processingPayment = false);
    }
  }

  void _listenForStripePayment() {
    _messageSubscription?.cancel();
    _messageSubscription = web.window.onMessage.listen((
      web.MessageEvent event,
    ) {
      try {
        final jsData = event.data;
        if (jsData != null) {
          final jsObject = jsData as JSObject;

          // Access properties directly
          final typeJS = jsObject.getProperty('type'.toJS);
          final sessionIdJS = jsObject.getProperty('sessionId'.toJS);
          if (typeJS != null) {
            final type = (typeJS as JSString).toDart;
            if (type == 'payment_success') {
              if (sessionIdJS != null) {
                final sessionId = (sessionIdJS as JSString).toDart;
                if (mounted) _confirmPayment(sessionId);
              }
            } else if (type == 'payment_cancelled') {
              _hidePaymentCard();
              if (mounted) setState(() => _showPaymentCancelledMessage = true);
            }
          }
        }
      } catch (e) {
        throw 'Error processing message: $e';
      }
    });
  }

  void _showPaymentInProgressCard() => setState(() => _showPaymentCard = true);

  void _hidePaymentCard() => setState(() => _showPaymentCard = false);

  Future<bool> _createBooking() async {
    final amount = widget.price! * widget.bookingCount! * 100;
    final res = await AppHelper.createBooking(
      context,
      tier: widget.tier!,
      studentId: widget.student!.id,
      slotsRequired: widget.bookingCount!,
      amount: int.parse(amount.toString()),
    );
    setState(() => _booking = res);
    return res == null ? false : true;
  }

  void _confirmPayment(String sessionId) async {
    setState(() => _confirmingPayment = true);
    try {
      final paymentConfirmed = await AppHelper.confirmCheckoutPayment(
        context,
        checkoutSessionId: sessionId,
      );
      if (paymentConfirmed == true) {
        final data = {'paid': true};
        if (mounted) {
          await AppHelper.updateBooking(
            context,
            data: data,
            bookingId: _booking!['id'],
          );
        }
        _onPaymentCompleted();
        return;
      } else {
        _hidePaymentCard();
        setState(() => _showPaymentCancelledMessage = true);
        return;
      }
    } finally {
      setState(() => _confirmingPayment = false);
    }
  }

  void _onPaymentCompleted() {
    final user = Supabase.instance.client.auth.currentUser;
    NavigationManager.pushReplacement(
      PageNames.calendar,
      arguments: {
        'student': widget.student,
        'booking-count': widget.bookingCount,
        'tier': widget.tier,
        'email': user!.email,
        'booking-id': 'booking_1234555', // _booking?['id'],
      },
    );
  }
}
