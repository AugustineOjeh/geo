import 'package:flutter/material.dart';
import 'package:grace_ogangwu/app/core/student_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:ui_web' as ui;
import 'package:web/web.dart' as web;

class TypeformIframe extends StatefulWidget {
  final Student student;
  final double width;
  final double height;

  const TypeformIframe({
    required this.student,
    this.width = 600,
    this.height = 800,
    super.key,
  });

  @override
  State<TypeformIframe> createState() => _TypeformIframeState();
}

class _TypeformIframeState extends State<TypeformIframe> {
  late final String _viewType;
  late final web.HTMLIFrameElement _iframe;
  late String url;

  @override
  void initState() {
    super.initState();
    initData();
    ui.platformViewRegistry.registerViewFactory(_viewType, (int viewId) {
      _iframe = web.HTMLIFrameElement()
        ..src = url
        ..style.width = '100%'
        ..style.height = '100%'
        ..style.border = 'none'
        ..setAttribute('frameborder', '0')
        ..setAttribute('scrolling', 'no');
      return _iframe;
    });
  }

  void initData() {
    final user = Supabase.instance.client.auth.currentUser;
    setState(() {
      url =
          'https://form.typeform.com/to/cvjuUuUJ#email=${user!.email}&student_id=${widget.student.id}&student_name=${widget.student.name}';
      _viewType = 'typeform-iframe-$url';
    });
  }

  @override
  Widget build(BuildContext context) => ConstrainedBox(
    constraints: BoxConstraints(
      maxHeight: widget.height,
      maxWidth: widget.width,
    ),
    child: HtmlElementView(viewType: _viewType),
  );
}
