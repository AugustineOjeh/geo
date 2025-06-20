import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
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
  Map<String, dynamic>? _booking;
  double? _amountDue;
  bool _loadingPage = false;
  bool _processingPayment = false;

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
  Widget build(BuildContext context) => Container(
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
                  ],
                ),
        ],
      ),
    ),
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
      final amountInCents = widget.price! * widget.bookingCount! * 100;
      // Fetch parent email from auth
      final user = Supabase.instance.client.auth.currentUser;
      if (user == null) {
        CustomSnackbar.main(context, message: 'User is not signed in');
        return;
      }
      // 1. Create Payment Intent
      final clientSecret = await AppHelper.createPaymentIntent(
        context,
        amountInCents: int.parse(amountInCents.toString()),
        studentId: widget.student!.id,
        currency: 'usd',
        tier: widget.tier!,
        parentEmail: user.email!,
      );
      if (clientSecret == null && mounted) {
        CustomSnackbar.main(
          context,
          message: 'Failed to initialize payment. Try again!',
        );
        return;
      }
      // 2. Initialize payment
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: clientSecret,
          merchantDisplayName: 'Pay Grace Ogangwu',
          style: ThemeMode.light,
        ),
      );
      // 3. Present the payment sheet
      final payment = await Stripe.instance.presentPaymentSheet();
      if (payment == null || !mounted) return;
      // 4. Create booking
      final booking = await _createBooking();
      if (!booking) return;
      _onPaymentCompleted();
    } on StripeException catch (e) {
      print(e.error);
      if (!mounted) return;
      if (e.error.localizedMessage == null ||
          e.error.localizedMessage!.isEmpty) {
        CustomSnackbar.main(
          context,
          message: 'Payment failed unexpectedly. Try again.',
        );
      } else {
        CustomSnackbar.main(context, message: e.error.localizedMessage!);
      }
    } catch (e) {
      if (!mounted) return;
      print(e);
      CustomSnackbar.main(
        context,
        message: 'Payment failed unexpectedly. Try again.',
      );
    } finally {
      setState(() => _processingPayment = false);
    }
  }

  Future<bool> _createBooking() async {
    final amount = widget.price! * widget.bookingCount! * 100;
    final res = await AppHelper.createBooking(
      context,
      tier: widget.tier!,
      studentId: widget.student!.id,
      slotsRequired: widget.bookingCount!,
      amountPaid: int.parse(amount.toString()),
    );
    setState(() => _booking = res);
    return res == null ? false : true;
  }

  void _onPaymentCompleted() {
    NavigationManager.pushReplacement(
      PageNames.calendar,
      arguments: {
        'student': Student.fromMap(_booking?['students']),
        'booking-count': widget.bookingCount,
        'tier': widget.tier,
        'booking-id': _booking?['id'],
      },
    );
  }
}
