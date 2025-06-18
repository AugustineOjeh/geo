import 'package:flutter/material.dart';
import 'package:grace_ogangwu/app/core/student_model.dart';
import 'package:grace_ogangwu/app/pages/booking_packages_page.dart';
import 'package:grace_ogangwu/app/pages/booking_success_page.dart';
import 'package:grace_ogangwu/app/pages/calendar_page.dart';
import 'package:grace_ogangwu/app/pages/payment_page.dart';
import 'package:grace_ogangwu/app/pages/questionniare_page.dart';
import 'package:grace_ogangwu/app/pages/select_student_page.dart';
import 'package:grace_ogangwu/app/pages/student_onboarding_page.dart';
import 'package:grace_ogangwu/app/pages/user_onboarding_page.dart';

class NavigationManager {
  // Global key for the nested navigator
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  // Push a new route
  static Future<void> push(
    String routeName, {
    Map<String, dynamic>? arguments,
  }) async {
    if (navigatorKey.currentState != null) {
      navigatorKey.currentState!.pushNamed(routeName, arguments: arguments);
    }
  }

  // Replace the current route
  static Future<void> pushReplacement(
    String routeName, {
    Map<String, dynamic>? arguments,
  }) async {
    if (navigatorKey.currentState != null) {
      navigatorKey.currentState!.pushReplacementNamed(
        routeName,
        arguments: arguments,
      );
    }
  }

  // Pop the current route
  static void pop() {
    if (navigatorKey.currentState != null &&
        navigatorKey.currentState!.canPop()) {
      navigatorKey.currentState!.pop();
    }
  }

  // Generate routes for the navigator
  static Route<dynamic> generateRoute(RouteSettings settings) =>
      MaterialPageRoute(
        builder: (context) =>
            CustomRoutes.appRoutes[settings.name]!(context, settings.arguments),
        settings: settings,
      );
}

class PageNames {
  static const booking = '/booking';
  static const calendar = '/calendar';
  static const userOnboarding = '/user-onboarding';
  static const studentOnboarding = '/student-onboarding';
  static const questionnaire = '/questionnaire';
  static const contact = '/contact';
  static const chooseStudent = '/choose-student';
  static const payment = '/payment';
  static const bookingCompleted = '/booking-completed';
  static const resetPassword = '/reset-password';
}

class CustomRoutes {
  // Map of routes to page widgets
  static final Map<String, Widget Function(BuildContext, dynamic)> appRoutes = {
    PageNames.booking: (context, args) => BookingPackagesPage(),

    PageNames.userOnboarding: (context, args) => UserOnboardingPage(
      tier: args['tier'] as String?,
      tierPrice: args['pricing'] as double?,
      bookingCount: args['booking-count'] as int?,
    ),

    PageNames.payment: (context, args) => PaymentPage(
      student: args['student'] as Student?,
      tier: args['tier'] as String?,
      price: args['pricing'] as double?,
      bookingCount: args['booking-count'] as int?,
    ),

    PageNames.studentOnboarding: (context, args) => StudentOnboardingPage(
      userFirstName: args['parent-name'] as String? ?? '',
      tier: args['tier'] as String?,
      tierPrice: args['pricing'] as double?,
      bookingCount: args['booking-count'] as int?,
    ),

    PageNames.calendar: (context, args) => CalendarPage(
      student: args['student'] as Student,
      bookingId: args['booking-id'] as String,
      tier: args['tier'],
      bookingCount: args['booking-count'] as int,
    ),
    PageNames.bookingCompleted: (context, args) => BookingSuccessPage(),

    PageNames.questionnaire: (context, args) =>
        QuestionniarePage(student: args['student'] as Student),

    PageNames.chooseStudent: (context, args) => SelectStudentPage(
      price: args['pricing'] as double,
      tier: args['tier'] as String,
      bookingCount: args['booking-count'] as int,
    ),
  };
}
