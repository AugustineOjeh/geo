import 'package:flutter/material.dart';
import 'package:grace_ogangwu/app/core/page_names.dart';
import 'package:grace_ogangwu/utils/request_handler.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

class AuthHelper {
  static Future<void> signUp(
    BuildContext context, {
    required String email,
    required String password,
  }) async {
    final req = supabase.auth.signUp(email: email, password: password);
    final res = await RequestHandler.req(context, request: () => req);
    if (res == null) return;
    NavigationManager.push('user-onboarding');
  }

  static Future<void> signIn(
    BuildContext context, {
    required String email,
    required String password,
  }) async {
    final req = supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
    final res = await RequestHandler.req(context, request: () => req);
    if (res == null) return;
    NavigationManager.push('user-onboarding');
  }
}
