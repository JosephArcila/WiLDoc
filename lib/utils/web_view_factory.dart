import 'package:flutter/foundation.dart';
import 'package:universal_html/html.dart' as html;
import 'dart:ui_web' as ui_web;

html.VideoElement? videoElement;

void registerWebViewFactory() {
  ui_web.platformViewRegistry.registerViewFactory(
    'plugins.flutter.io/camera_1',
    (int viewId) {
      videoElement = html.VideoElement()
        ..style.position = 'absolute'
        ..style.top = '0'
        ..style.left = '0'
        ..style.width = '100%'
        ..style.height = '100%'
        ..style.objectFit = 'cover' // Ensure the video covers the container
        ..autoplay = true
        ..setAttribute('playsinline', 'true');

      final constraints = {
        'video': {
          'facingMode': kIsWeb && html.window.navigator.userAgent.contains('Macintosh')
              ? 'user' // Front camera for Mac
              : 'environment' // Back camera for other devices
        }
      };

      html.window.navigator.mediaDevices
          ?.getUserMedia(constraints)
          .then((stream) {
        videoElement!.srcObject = stream;
      }).catchError((e) {
        videoElement!.text = 'Error accessing camera: $e';
      });

      return videoElement!;
    },
  );
}

Future<String> captureFrame() async {
  final html.CanvasElement canvas =
      html.CanvasElement(width: videoElement?.videoWidth ?? 0, height: videoElement?.videoHeight ?? 0);
  final html.CanvasRenderingContext2D ctx = canvas.getContext('2d') as html.CanvasRenderingContext2D;
  
  // Remove horizontal flip
  // ctx.translate(canvas.width!, 0);
  // ctx.scale(-1, 1);
  
  ctx.drawImage(videoElement!, 0, 0);
  return canvas.toDataUrl('image/png');
}
