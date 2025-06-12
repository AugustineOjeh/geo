import 'package:flutter/material.dart';
import 'package:grace_ogangwu/app/pages/app_home.dart';
import 'package:grace_ogangwu/app/pages/auth_page.dart';

class PageNames {
  static const booking = '/booking';
  static const auth = '/auth';
  static const calendar = '/calendar';
  static const userOnboarding = '/user-onboarding';
  static const studentOnboarding = '/student-onboarding';
  static const questionnaire = '/questionnaire';
  static const contact = '/contact';
  static const chooseStudent = '/choose-student';
  static const payment = '/payment';
  static const bookingCompleted = '/booking-completes';
  static const resetPassword = '/reset-password';
}

class CustomRoutes {
  // Map of routes to page widgets
  static final Map<String, Widget Function(BuildContext, dynamic)> appRoutes = {
    PageNames.auth: (context, args) => AuthPage(
      showSignUpWidget: args['show-signup'] as bool,
      tier: args['tier'] as String,
      tierPrice: args['pricing'] as double,
      bookingCount: args['booking-count'] as int,
    ),
    PageNames.booking: (context, args) => AppHome(),
  };
}

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
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final routeBuilder = CustomRoutes.appRoutes[settings.name];
    if (routeBuilder != null) {
      return MaterialPageRoute(
        builder: (context) => routeBuilder(context, settings.arguments),
        settings: settings,
      );
    }

    return MaterialPageRoute(
      builder: (context) => AppHome(),
      settings: settings,
    );
  }
}
