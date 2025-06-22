import 'package:flutter/material.dart';
import 'package:grace_ogangwu/app/core/navigation_manager.dart';
import 'package:grace_ogangwu/app/core/student_model.dart';
import 'package:grace_ogangwu/components/components.dart';
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

  static Future<List<Student>?> fetchStudentsByParent(
    BuildContext context,
  ) async {
    final user = supabase.auth.currentUser;
    if (user == null) return null;
    final req = supabase
        .schema('occl')
        .from('students')
        .select()
        .eq('parent_id', user.id);
    final res = await RequestHandler.req(context, request: () => req);
    return res?.map(Student.fromMap).toList();
  }

  static Future<Map<String, dynamic>?> createBooking(
    BuildContext context, {
    required String tier,
    required String studentId,
    required int slotsRequired,
    required num amount,
  }) async {
    final data = {
      'tier': tier,
      'student_id': studentId,
      'slots_required': slotsRequired,
      'amount': amount,
    };
    final req = supabase
        .schema('occl')
        .from('bookings')
        .insert(data)
        .select('*, students(*)')
        .single();
    final res = await RequestHandler.req(context, request: () => req);
    return res;
  }

  static Future<Map<String, dynamic>?> updateBooking(
    BuildContext context, {
    required Map<String, dynamic> data,
    required String bookingId,
  }) async {
    final req = supabase
        .schema('occl')
        .from('bookings')
        .update(data)
        .eq('id', bookingId)
        .select('id')
        .single();
    final res = await RequestHandler.req(context, request: () => req);
    return res;
  }

  static Future<String?> createCheckoutSession(
    BuildContext context, {
    required String tier,

    /// Price per class in cents (i.e. x100)
    required double tierPrice,

    /// Number of classes being booked
    required int sessionCount,

    /// For [client_reference_id] param in Stripe
    required String userId,

    /// usd formatted to lower case
    required String currency,
    required String studentId,
    required String bookingId,
    required String parentEmail,
  }) async {
    final token = supabase.auth.currentSession?.accessToken;
    if (token == null) {
      CustomSnackbar.main(
        context,
        message: 'You\'re logged out. Sign in and try again',
      );
    }
    final formattedCurrency = currency.toLowerCase();
    final res = await supabase.functions.invoke(
      'create-stripe-checkout-session',
      body: {
        'name': 'Functions',
        'tier': tier,
        'tierPrice': tierPrice,
        'sessionCount': sessionCount,
        'studentId': studentId,
        'userId': userId,
        'parentEmail': parentEmail,
        'currency': formattedCurrency,
      },
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (200 <= res.status && res.status < 300) {
      final clientSecret = res.data['url'];
      return clientSecret.toString();
    } else {
      throw Exception(
        'Failed to create checkout session: ${(res as FunctionException)}',
      );
    }
  }

  static Future<bool?> confirmCheckoutPayment(
    BuildContext context, {
    required String checkoutSessionId,
  }) async {
    final token = supabase.auth.currentSession?.accessToken;
    if (token == null) {
      CustomSnackbar.main(
        context,
        message: 'You\'re logged out. Sign in and try again',
      );
    }
    final res = await supabase.functions.invoke(
      'confirm-stripe-checkout-session',
      method: HttpMethod.get,
      queryParameters: {'sessionId': checkoutSessionId},
      headers: {'Authorization': 'Bearer $token'},
    );
    if (200 <= res.status && res.status < 300) {
      return res.data['paid'] as bool;
    } else {
      throw Exception(
        'Failed to confirm session: ${(res as FunctionException)}',
      );
    }
  }

  static Future<bool> studentHasAnsweredQuestionnaire(
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
