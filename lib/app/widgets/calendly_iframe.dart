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
  // late final String _viewType;
  late final web.HTMLIFrameElement _iframe;
  StreamSubscription<web.MessageEvent>? _messageSubscription;
  String _iframeKey = '0';

  @override
  void initState() {
    super.initState();
    _iframeKey = DateTime.now().millisecondsSinceEpoch.toString();
    _createIframe();
    _setupCalendlyListener();
  }

  void _createIframe() {
    final type = 'calendly-iframe-${widget.iframeUrl.hashCode}-$_iframeKey';
    ui.platformViewRegistry.registerViewFactory(type, (int viewId) {
      _iframe = web.HTMLIFrameElement()
        ..src = widget.iframeUrl
        ..style.width = '100%'
        ..style.height = '100%'
        ..style.border = 'none'
        ..setAttribute('frameborder', '0')
        ..setAttribute('scrolling', 'no');
      return _iframe;
    });
  }

  void _setupCalendlyListener() {
    _messageSubscription?.cancel();
    _messageSubscription = web.window.onMessage.listen((
      web.MessageEvent event,
    ) {
      try {
        // Check if the message is from Calendly
        if (_isCalendlyEvent(event)) {
          _handleCalendlyEvent(event);
        }
      } catch (e) {
        throw ('CalendlyMessageError: $e');
      }
    });
  }

  void _handleCalendlyEvent(web.MessageEvent event) {
    try {
      final data = event.data as JSObject;
      final eventType = data.getProperty('event'.toJS);
      final payload = data.getProperty('payload'.toJS);

      print('Calendly Event: $eventType');

      if (eventType != null) {
        final type = (eventType as JSString).toDart;
        if (type == 'calendly.event_scheduled') {
          _onEventScheduled(payload);
          return;
        }
      }
    } catch (e) {
      throw ('CalendlyEventError: $e');
    }
  }

  void _onEventScheduled(dynamic payload) {
    print('Event scheduled! Payload: $payload');
    widget.onEventScheduled();
    _reRenderIframe();
  }

  bool _isCalendlyEvent(web.MessageEvent event) {
    try {
      // Check if the event origin is from Calendly
      final origin = event.origin;
      if (!origin.contains('calendly.com')) {
        return false;
      }

      // Check if the data has the expected Calendly structure
      final data = event.data as JSObject?;
      if (data == null) return false;

      final eventType = data.getProperty('event'.toJS);
      return eventType != null;
    } catch (e) {
      return false;
    }
  }

  void _reRenderIframe() {
    if (!mounted) return;
    setState(
      () => _iframeKey = DateTime.now().millisecondsSinceEpoch.toString(),
    );
    // Recreate iframe element for fresh state
    _createIframe();
    print('Iframe re-rendered for next booking.');
  }

  @override
  void dispose() {
    _messageSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => ConstrainedBox(
    constraints: BoxConstraints(
      maxHeight: widget.height,
      maxWidth: widget.width,
    ),
    child: HtmlElementView(
      key: ValueKey(
        'calendly-iframe-$_iframeKey',
      ), // Force re-render with new key
      viewType: 'calendly-iframe-${widget.iframeUrl.hashCode}-$_iframeKey',
      onPlatformViewCreated: (int viewId) {
        // Register the iframe element with unique ID
        final elementId =
            'calendly-iframe-${widget.iframeUrl.hashCode}-$_iframeKey';
        web.document.getElementById(elementId)?.appendChild(_iframe);
      },
    ),
  );
}
