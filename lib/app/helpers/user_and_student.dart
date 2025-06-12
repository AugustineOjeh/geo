import 'package:flutter/material.dart';
import 'package:grace_ogangwu/app/core/navigation_manager.dart';
import 'package:grace_ogangwu/utils/request_handler.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

class UserAndStudentHelper {
  static Future<void> updateUserData(
    BuildContext context, {
    required String firstName,
    required String lastName,
  }) async {
    final req = supabase.auth.updateUser(
      UserAttributes(data: {'first_name': firstName, 'last_name': lastName}),
    );
    final res = await RequestHandler.req(context, request: () => req);
    if (res == null) return;
    NavigationManager.push('student-onboarding');
  }
}
