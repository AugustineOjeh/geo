import 'package:flutter/material.dart';
import 'package:grace_ogangwu/constants/sizes.dart';
import 'package:grace_ogangwu/constants/styles.dart';
import 'package:grace_ogangwu/website/pages/homepage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://tqwdtebugocgxubozcom.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InRxd2R0ZWJ1Z29jZ3h1Ym96Y29tIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mzk3Mjk5OTIsImV4cCI6MjA1NTMwNTk5Mn0.fEymorCFd30UJP9dJctR-jasK3ehaAchlOXhu7hU_38',
  );
  runApp(const GraceOgangwu());
}

class GraceOgangwu extends StatelessWidget {
  const GraceOgangwu({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: CustomFontFamily.sans,
        fontFamilyFallback: [CustomFontFamily.sansDisplay],
        scaffoldBackgroundColor: CustomColors.background,
      ),
      home: const Homepage(),
    );
  }
}
