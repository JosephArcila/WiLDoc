import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:wil_doc/providers/user_provider.dart';
import 'package:wil_doc/utils/theme.dart';
import 'package:wil_doc/utils/web_view_factory.dart';
import 'package:wil_doc/routes/app_routes.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await dotenv.load(fileName: ".env");
  
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyBDo5W2woIYsKuycY5mkpVDDmen5R8TYlI",
      authDomain: "wildocjapan.firebaseapp.com",
      projectId: "wildocjapan",
      storageBucket: "wildocjapan.appspot.com",
      messagingSenderId: "355560021631",
      appId: "1:355560021631:web:212af7d0257ef096b3294a",
      measurementId: "G-0PPQWPM7DD",
    ),
  );
  
  if (kDebugMode) {
    print("Firebase initialized");
  }

  registerWebViewFactory();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WiLDoc translate customizable',
      theme: lightHighContrastTheme,
      initialRoute: AppRoutes.scanDocument,
      onGenerateRoute: AppRoutes.generateRoute,
    );
  }
}