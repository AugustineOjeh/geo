import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

class AuthHelper {
  static Future<void> signUp(
    BuildContext context, {
    required String email,
    required String password,
  }) async {
    final res = await supabase.auth.signUp(email: email, password: password);
  }
}
