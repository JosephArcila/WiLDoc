import 'dart:html' as html;
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
        ..setAttribute('playsinline', 'true')
        ..style.transform = 'scaleX(-1)'; // Apply the horizontal flip

      html.window.navigator.mediaDevices
          ?.getUserMedia({'video': true})
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
      html.CanvasElement(width: videoElement!.videoWidth, height: videoElement!.videoHeight);
  final html.CanvasRenderingContext2D ctx = canvas.getContext('2d') as html.CanvasRenderingContext2D;
  // Draw the flipped video feed onto the canvas
  ctx.translate(canvas.width!, 0);
  ctx.scale(-1, 1);
  ctx.drawImage(videoElement!, 0, 0);
  return canvas.toDataUrl('image/png');
}
