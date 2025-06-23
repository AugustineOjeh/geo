import 'package:flutter/material.dart';
import 'package:grace_ogangwu/components/snackbar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

typedef SupabaseCallback<T> = Future<T> Function();

class RequestHandler {
  static Future<T?> req<T>(
    BuildContext context, {
    required SupabaseCallback<T> request,
  }) async {
    try {
      return await request();
    } on PostgrestException {
      rethrow;
      // if (!context.mounted) return null;
      // CustomSnackbar.main(context, message: e.message);
      // return null;
    } on AuthException catch (e) {
      if (!context.mounted) return null;
      if (e.code == 'user_already_exists') {
        CustomSnackbar.main(
          context,
          durationInSecs: 5,
          message: 'You already have an account. Sign in instead',
        );
      } else if (e.code == 'invalid_credentials') {
        CustomSnackbar.main(
          context,
          durationInSecs: 5,
          message:
              'Wrong email or password. Check your credentials and try again.',
        );
      }
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}
