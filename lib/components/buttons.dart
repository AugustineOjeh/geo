import 'package:flutter/material.dart';
import 'package:grace_ogangwu/constants/styles.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomButton {
  static Widget primary(
    BuildContext context, {
    required String label,
    required VoidCallback onTap,
    bool? isLoading,
  }) => ElevatedButton(
    onPressed: onTap,
    style: ElevatedButton.styleFrom(
      elevation: 0,
      backgroundColor: CustomColors.primary,
      overlayColor: Colors.transparent,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(24),
      ),
    ),
    child: Row(
      spacing: 16,
      children: [
        Expanded(
          child: Text(
            label,
            style: CustomTextStyle.bodyMedium(
              context,
              color: CustomColors.foreground,
            ),
          ),
        ),
        Container(
          width: 40,
          height: 40,
          padding: const EdgeInsets.all(12),
          margin: EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: CustomColors.foreground,
            shape: BoxShape.circle,
          ),
          child: isLoading == true
              ? CircularProgressIndicator(
                  strokeWidth: 2,
                  color: CustomColors.primary,
                )
              : Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: CustomColors.primary,
                ),
        ),
      ],
    ),
  );

  static Widget secondary(
    BuildContext context, {
    required String label,
    required VoidCallback onTap,
  }) => ElevatedButton(
    onPressed: onTap,
    style: ElevatedButton.styleFrom(
      elevation: 0,
      backgroundColor: CustomColors.foreground,
      overlayColor: Colors.transparent,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(24),
      ),
    ),
    child: Row(
      spacing: 12,
      children: [
        Expanded(
          child: Text(
            label,
            style: CustomTextStyle.bodyMedium(
              context,
              color: CustomColors.black,
            ),
          ),
        ),
        Container(
          width: 40,
          height: 40,
          padding: const EdgeInsets.all(12),
          margin: EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: CustomColors.primary,
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: CustomColors.foreground,
          ),
        ),
      ],
    ),
  );

  static Widget arrowIcon(
    BuildContext context, {
    required VoidCallback onTap,
    double size = 32,
    bool isPrimary = false,
    bool isUp = false,
    bool isRight = true,
    bool isLeft = false,
    bool isDown = false,
  }) => IconButton(
    onPressed: onTap,
    style: IconButton.styleFrom(
      shape: CircleBorder(),
      visualDensity: VisualDensity.compact,
      padding: EdgeInsets.all(10),
      alignment: Alignment.center,
      backgroundColor: isPrimary
          ? CustomColors.primary
          : CustomColors.background,
      overlayColor: Colors.transparent,
      hoverColor: Colors.transparent,
      fixedSize: Size(size, size),
    ),
    icon: Center(
      child: Icon(
        isUp
            ? Icons.arrow_drop_up
            : isDown
            ? Icons.arrow_drop_down
            : isLeft
            ? Icons.arrow_back_ios
            : Icons.arrow_forward_ios,
        size: 16,
        color: isPrimary ? CustomColors.foreground : CustomColors.black,
      ),
    ),
  );
  static Widget icon(
    BuildContext context, {
    required VoidCallback onTap,
    required IconData icon,
    Color? color,
    double? size,
    String? tooltip,
    bool isPrimary = false,
  }) => IconButton(
    onPressed: onTap,
    tooltip: tooltip,
    style: IconButton.styleFrom(
      shape: CircleBorder(),
      visualDensity: VisualDensity.compact,
      backgroundColor: isPrimary
          ? CustomColors.primary
          : CustomColors.background,
      overlayColor: Colors.transparent,
      hoverColor: Colors.transparent,
    ),
    icon: Icon(
      icon,
      size: size ?? 24,
      color:
          color ?? (isPrimary ? CustomColors.foreground : CustomColors.black),
    ),
  );

  static Widget footerSocials(
    BuildContext context, {
    required IconData icon,
    required String url,
  }) => IconButton(
    onPressed: () async {
      if (url.isEmpty) return;
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url), webOnlyWindowName: '_blank');
      }
    },
    style: IconButton.styleFrom(
      shape: CircleBorder(
        side: BorderSide(
          width: 1,
          color: CustomColors.foreground.withValues(alpha: 0.5),
        ),
      ),
      visualDensity: VisualDensity.compact,
      padding: EdgeInsets.all(8),
      backgroundColor: Colors.transparent,
      overlayColor: Colors.transparent,
      hoverColor: Colors.transparent,
      fixedSize: Size(28, 28),
    ),
    icon: Icon(
      icon,
      size: 12,
      color: CustomColors.foreground.withValues(alpha: 0.5),
    ),
  );

  static Widget contactSocials(
    BuildContext context, {
    required IconData icon,
    required String url,
  }) => IconButton(
    onPressed: () async {
      if (url.isEmpty) return;
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url), webOnlyWindowName: '_blank');
      }
    },
    style: IconButton.styleFrom(
      shape: CircleBorder(),
      visualDensity: VisualDensity.compact,
      padding: EdgeInsets.all(8),
      backgroundColor: Colors.transparent,
      overlayColor: Colors.transparent,
      hoverColor: Colors.transparent,
      fixedSize: Size(96, 96),
    ),
    icon: Icon(icon, size: 80, color: CustomColors.black),
  );
}
