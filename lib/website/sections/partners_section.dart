import 'package:flutter/material.dart';
import 'package:grace_ogangwu/components/section_header.dart';
import 'package:grace_ogangwu/constants/sizes.dart';
import 'package:grace_ogangwu/constants/styles.dart';
import 'package:grace_ogangwu/website/widgets/partner_logos.dart';

const _headline = 'The technologies behind your child’s learning journey';
const _description =
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse a purus id justo egestas fermentum dictum ut arcu.';

class PartnersSection extends StatelessWidget {
  const PartnersSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: 1500),
      padding: EdgeInsets.symmetric(
        horizontal: CustomPadding.pageHorizontal(context),
        vertical: CustomPadding.sectionVertical(context),
      ),
      child: Device.isMobile(context)
          ? _mobileView(context)
          : Device.isTablet(context)
          ? _tabletView(context)
          : _desktopView(context),
    );
  }
}

Widget _mobileView(BuildContext context) => Column(
  spacing: 24,
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    SectionHeader.full(context, prefixText: 'Partners', headline: _headline),
    Text(
      _description,
      style: CustomTextStyle.headlineSmall(context, color: CustomColors.text),
    ),
    PartnerLogos.mobileView(context),
  ],
);

Widget _tabletView(BuildContext context) => Column(
  spacing: 48,
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Row(
      spacing: 48,
      children: [
        Expanded(
          child: SizedBox(
            child: SectionHeader.full(
              context,
              prefixText: 'Partners',
              headline: _headline,
            ),
          ),
        ),
        Expanded(
          child: SizedBox(
            child: Text(
              _description,
              style: CustomTextStyle.headlineSmall(
                context,
                color: CustomColors.text,
              ),
            ),
          ),
        ),
      ],
    ),
    PartnerLogos.desktopView(context),
  ],
);

Widget _desktopView(BuildContext context) => Row(
  spacing: Spacing.large(context),
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Expanded(
      child: Column(
        spacing: 48,
        children: [
          SectionHeader.full(
            context,
            prefixText: 'Partners',
            headline: _headline,
          ),
          Text(
            _description,
            style: CustomTextStyle.headlineSmall(
              context,
              color: CustomColors.text,
            ),
          ),
        ],
      ),
    ),
    Expanded(child: PartnerLogos.desktopView(context)),
  ],
);
