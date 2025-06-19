import 'package:flutter/material.dart';
import 'package:grace_ogangwu/app/core/navigation_manager.dart';
import 'package:grace_ogangwu/assets/logo.dart';
import 'package:grace_ogangwu/constants/constants.dart';

class AppPage extends StatefulWidget {
  const AppPage({
    required this.initialPage,
    this.bookingCount,
    this.tier,
    this.tierPrice,
    super.key,
  });
  final double? tierPrice;
  final String? tier;
  final int? bookingCount;

  /// Must be a [PageNames] value.
  final String initialPage;

  @override
  State<AppPage> createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  String? _initialRoute;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initialRoute = widget.initialPage;
    });
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
          child: logo(context, isBlack: true),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: CustomPadding.pageHorizontal(context),
          ),
          child: Container(
            constraints: BoxConstraints(maxWidth: 1500),
            child: Column(
              children: [
                Navigator(
                  key: NavigationManager.navigatorKey,
                  initialRoute: _initialRoute ?? PageNames.booking,
                  onGenerateRoute: NavigationManager.generateRoute,
                ),
                SizedBox(height: 96),
                Container(
                  constraints: BoxConstraints(maxWidth: 1500),
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
