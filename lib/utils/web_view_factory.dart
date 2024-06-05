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
          'facingMode':
              kIsWeb && html.window.navigator.userAgent.contains('Macintosh')
                  ? 'user' // Front camera for Mac used just for testing
                  : 'environment', // Back camera for other devices
          'width': {'ideal': 1920},
          'height': {'ideal': 1080},
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
  final width = videoElement?.videoWidth ?? 0;
  final height = videoElement?.videoHeight ?? 0;
  
  // Creating a canvas element with the same resolution as the video
  final html.CanvasElement canvas = html.CanvasElement(width: width, height: height);
  final html.CanvasRenderingContext2D ctx = canvas.getContext('2d') as html.CanvasRenderingContext2D;
  
  ctx.drawImage(videoElement!, 0, 0);
  ctx.filter = 'contrast(1.5) brightness(1.2)';
  return canvas.toDataUrl('image/png');
}