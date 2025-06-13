import 'package:flutter/material.dart';
import 'package:grace_ogangwu/constants/sizes.dart';
import 'package:grace_ogangwu/constants/styles.dart';

Color _borderColor = CustomColors.black.withValues(alpha: 0.15);
String _fireflies = 'lib/assets/images/logos/fireflies.ai_logo.png';
String _google = 'lib/assets/images/logos/google_logo.png';
String _miro = 'lib/assets/images/logos/miro_logo.png';
String _openai = 'lib/assets/images/logos/openai_logo.png';
String _quizizz = 'lib/assets/images/logos/quizizz_logo.png';
String _stripe = 'lib/assets/images/logos/stripe_logo.png';

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
      fit: BoxFit.fill,
    ),
  );
  static Widget desktopView(BuildContext context) => SizedBox(
    width: double.infinity,
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
