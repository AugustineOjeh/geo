import 'package:flutter/material.dart';
import 'package:grace_ogangwu/app/core/navigation_manager.dart';
import 'package:grace_ogangwu/app/helpers/auth.dart';
import 'package:grace_ogangwu/assets/logo.dart';
import 'package:grace_ogangwu/components/buttons.dart';
import 'package:grace_ogangwu/constants/constants.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AppPage extends StatefulWidget {
  const AppPage({this.bookingCount, this.tier, this.tierPrice, super.key});
  final double? tierPrice;
  final String? tier;
  final int? bookingCount;

  @override
  State<AppPage> createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initPage();
    });
  }

  void _initPage() {
    final userData = Supabase.instance.client.auth.currentUser!.userMetadata;
    if (userData?['first_name'] == null || userData?['last_name'] == null) {
      NavigationManager.pushReplacement(
        PageNames.userOnboarding,
        arguments: {
          'tier': widget.tier,
          'pricing': widget.tierPrice,
          'booking-count': widget.bookingCount,
        },
      );
    } else {
      if (widget.tier == null ||
          widget.tierPrice == null ||
          widget.bookingCount == null) {
        return;
      } else {
        NavigationManager.pushReplacement(
          PageNames.chooseStudent,
          arguments: {
            'tier': widget.tier,
            'pricing': widget.tierPrice,
            'booking-count': widget.bookingCount,
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        automaticallyImplyLeading: false,
        clipBehavior: Clip.none,
        backgroundColor: CustomColors.background,
        centerTitle: true,
        title: Container(
          constraints: BoxConstraints(maxWidth: 1500),
          width: double.infinity,
          alignment: Alignment.centerLeft,
          child: Row(
            spacing: 32,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              logo(context, isBlack: true),
              CustomButton.icon(
                context,
                tooltip: 'Log out',
                onTap: () async => AuthHelper.signOut(context),
                icon: Icons.logout,
              ),
            ],
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: CustomPadding.pageHorizontal(context),
          ),
          child: Container(
            constraints: BoxConstraints(maxWidth: 1400),
            child: Column(
              children: [
                Container(
                  constraints: BoxConstraints(
                    minHeight: Device.screenHeight(context) - 260,
                  ),
                  child: Center(
                    child: Navigator(
                      key: NavigationManager.navigatorKey,
                      onGenerateRoute: NavigationManager.generateRoute,
                    ),
                  ),
                ),
                SizedBox(height: 96),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        width: 1,
                        color: CustomColors.black.withValues(alpha: 0.2),
                      ),
                    ),
                  ),
                  child: Device.isMobile(context)
                      ? _mobileFooter(context)
                      : _desktopFooter(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _mobileFooter(BuildContext context) => Column(
  spacing: 16,
  children: [
    Row(
      spacing: 16,
      children: [
        Expanded(
          child: RichText(
            text: TextSpan(
              style: CustomTextStyle.bodyMedium(context),
              children: [
                redirectSpan(context, text: 'Contact me', onTap: () {}),
              ],
            ),
          ),
        ),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: CustomTextStyle.bodyMedium(context),
              children: [
                redirectSpan(context, text: 'Terms & privacy', onTap: () {}),
              ],
            ),
          ),
        ),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: CustomTextStyle.bodyMedium(context),
              children: [
                redirectSpan(context, text: 'Refund policy', onTap: () {}),
              ],
            ),
          ),
        ),
      ],
    ),
    Text(
      'Copyright © OCCL, ${DateTime.now().year}',
      style: CustomTextStyle.bodyMedium(context),
    ),
  ],
);
Widget _desktopFooter(BuildContext context) => Row(
  spacing: 32,
  children: [
    Text(
      'Copyright © OCCL, ${DateTime.now().year}',
      style: CustomTextStyle.bodyMedium(context),
    ),
    Spacer(),
    RichText(
      text: TextSpan(
        style: CustomTextStyle.bodyMedium(context),
        children: [redirectSpan(context, text: 'Contact me', onTap: () {})],
      ),
    ),
    RichText(
      text: TextSpan(
        style: CustomTextStyle.bodyMedium(context),
        children: [
          redirectSpan(context, text: 'Terms & privacy', onTap: () {}),
        ],
      ),
    ),
    RichText(
      text: TextSpan(
        style: CustomTextStyle.bodyMedium(context),
        children: [redirectSpan(context, text: 'Refund policy', onTap: () {})],
      ),
    ),
  ],
);
