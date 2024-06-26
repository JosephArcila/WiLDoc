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
  
  // Draw the original image
  ctx.drawImage(videoElement!, 0, 0);
  
  // Apply preprocessing
  applyPreprocessing(ctx, canvas, width, height);
  
  return canvas.toDataUrl('image/png');
}

void applyPreprocessing(html.CanvasRenderingContext2D ctx, html.CanvasElement canvas, int width, int height) {
  // Get the image data
  var imageData = ctx.getImageData(0, 0, width, height);
  var data = imageData.data;

  // Convert to grayscale and increase contrast
  for (var i = 0; i < data.length; i += 4) {
    var avg = (data[i] + data[i + 1] + data[i + 2]) / 3;
    avg = (avg - 128) * 1.5 + 128; // Increase contrast
    avg = avg.clamp(0, 255);
    data[i] = avg.round();
    data[i + 1] = avg.round();
    data[i + 2] = avg.round();
  }

  // Apply the processed image data back to the canvas
  ctx.putImageData(imageData, 0, 0);

  // Apply sharpening
  ctx.filter = 'contrast(1.2) brightness(1.1) saturate(0) sharpen(1)';
  ctx.drawImage(canvas, 0, 0);
  ctx.filter = 'none';
}