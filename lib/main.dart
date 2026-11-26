import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/curae_provider.dart';
import 'screens/home_screen.dart';
import 'theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp();
  } catch (e) {
    debugPrint("Info Firebase Init: $e");
  }

  runApp(
    ChangeNotifierProvider(
      create: (_) => CuraeProvider(),
      child: const CuraeApp(),
    ),
  );
}

class CuraeApp extends StatelessWidget {
  const CuraeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'curae',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const HomeScreen(),
    );
  }
}
