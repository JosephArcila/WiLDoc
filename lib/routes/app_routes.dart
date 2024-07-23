import 'package:flutter/material.dart';
import 'package:wil_doc/screens/auth/login_screen.dart';
import 'package:wil_doc/screens/auth/register_screen.dart';
import 'package:wil_doc/screens/auth/account_screen.dart';
import 'package:wil_doc/screens/auth/reset_password_screen.dart';
import 'package:wil_doc/screens/auth/profilesetup_screen.dart';
import 'package:wil_doc/screens/home/scan_document_screen.dart';
import 'package:wil_doc/screens/document/document_preview_screen.dart';
import 'package:wil_doc/screens/document/document_summary_screen.dart';

class AppRoutes {
  static const String login = '/login';
  static const String register = '/register';
  static const String account = '/account';
  static const String resetPassword = '/reset-password';
  static const String profilesetup = '/profilesetup';
  static const String scanDocument = '/scan-document';
  static const String documentPreview = '/document-preview';
  static const String documentSummary = '/document-summary';
  static const String documentTranslation = '/document-translation';
  static const String documentGuide = '/document-guide';
  static const String documents = '/documents';
  static const String feedback = '/feedback';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        final args = settings.arguments as Map<String, dynamic>? ?? {};
        final redirectTo = args['redirectTo'] as String?;
        return MaterialPageRoute(builder: (_) => LoginScreen(redirectTo: redirectTo));
      case register:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case account:
        return MaterialPageRoute(builder: (_) => const AccountScreen());
      case resetPassword:
        return MaterialPageRoute(builder: (_) => const ResetPasswordScreen());
      case profilesetup:
        return MaterialPageRoute(builder: (_) => const ProfileSetupScreen());
      case scanDocument:
        return MaterialPageRoute(builder: (_) => const ScanDocumentScreen());
      case documentPreview:
        final imagePath = settings.arguments as String;
        return MaterialPageRoute(builder: (_) => DocumentPreviewScreen(imagePath: imagePath));
      case documentSummary:
        return MaterialPageRoute(builder: (_) => const DocumentSummaryScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}