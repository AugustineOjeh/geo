import 'package:flutter/material.dart';
import 'package:grace_ogangwu/utils/request_handler.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class WebsiteHelper {
  static Future<bool> joinWaitlist(
    BuildContext context, {
    required String email,
  }) async {
    final req = Supabase.instance.client
        .schema('occl')
        .from('subscribers')
        .insert({'email': email})
        .select()
        .single();
    final res = await RequestHandler.req(context, request: () => req);
    return res == null ? false : true;
  }
}
