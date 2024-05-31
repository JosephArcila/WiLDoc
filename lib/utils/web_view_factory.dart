// lib/utils/web_view_factory.dart
import 'dart:html' as html;
import 'dart:ui_web' as ui_web;

void registerWebViewFactory() {
  ui_web.platformViewRegistry.registerViewFactory(
    'plugins.flutter.io/camera_1',
    (int viewId) {
      final html.Element htmlElement = html.DivElement()
        ..style.width = '100%'
        ..style.height = '100%';
      return htmlElement;
    },
  );
}
