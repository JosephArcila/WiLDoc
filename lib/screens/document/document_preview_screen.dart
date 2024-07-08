import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
// ignore: avoid_web_libraries_in_flutter
import 'dart:js' as js;
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wil_doc/routes/app_routes.dart';
import 'package:wil_doc/utils/temp_data.dart';
import 'package:crop_image/crop_image.dart';

class DocumentPreviewScreen extends StatefulWidget {
  final List<String> imagePaths;

  const DocumentPreviewScreen({super.key, required this.imagePaths});

  @override
  DocumentPreviewScreenState createState() => DocumentPreviewScreenState();
}

class DocumentPreviewScreenState extends State<DocumentPreviewScreen> {
  late final String _imagePath;
  final String extractedText = "Extracting text...";
  final controller = CropController();

  @override
  void initState() {
    super.initState();
    _imagePath = widget.imagePaths.first;
  }

  Future<void> _handleConfirm() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    try {
      final croppedImage = await controller.croppedImage();
      final blob = await _imageToBlob(croppedImage);
      final extractedText = await _extractTextFromBlob(blob);

      if (mounted) {
        Navigator.pop(context); // Close loading dialog
      }

      TempData.extractedText = extractedText;

      final User? user = FirebaseAuth.instance.currentUser;
      if (mounted) {
        if (user != null) {
          Navigator.pushReplacementNamed(context, AppRoutes.documentSummary);
        } else {
          Navigator.pushNamed(context, AppRoutes.login, arguments: {'redirectTo': AppRoutes.documentSummary});
        }
      }
    } catch (e) {
      if (mounted) {
        Navigator.pop(context); // Close loading dialog
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error processing image: $e')),
        );
      }
    }
  }

  void _rescanAndClearTemp() {
    TempData.extractedText = null;
    Navigator.pushReplacementNamed(context, AppRoutes.scanDocument);
  }

  Future<html.Blob> _imageToBlob(Image croppedImage) async {
    final completer = Completer<html.Blob>();
    
    final imageProvider = croppedImage.image;
    final imageStream = imageProvider.resolve(ImageConfiguration.empty);
    imageStream.addListener(ImageStreamListener((ImageInfo imageInfo, bool synchronousCall) async {
      final byteData = await imageInfo.image.toByteData(format: ui.ImageByteFormat.png);
      if (byteData != null) {
        final buffer = byteData.buffer;
        final blob = html.Blob([Uint8List.view(buffer)], 'image/png');
        completer.complete(blob);
      } else {
        completer.completeError('Failed to convert image to ByteData');
      }
    }, onError: (dynamic error, StackTrace? stackTrace) {
      completer.completeError('Failed to load image: $error');
    }));

    return completer.future;
  }

  Future<String> _extractTextFromBlob(html.Blob blob) async {
    final reader = html.FileReader();
    reader.readAsDataUrl(blob);
    await reader.onLoad.first;
    
    final dataUrl = reader.result as String;
    final promise = js.context.callMethod('extractTextFromImage', [dataUrl]);
    final text = await promiseToFuture(promise);
    return text;
  }

  Future<String> promiseToFuture(js.JsObject promise) {
    final completer = Completer<String>();
    promise.callMethod('then', [
      (result) => completer.complete(result),
      (error) => completer.completeError(error)
    ]);
    return completer.future;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('Document Preview'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: _rescanAndClearTemp,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: AspectRatio(
                  aspectRatio: 3 / 4,
                  child: CropImage(
                    controller: controller,
                    image: Image.network(_imagePath),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Crop the image to focus on the document for better accuracy',
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                alignment: WrapAlignment.center,
                children: [
                  OutlinedButton.icon(
                    onPressed: _rescanAndClearTemp,
                    icon: const Icon(Icons.refresh),
                    label: const Text('Rescan'),
                  ),
                  FilledButton.icon(
                    onPressed: _handleConfirm,
                    icon: const Icon(Icons.check),
                    label: const Text('Confirm Crop'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}