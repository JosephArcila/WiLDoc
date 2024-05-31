import 'package:flutter/material.dart';
import 'package:wil_doc/screens/auth/login_screen.dart';
import 'package:wil_doc/screens/auth/register_screen.dart';
import 'package:wil_doc/screens/auth/account_screen.dart';
import 'package:wil_doc/screens/auth/reset_password_screen.dart';
import 'package:wil_doc/screens/auth/onboarding_screen.dart';
import 'package:wil_doc/screens/home/scan_document_screen.dart';
import 'package:wil_doc/screens/document/document_preview_screen.dart';
import 'package:wil_doc/screens/document/document_summary_screen.dart';
import 'package:wil_doc/screens/document/document_translation_screen.dart';
import 'package:wil_doc/screens/document/document_guide_screen.dart';
import 'package:wil_doc/screens/document/documents_screen.dart';
import 'package:wil_doc/screens/feedback/feedback_screen.dart';

class AppRoutes {
  static const String login = '/login';
  static const String register = '/register';
  static const String account = '/account';
  static const String resetPassword = '/reset-password';
  static const String onboarding = '/onboarding';
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
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case register:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case account:
        return MaterialPageRoute(builder: (_) => const AccountScreen());
      case resetPassword:
        return MaterialPageRoute(builder: (_) => const ResetPasswordScreen());
      case onboarding:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());
      case scanDocument:
        return MaterialPageRoute(builder: (_) => const ScanDocumentScreen());
      case documentPreview:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(builder: (_) => DocumentPreviewScreen(imagePath: args['imagePath']));
      case documentSummary:
        return MaterialPageRoute(builder: (_) => const DocumentSummaryScreen());
      case documentTranslation:
        return MaterialPageRoute(builder: (_) => const DocumentTranslationScreen());
      case documentGuide:
        return MaterialPageRoute(builder: (_) => const DocumentGuideScreen());
      case documents:
        return MaterialPageRoute(builder: (_) => const DocumentsScreen());
      case feedback:
        return MaterialPageRoute(builder: (_) => const FeedbackScreen());
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
