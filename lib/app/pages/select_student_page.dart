import 'package:flutter/material.dart';
import 'package:grace_ogangwu/app/core/navigation_manager.dart';
import 'package:grace_ogangwu/app/core/student_model.dart';
import 'package:grace_ogangwu/app/helpers/app_helper.dart';
import 'package:grace_ogangwu/components/components.dart';
import 'package:grace_ogangwu/constants/constants.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SelectStudentPage extends StatefulWidget {
  const SelectStudentPage({
    required this.tier,
    required this.bookingCount,
    required this.price,
    super.key,
  });
  final String tier;
  final int bookingCount;
  final double price;

  @override
  State<SelectStudentPage> createState() => _SelectStudentPageState();
}

class _SelectStudentPageState extends State<SelectStudentPage> {
  final List<Student> _students = [];
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _fetchStudents();
  }

  void _fetchStudents() async {
    setState(() => _loading = true);
    try {
      final res = await AppHelper.fetchStudentsByParent(context);
      if (res == null) return;
      setState(() => _students.addAll(res));
    } finally {
      setState(() => _loading = false);
    }
  }

  void _enrolNewStudent() {
    final user = Supabase.instance.client.auth.currentUser;
    NavigationManager.push(
      PageNames.studentOnboarding,
      arguments: {
        'parent-name': user?.userMetadata?['first_name'],
        'tier': widget.tier,
        'pricing': widget.price,
        'booking-count': widget.bookingCount,
      },
    );
  }

  @override
  Widget build(BuildContext context) => Container(
    constraints: Device.isMobile(context)
        ? null
        : BoxConstraints(maxWidth: 320),
    child: SizedBox(
      width: double.infinity,
      child: Column(
        spacing: 32,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader.app(
            context,
            prefixText: 'Book classes',
            headline: 'Who\'s this booking for?',
          ),
          _loading
              ? Center(
                  child: SizedBox(
                    height: 24,
                    width: 24,
                    child: CircularProgressIndicator(
                      color: CustomColors.primary,
                      strokeWidth: 2,
                    ),
                  ),
                )
              : _students.isEmpty
              ? Center(
                  child: Column(
                    spacing: 24,
                    children: [
                      Text('No student.'),
                      CustomButton.primary(
                        context,
                        label: 'Add a student',
                        onTap: _enrolNewStudent,
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  itemCount: _students.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: _studentBox(
                      context,
                      student: _students[index],
                      price: widget.price,
                      bookingCount: widget.bookingCount,
                      tier: widget.tier,
                    ),
                  ),
                ),
          if (_students.isNotEmpty)
            Center(
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: CustomTextStyle.bodyMedium(context),
                  children: [
                    TextSpan(text: 'Have another kid? \n'),
                    redirectSpan(
                      context,
                      text: 'Add new child profile',
                      onTap: _enrolNewStudent,
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    ),
  );
}

Widget _studentBox(
  BuildContext context, {
  required Student student,
  required String tier,
  required double price,
  required int bookingCount,
}) => MouseRegion(
  cursor: SystemMouseCursors.click,
  child: GestureDetector(
    onTap: () => NavigationManager.push(
      PageNames.payment,
      arguments: {
        'student': student,
        'tier': tier,
        'pricing': price,
        'booking-count': bookingCount,
      },
    ),
    child: Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: BoxDecoration(
        color: CustomColors.primary,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        spacing: 24,
        children: [
          Expanded(
            child: Text(
              '${student.name} (${student.age})',
              style: CustomTextStyle.headlineSmall(
                context,
                color: CustomColors.foreground,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          CustomButton.arrowIcon(context, isRight: true, onTap: () {}),
        ],
      ),
    ),
  ),
);
