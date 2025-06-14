import 'package:flutter/material.dart';
import 'package:grace_ogangwu/app/helpers/auth.dart';
import 'package:grace_ogangwu/components/components.dart';
import 'package:grace_ogangwu/constants/constants.dart';

class SignIn extends StatefulWidget {
  const SignIn({required this.switchToSignUp, super.key});
  final VoidCallback switchToSignUp;

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _loading = false;
  bool _showPassword = false;

  bool _validateForm() {
    return _formKey.currentState?.validate() ?? false;
  }

  void _submit() async {
    if (!_validateForm()) return;
    setState(() => _loading = true);
    try {
      await AuthHelper.signIn(
        context,
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: Device.isMobile(context)
          ? null
          : BoxConstraints(maxWidth: 320),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          spacing: 32,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionHeader.full(
              context,
              prefixText: 'Get started',
              headline: 'Sign in',
            ),
            Form(
              key: _formKey,
              child: Column(
                spacing: 24,
                children: [
                  CustomFields.text(
                    context,
                    label: 'Email',
                    controller: _emailController,
                    validator: (value) {
                      final regex = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
                      if (value == null ||
                          value.trim().isEmpty ||
                          !regex.hasMatch(value.trim())) {
                        return 'Enter a valid email';
                      }
                      return null;
                    },
                  ),
                  CustomFields.text(
                    context,
                    label: 'Password',
                    controller: _passwordController,
                    obscureText: !_showPassword,
                    validator: (value) {
                      if (value == null ||
                          value.trim().isEmpty ||
                          value.trim().length < 8) {
                        return 'Must be 8 characters or more';
                      }
                      return null;
                    },
                    suffix: GestureDetector(
                      onTap: () =>
                          setState(() => _showPassword = !_showPassword),
                      child: Icon(
                        _showPassword ? Icons.visibility : Icons.visibility_off,
                        size: 20,
                        color: CustomColors.text,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            CustomButton.primary(
              context,
              isLoading: _loading,
              label: 'Sign in',
              onTap: _submit,
            ),
            Center(
              child: RichText(
                text: TextSpan(
                  style: CustomTextStyle.bodyMedium(context),
                  children: [
                    TextSpan(text: 'Don\'t have account? '),
                    redirectSpan(
                      context,
                      text: 'Sign up',
                      onTap: () {
                        _emailController.clear();
                        _passwordController.clear();
                        widget.switchToSignUp();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
