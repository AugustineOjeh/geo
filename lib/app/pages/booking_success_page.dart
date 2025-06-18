import 'package:flutter/material.dart';
import 'package:grace_ogangwu/app/core/navigation_manager.dart';
import 'package:grace_ogangwu/components/components.dart';
import 'package:grace_ogangwu/constants/constants.dart';

class BookingSuccessPage extends StatelessWidget {
  const BookingSuccessPage({super.key});

  @override
  Widget build(BuildContext context) => Container(
    constraints: Device.isMobile(context)
        ? null
        : BoxConstraints(maxWidth: 320),
    child: SizedBox(
      width: double.infinity,
      child: Column(
        spacing: 32,
        children: [
          Text(
            'Classes booked successfully!',
            style: CustomTextStyle.headlineMedium(context),
          ),
          Text(
            'Check the calendar event for each class scheduled class for link to join the class.',
            style: CustomTextStyle.headlineSmall(
              context,
              color: CustomColors.text,
            ),
          ),
          CustomButton.primary(
            context,
            label: 'Book another class',
            onTap: () => NavigationManager.pushReplacement(PageNames.booking),
          ),
        ],
      ),
    ),
  );
}
