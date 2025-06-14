import 'package:flutter/material.dart';
import 'package:grace_ogangwu/app/core/navigation_manager.dart';
import 'package:grace_ogangwu/app/core/student_model.dart';
import 'package:grace_ogangwu/utils/request_handler.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

class AppHelper {
  static Future<void> updateUserData(
    BuildContext context, {
    required String firstName,
    required String lastName,
    String? tier,
    double? price,
    int? bookingCount,
  }) async {
    final req = supabase.auth.updateUser(
      UserAttributes(data: {'first_name': firstName, 'last_name': lastName}),
    );
    final res = await RequestHandler.req(context, request: () => req);
    if (res == null) return;
    NavigationManager.push(
      PageNames.studentOnboarding,
      arguments: {
        'parent-name': firstName,
        'tier': tier,
        'pricing': price,
        'booking-count': bookingCount,
      },
    );
  }

  static Future<void> addStudent(
    BuildContext context, {
    required String name,
    required int age,
    String? tier,
    double? price,
    int? bookingCount,
  }) async {
    final user = supabase.auth.currentUser;
    if (user == null) return;
    final data = {'name': name, 'age': age, 'parent_id': user.id};
    final req = supabase
        .schema('occl')
        .from('students')
        .insert(data)
        .select()
        .single();
    final res = await RequestHandler.req(context, request: () => req);
    if (res == null) return;
    NavigationManager.push(
      PageNames.payment,
      arguments: {
        'student': Student.fromMap(res),
        'tier': tier,
        'pricing': price,
        'booking-count': bookingCount,
      },
    );
  }

  static Future<Map<String, dynamic>?> createBooking(
    BuildContext context, {
    required String tier,
    required String studentId,
    required int maxSlots,
  }) async {
    final data = {'tier': tier, 'student_id': studentId, 'max_slots': maxSlots};
    final req = supabase
        .schema('occl')
        .from('bookings')
        .insert(data)
        .select('*, students(*)')
        .single();
    final res = await RequestHandler.req(context, request: () => req);
    return res;
  }

  static Future<bool> checkStudentQuestionnaire(
    BuildContext context, {
    required String studentId,
  }) async {
    final req = supabase
        .schema('occl')
        .from('questionnaires')
        .select('id')
        .eq('student_id', studentId);
    final res = await RequestHandler.req(context, request: () => req);
    return res == null || res.isEmpty ? false : true;
  }

  static Future<bool> submitQuestionnaire(
    BuildContext context, {
    required Map<String, dynamic> data,
  }) async {
    final req = supabase
        .schema('occl')
        .from('questionnaires')
        .insert(data)
        .select()
        .single();
    final res = await RequestHandler.req(context, request: () => req);
    return res == null ? false : true;
  }
}
