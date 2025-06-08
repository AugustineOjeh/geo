import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grace_ogangwu/constants/styles.dart';

class CustomFields {
  static text(
    BuildContext context, {
    required TextEditingController controller,
    bool autofocus = false,
    bool autocorrect = false,
    bool expands = false,
    TextInputAction? actionKey,
    TextInputType? keyboardType,
    int maxLines = 1,
    int? maxLength,
    List<TextInputFormatter>? inputFormatters,
    bool obscureText = false,
    TextCapitalization textCapitalization = TextCapitalization.none,
    void Function(String)? onChanged,
    void Function(String)? onSubmit,
  }) => TextFormField(
    controller: controller,
    textInputAction: actionKey,
    keyboardType: keyboardType,
    onChanged: onChanged,
    onFieldSubmitted: onSubmit,
    autocorrect: autocorrect,
    autofocus: autofocus,
    expands: expands,
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
    style: CustomTextStyle.bodyLarge(context, color: CustomColors.black),
    decoration: InputDecoration(
      contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 16),
      isCollapsed: true,
      isDense: true,
    ),
  );
}
