import 'package:flutter/material.dart';
import 'package:grace_ogangwu/app/core/page_names.dart';
import 'package:grace_ogangwu/assets/logo.dart';
import 'package:grace_ogangwu/constants/constants.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AppScaffold extends StatefulWidget {
  const AppScaffold({required this.child, super.key});
  final Widget child;

  @override
  State<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  String? _initialRoute;

  @override
  void initState() {
    super.initState();
    final session = Supabase.instance.client.auth.currentSession;
    if (session == null) {
      _initialRoute = PageNames.auth;
    } else {
      _initialRoute = PageNames.booking;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        automaticallyImplyLeading: false,
        title: Container(
          padding: EdgeInsets.symmetric(
            horizontal: CustomPadding.pageHorizontal(context),
            vertical: 32,
          ),
          width: double.infinity,
          child: Row(children: [logo(context, isBlack: true)]),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: CustomPadding.pageHorizontal(context),
        ),
        child: Container(
          constraints: BoxConstraints(maxWidth: 1500),
          child: Column(
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: Device.screenHeight(context) - 180,
                ),
                child: Center(
                  child: Navigator(
                    key: NavigationManager.navigatorKey,
                    initialRoute: _initialRoute,
                    onGenerateRoute: NavigationManager.generateRoute,
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 24),
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
