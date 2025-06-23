import 'dart:async';
import 'dart:js_interop';
import 'dart:js_interop_unsafe';

import 'package:flutter/material.dart';
import 'dart:ui_web' as ui;
import 'package:web/web.dart' as web;

class CalendlyIframe extends StatefulWidget {
  final String iframeUrl;
  final double width;
  final double height;
  final VoidCallback onEventScheduled;

  const CalendlyIframe({
    required this.iframeUrl,
    required this.onEventScheduled,
    this.width = 600,
    this.height = 800,
    super.key,
  });

  @override
  State<CalendlyIframe> createState() => _CalendlyIframeState();
}

class _CalendlyIframeState extends State<CalendlyIframe> {
  late final String _viewType;
  late final web.HTMLIFrameElement _iframe;
  StreamSubscription<web.MessageEvent>? _messageSubscription;

  @override
  void initState() {
    super.initState();

    _viewType = 'calendly-iframe-${DateTime.now().microsecondsSinceEpoch}';

    // Register iframe as platform view
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(_viewType, (int viewId) {
      _iframe = web.HTMLIFrameElement()
        ..src = widget.iframeUrl
        ..style.border = 'none'
        ..width = '${widget.width}'
        ..height = '${widget.height}'
        ..allowFullscreen = true;

      return _iframe;
    });
    _listenForCalendlyBooking();
  }

  void _listenForCalendlyBooking() {
    _messageSubscription = web.window.onMessage.listen((
      web.MessageEvent event,
    ) async {
      try {
        final origin = event.origin;
        final jsData = event.data;
        if (origin == 'https://calendly.com' && jsData != null) {
          final jsObject = jsData as JSObject;
          final eventJS = jsObject.getProperty('event'.toJS);

          if (eventJS != null &&
              (eventJS as JSString).toDart == 'calendly.event_scheduled') {
            print('📆 Calendly booking detected');
            widget.onEventScheduled();

            _iframe.src = widget.iframeUrl; // reload iframe for next slot
          }
        }
      } catch (e) {
        print('⚠️ Error processing Calendly message: $e');
      }
    });
  }

  @override
  void dispose() {
    _messageSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => HtmlElementView(viewType: _viewType);
}
