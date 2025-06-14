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
      final result = await request();
      print(result);
      return result;
    } on PostgrestException catch (e) {
      print(e);
      if (!context.mounted) return null;
      CustomSnackbar.main(context, message: e.message);
      return null;
    } on AuthException catch (e) {
      print(e);
      if (!context.mounted) return null;
      CustomSnackbar.main(context, message: e.message);
      return null;
    } catch (e) {
      print(e);
      if (!context.mounted) return null;
      CustomSnackbar.main(context, message: e.toString());
      return null;
    }
  }
}
