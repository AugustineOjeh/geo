import 'package:flutter/material.dart';
import 'package:grace_ogangwu/components/buttons.dart';
import 'package:grace_ogangwu/constants/sizes.dart';
import 'package:grace_ogangwu/constants/styles.dart';

class ProcessBox extends StatefulWidget {
  const ProcessBox({
    required this.onTap,
    required this.prefix,
    required this.title,
    required this.description,
    required this.hideDescrition,
    required this.isMobile,
    required this.image,
    this.willNavigate = false,
    this.padding,
    this.isSelected,
    super.key,
  });
  final EdgeInsets? padding;
  final bool? isSelected;
  final VoidCallback onTap;
  final String prefix;
  final String title;
  final String image;
  final String description;
  final bool hideDescrition;
  final bool isMobile;
  final bool willNavigate;

  @override
  State<ProcessBox> createState() => _ProcessBoxState();
}

class _ProcessBoxState extends State<ProcessBox> {
  bool _isHovered = false;
  @override
  Widget build(BuildContext context) => MouseRegion(
    cursor: SystemMouseCursors.click,
    onEnter: (event) => setState(() => _isHovered = true),
    onExit: (event) => setState(() => _isHovered = false),
    child: GestureDetector(
      onTap: widget.onTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        padding:
            widget.padding ??
            EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        decoration: BoxDecoration(color: _backgroundColor()),
        child: widget.isMobile ? _mobileView(context) : _desktopView(context),
      ),
    ),
  );
  Widget _mobileView(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    spacing: 24,
    children: [
      Container(
        padding: widget.padding != null
            ? const EdgeInsets.only(right: 20)
            : null,
        child: Row(
          spacing: 16,
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  width: 1,
                  color: _foregroundColor(opacity: 0.3),
                ),
              ),
              child: Text(
                widget.prefix,
                style: CustomTextStyle.bodyMedium(
                  context,
                  color: _foregroundColor(opacity: 0.5),
                ),
              ),
            ),
            if (widget.willNavigate) const Spacer(),
            if (widget.willNavigate)
              CustomButton.arrowIcon(context, isRight: true, onTap: () {}),
          ],
        ),
      ),
      Container(
        padding: widget.padding != null
            ? const EdgeInsets.only(right: 20)
            : null,
        child: Text(
          widget.title,
          style: CustomTextStyle.headlineSmall(context).copyWith(
            letterSpacing: FontSizes.headlineSmall(context) * 0.05,
            color: _foregroundColor(),
          ),
        ),
      ),
      if (!widget.hideDescrition)
        Container(
          padding: widget.padding != null
              ? const EdgeInsets.only(right: 20)
              : null,
          child: Text(
            widget.description,
            style: CustomTextStyle.bodyMedium(
              context,
            ).copyWith(color: _foregroundColor()),
          ),
        ),
      Image.asset(widget.image, width: double.infinity, fit: BoxFit.fill),
    ],
  );

  Widget _desktopView(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    spacing: 24,
    children: [
      Container(
        padding: widget.padding != null
            ? const EdgeInsets.only(right: 20)
            : null,
        child: Row(
          spacing: Spacing.medium(context),
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 24,
              children: [
                Row(
                  spacing: 16,
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          width: 1,
                          color: _foregroundColor(opacity: 0.3),
                        ),
                      ),
                      child: Text(
                        widget.prefix,
                        style: CustomTextStyle.bodyMedium(
                          context,
                          color: _foregroundColor(opacity: 0.5),
                        ),
                      ),
                    ),
                    if (widget.willNavigate) const Spacer(),
                    if (widget.willNavigate)
                      CustomButton.arrowIcon(
                        context,
                        isRight: true,
                        onTap: () {},
                      ),
                  ],
                ),
                Text(
                  widget.title,
                  style: CustomTextStyle.headlineSmall(context).copyWith(
                    letterSpacing: FontSizes.headlineSmall(context) * 0.05,
                    color: _foregroundColor(),
                  ),
                ),
              ],
            ),
            if (!widget.hideDescrition)
              Text(
                widget.description,
                style: CustomTextStyle.bodyMedium(
                  context,
                ).copyWith(color: _foregroundColor()),
              ),
          ],
        ),
      ),
      Image.asset(widget.image, width: double.infinity, fit: BoxFit.fill),
    ],
  );

  Color _backgroundColor() =>
      widget.isSelected == true || (widget.isSelected == null && _isHovered)
      ? CustomColors.primary
      : CustomColors.foreground;
  Color _foregroundColor({double? opacity}) =>
      widget.isSelected == true || (widget.isSelected == null && _isHovered)
      ? CustomColors.foreground.withValues(alpha: opacity)
      : CustomColors.black.withValues(alpha: opacity);
}
