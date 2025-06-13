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
        clipBehavior: Clip.hardEdge,
        height: 500,
        padding:
            widget.padding ??
            EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        decoration: BoxDecoration(
          color: _backgroundColor(),
          borderRadius: BorderRadius.circular(24),
        ),
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
                ).copyWith(fontSize: 14),
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
            letterSpacing: FontSizes.headlineSmall(context) * -0.05,
            height: 1,
            fontSize: 24,
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
      Expanded(
        child: Container(
          width: double.infinity,
          margin: EdgeInsets.only(right: widget.hideDescrition ? 0 : 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: widget.hideDescrition
                  ? Radius.circular(0)
                  : Radius.circular(16),
            ),
            image: DecorationImage(
              image: AssetImage(widget.image),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
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
        child: Column(
          spacing: 12,
          crossAxisAlignment: CrossAxisAlignment.start,
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
                    ).copyWith(fontSize: 14),
                  ),
                ),
                if (widget.willNavigate) const Spacer(),
                if (widget.willNavigate)
                  CustomButton.arrowIcon(context, isRight: true, onTap: () {}),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: Spacing.medium(context),
              children: [
                Expanded(
                  child: Text(
                    widget.title,
                    style: CustomTextStyle.headlineSmall(context).copyWith(
                      letterSpacing: FontSizes.headlineSmall(context) * -0.05,
                      height: 0.95,
                      color: _foregroundColor(),
                    ),
                  ),
                ),
                if (!widget.hideDescrition)
                  Expanded(
                    child: Text(
                      widget.description,
                      style: CustomTextStyle.bodyMedium(
                        context,
                      ).copyWith(color: _foregroundColor()),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
      Expanded(
        child: Container(
          width: double.infinity,
          margin: EdgeInsets.only(right: widget.hideDescrition ? 0 : 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: widget.hideDescrition
                  ? Radius.circular(0)
                  : Radius.circular(16),
            ),
            image: DecorationImage(
              image: AssetImage(widget.image),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
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
