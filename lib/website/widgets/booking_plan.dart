import 'package:flutter/material.dart';
import 'package:grace_ogangwu/components/buttons.dart';
import 'package:grace_ogangwu/constants/sizes.dart';
import 'package:grace_ogangwu/constants/styles.dart';

class BookingPlan extends StatefulWidget {
  const BookingPlan({
    required this.planName,
    required this.price,
    required this.onButtonTap,
    required this.benefits,
    required this.benefitPrefix,
    this.discount,
    this.minimumBooking = 1,
    this.isPopular = false,
    this.isCustom = false,
    super.key,
  });
  final String planName;
  final double price;
  final double? discount;
  final int minimumBooking;
  final bool isPopular;
  final bool isCustom;
  final void Function(int, double, String) onButtonTap;
  final List<Map<String, dynamic>> benefits;
  final String benefitPrefix;

  @override
  State<BookingPlan> createState() => _BookingPlanState();
}

class _BookingPlanState extends State<BookingPlan> {
  late int _bookingCount;

  @override
  void initState() {
    super.initState();
    _bookingCount = widget.minimumBooking;
  }

  void _decrementBooking() {
    if (_bookingCount <= widget.minimumBooking) return;
    setState(() => _bookingCount--);
  }

  void _increamentBooking() => setState(() => _bookingCount++);

  @override
  Widget build(BuildContext context) => Stack(
    clipBehavior: Clip.none,
    children: [
      Container(
        padding: EdgeInsets.fromLTRB(16, 40, 16, 24),
        clipBehavior: Clip.hardEdge,
        constraints: BoxConstraints(minHeight: 600),
        // height: 600,
        width: double.infinity,
        decoration: BoxDecoration(
          color: CustomColors.foreground,
          borderRadius: BorderRadius.circular(32),
          border: Border.all(
            width: 1,
            color: widget.isPopular
                ? CustomColors.primary
                : CustomColors.text.withValues(alpha: 0.2),
          ),
        ),
        child: Column(
          spacing: 24,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 30,
              child: Row(
                spacing: 8,
                children: [
                  Text(
                    widget.planName,
                    style: CustomTextStyle.headlineMedium(
                      context,
                    ).copyWith(fontSize: 24),
                  ),
                  if (widget.discount != null && widget.discount! > 0)
                    _discountDisplay(context, discount: widget.discount!),
                ],
              ),
            ),
            Row(
              spacing: 4,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  widget.isCustom ? '' : '\$${widget.price.toString()}',
                  style: CustomTextStyle.headlineMedium(
                    context,
                  ).copyWith(fontSize: 32),
                ),
                Text(
                  widget.isCustom ? 'Custom pricing' : '/class',
                  style: CustomTextStyle.bodyLarge(
                    context,
                  ).copyWith(fontSize: 20, height: 0.95),
                ),
              ],
            ),
            widget.isCustom
                ? SizedBox(
                    height: 36,
                    child: Text(
                      'For students with unique needs.',
                      style: CustomTextStyle.bodyMedium(
                        context,
                        color: CustomColors.black,
                      ),
                    ),
                  )
                : _bookingCounter(
                    context,
                    count: _bookingCount,
                    increment: _increamentBooking,
                    decrement: _decrementBooking,
                  ),
            CustomButton.primary(
              context,
              label: widget.isCustom
                  ? 'Contact me'
                  : _bookingCount > 1
                  ? 'Book classes'
                  : 'Book a class',
              onTap: () => widget.onButtonTap(
                _bookingCount,
                widget.price,
                widget.planName,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 8,
              children: [
                Padding(
                  padding: EdgeInsetsGeometry.only(top: 8),
                  child: Text(
                    widget.benefitPrefix,
                    style: CustomTextStyle.bodyMedium(
                      context,
                      color: CustomColors.black,
                    ),
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: widget.benefits.length,
                  itemBuilder: (context, index) {
                    final map = widget.benefits[index];
                    final Widget icon = Icon(
                      map['available'] as bool
                          ? Icons.info_outline
                          : Icons.close,
                      size: 16,
                      color: CustomColors.text,
                    );
                    final benefit = map['benefit'] as String;
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 3),
                      child: Row(
                        spacing: 8,
                        children: [
                          icon,
                          Flexible(
                            child: Text(
                              benefit,
                              style: CustomTextStyle.bodyMedium(context),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      if (widget.isPopular)
        Positioned(
          top: -17,
          left: 0,
          right: 0,
          child: Center(child: _mostPopularLabel(context)),
        ),
    ],
  );
}

Widget _bookingCounter(
  BuildContext context, {
  required int count,
  required VoidCallback increment,
  required VoidCallback decrement,
}) => Row(
  mainAxisSize: MainAxisSize.min,
  spacing: 8,
  children: [
    Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      width: 64,
      height: 36,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          width: 1,
          color: CustomColors.black.withValues(alpha: 0.2),
        ),
      ),
      child: Text(
        count.toString(),
        style: CustomTextStyle.bodyMedium(context).copyWith(fontSize: 20),
      ),
    ),
    CustomButton.icon(
      context,
      tooltip: 'Remove a session',
      onTap: decrement,
      icon: Icons.remove,
    ),
    CustomButton.icon(
      context,
      tooltip: 'Add more sessions',
      onTap: increment,
      isPrimary: true,
      icon: Icons.add,
    ),
  ],
);

Widget _discountDisplay(BuildContext context, {required double discount}) =>
    Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: CustomColors.primary,
      ),
      child: Text(
        'save ${discount.toString()}%',
        style: CustomTextStyle.bodyMedium(
          context,
        ).copyWith(fontSize: 14, color: CustomColors.foreground),
      ),
    );

Widget _mostPopularLabel(BuildContext context) => Container(
  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(8),
    border: Border.all(width: 1, color: CustomColors.primary),
    color: CustomColors.foreground,
  ),
  child: Text(
    'MOST POPULAR',
    style: CustomTextStyle.bodyMedium(context).copyWith(
      fontSize: 14,
      fontWeight: CustomFontWeight.bold,
      color: CustomColors.primary,
    ),
  ),
);
