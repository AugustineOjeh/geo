import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grace_ogangwu/components/buttons.dart';
import 'package:grace_ogangwu/constants/styles.dart';

class CustomFields {
  static text(
    BuildContext context, {
    required TextEditingController controller,
    String? label,
    bool autofocus = false,
    bool autocorrect = false,
    bool expands = false,
    bool enabled = true,
    TextInputAction? actionKey,
    TextInputType? keyboardType,
    Widget? suffix,
    int maxLines = 1,
    String? hintText,
    int? maxLength,
    List<TextInputFormatter>? inputFormatters,
    bool obscureText = false,
    TextCapitalization textCapitalization = TextCapitalization.none,
    void Function(String)? onChanged,
    String? Function(String?)? validator,
    void Function(String)? onSubmit,
  }) => Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    spacing: 16,
    children: [
      if (label != null)
        Text(
          label,
          style: CustomTextStyle.bodyMedium(context, color: CustomColors.black),
        ),
      TextFormField(
        controller: controller,
        textInputAction: actionKey,
        keyboardType: keyboardType,
        onChanged: onChanged,
        onFieldSubmitted: onSubmit,
        autocorrect: autocorrect,
        autofocus: autofocus,
        expands: expands,
        validator: validator,
        buildCounter:
            (
              context, {
              required currentLength,
              required isFocused,
              required maxLength,
            }) => null,
        onTapOutside: (event) => FocusScope.of(context).unfocus(),
        textCapitalization: textCapitalization,
        inputFormatters: inputFormatters,
        obscureText: obscureText,
        obscuringCharacter: '*',
        maxLength: maxLength,
        maxLines: maxLines,
        enabled: enabled,
        style: CustomTextStyle.bodyLarge(context, color: CustomColors.black),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 16),
          isCollapsed: true,
          isDense: true,
          suffix: suffix,
          hint: hintText != null
              ? Text(
                  hintText,
                  style: CustomTextStyle.bodyLarge(
                    context,
                    color: CustomColors.black.withValues(alpha: 0.2),
                  ),
                )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: CustomColors.black.withValues(alpha: 0.2),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: CustomColors.black.withValues(alpha: 0.2),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: CustomColors.black.withValues(alpha: 0.5),
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: Colors.red.withValues(alpha: 0.6)),
          ),
        ),
      ),
    ],
  );

  static newsletterInput(
    BuildContext context, {
    required TextEditingController controller,
    void Function(String)? onSubmit,
    required VoidCallback submit,
    bool? loading,
  }) => TextFormField(
    controller: controller,
    textInputAction: TextInputAction.go,
    keyboardType: TextInputType.emailAddress,
    onFieldSubmitted: onSubmit,
    validator: (value) {
      final regex = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
      if (value == null ||
          value.trim().isEmpty ||
          !regex.hasMatch(value.trim())) {
        return 'Enter a valid email';
      }
      return null;
    },
    onTapOutside: (event) => FocusScope.of(context).unfocus(),
    style: CustomTextStyle.bodyLarge(context, color: CustomColors.foreground),
    decoration: InputDecoration(
      hint: Text(
        'Email address',
        style: CustomTextStyle.bodyMedium(
          context,
          color: CustomColors.foreground.withValues(alpha: 0.3),
        ),
      ),
      contentPadding: EdgeInsets.fromLTRB(16, 4, 4, 4),
      isCollapsed: true,
      isDense: true,
      suffix: loading == true
          ? Container(
              height: 32,
              width: 32,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: CustomColors.primary,
                shape: BoxShape.circle,
              ),
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: CustomColors.foreground,
              ),
            )
          : CustomButton.arrowIcon(
              context,
              isRight: true,
              isPrimary: true,
              onTap: submit,
            ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(24),
        borderSide: BorderSide(
          color: CustomColors.foreground.withValues(alpha: 0.5),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(24),
        borderSide: BorderSide(
          color: CustomColors.foreground.withValues(alpha: 0.5),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(24),
        borderSide: BorderSide(
          color: CustomColors.foreground.withValues(alpha: 0.8),
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(24),
        borderSide: BorderSide(color: Colors.red.withValues(alpha: 0.6)),
      ),
    ),
  );
}
