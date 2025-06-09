import 'package:flutter/material.dart';
import 'package:grace_ogangwu/constants/sizes.dart';
import 'package:grace_ogangwu/constants/styles.dart';

Color _borderColor = CustomColors.black.withValues(alpha: 0.15);
String _fireflies = ''; // TODO: Add Fireflies logo
String _google = ''; // TODO: Add Google logo
String _miro = ''; // TODO: Add Miro logo
String _openai = ''; // TODO: Add openAI logo
String _quizizz = ''; // TODO: Add Quizizz logo
String _stripe = ''; // TODO: Add Stripe logo

class PartnerLogos {
  static Widget logoHolder(
    BuildContext context, {
    required String logo,
    required Border? border,
  }) => Container(
    padding: EdgeInsets.all(32),
    width: double.infinity,
    decoration: BoxDecoration(border: border),
    child: Image.asset(
      logo,
      height: Device.isMobile(context) ? 32 : 48,
      fit: BoxFit.contain,
    ),
  );
  static Widget desktopView(BuildContext context) => SizedBox(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: logoHolder(
                context,
                logo: _fireflies,
                border: Border(
                  right: BorderSide(color: _borderColor),
                  bottom: BorderSide(color: _borderColor),
                ),
              ),
            ),
            Expanded(
              child: logoHolder(
                context,
                logo: _google,
                border: Border(bottom: BorderSide(color: _borderColor)),
              ),
            ),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: logoHolder(
                context,
                logo: _miro,
                border: Border(
                  right: BorderSide(color: _borderColor),
                  bottom: BorderSide(color: _borderColor),
                ),
              ),
            ),
            Expanded(
              child: logoHolder(
                context,
                logo: _openai,
                border: Border(bottom: BorderSide(color: _borderColor)),
              ),
            ),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: logoHolder(
                context,
                logo: _quizizz,
                border: Border(right: BorderSide(color: _borderColor)),
              ),
            ),
            Expanded(child: logoHolder(context, logo: _stripe, border: null)),
          ],
        ),
      ],
    ),
  );
  static Widget mobileView(BuildContext context) => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      logoHolder(
        context,
        logo: _fireflies,
        border: Border(bottom: BorderSide(color: _borderColor)),
      ),
      logoHolder(
        context,
        logo: _google,
        border: Border(bottom: BorderSide(color: _borderColor)),
      ),
      logoHolder(
        context,
        logo: _miro,
        border: Border(bottom: BorderSide(color: _borderColor)),
      ),
      logoHolder(
        context,
        logo: _openai,
        border: Border(bottom: BorderSide(color: _borderColor)),
      ),

      logoHolder(
        context,
        logo: _quizizz,
        border: Border(bottom: BorderSide(color: _borderColor)),
      ),
      logoHolder(
        context,
        logo: _stripe,
        border: Border(bottom: BorderSide(color: _borderColor)),
      ),
    ],
  );
}
