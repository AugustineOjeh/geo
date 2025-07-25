import 'package:flutter/material.dart';
import 'package:grace_ogangwu/app/core/app_page.dart';
import 'package:grace_ogangwu/utils/request_handler.dart';
import 'package:grace_ogangwu/website/pages/homepage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

class AuthHelper {
  static Future<void> signUp(
    BuildContext context, {
    required String email,
    required String password,
    String? tier,
    double? price,
    int? bookingCount,
  }) async {
    final req = supabase.auth.signUp(email: email, password: password);
    final res = await RequestHandler.req(context, request: () => req);
    if (res == null || !context.mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) =>
            AppPage(tier: tier, tierPrice: price, bookingCount: bookingCount),
      ),
    );
  }

  static Future<void> signIn(
    BuildContext context, {
    required String email,
    required String password,
    String? tier,
    double? price,
    int? bookingCount,
  }) async {
    final req = supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
    final res = await RequestHandler.req(context, request: () => req);
    if (res == null || !context.mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) =>
            AppPage(tier: tier, tierPrice: price, bookingCount: bookingCount),
      ),
    );
  }

  static Future<void> signOut(BuildContext context) async {
    final req = supabase.auth.signOut();
    await RequestHandler.req(context, request: () => req);
    if (!context.mounted) return;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => Homepage()),
      (route) => false,
    );
  }
}
