import 'package:flutter/material.dart';
import 'package:wil_doc/screens/home/scan_document_screen.dart';
import 'package:wil_doc/utils/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WiLDoc',
      theme: lightHighContrastTheme,
      home: const ScanDocumentScreen(),
    );
  }
}
