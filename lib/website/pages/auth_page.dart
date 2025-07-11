import 'package:flutter/material.dart';
import 'package:grace_ogangwu/website/widgets/sign_in.dart';
import 'package:grace_ogangwu/website/widgets/sign_up.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({
    this.showSignUpWidget = true,
    this.bookingCount,
    this.tier,
    this.tierPrice,
    super.key,
  });
  final bool showSignUpWidget;
  final double? tierPrice;
  final String? tier;
  final int? bookingCount;

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool _showSignUpWidget = true;

  @override
  void initState() {
    super.initState();
    _showSignUpWidget = widget.showSignUpWidget;
  }

  void _toggleWidget() =>
      setState(() => _showSignUpWidget = !_showSignUpWidget);

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Center(
      child: SingleChildScrollView(
        child: _showSignUpWidget
            ? SignUp(
                switchToSignIn: _toggleWidget,
                tier: widget.tier,
                price: widget.tierPrice,
                bookingCount: widget.bookingCount,
              )
            : SignIn(
                switchToSignUp: _toggleWidget,
                tier: widget.tier,
                price: widget.tierPrice,
                bookingCount: widget.bookingCount,
              ),
      ),
    ),
  );
}
