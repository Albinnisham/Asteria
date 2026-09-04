import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'screens/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Color(0xFF071225),
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );

  runApp(const AsteriaApp());
}

class AsteriaApp extends StatelessWidget {
  const AsteriaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Asteria',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF071225),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFB7C5FF),
          onPrimary: Color(0xFF101A38),
          secondary: Color(0xFFD8BEFF),
          surface: Color(0xFF111F3A),
          onSurface: Color(0xFFF4F5FB),
          error: Color(0xFFFFB4AB),
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontSize: 48,
            fontWeight: FontWeight.w700,
            letterSpacing: -1.5,
            height: 1.05,
          ),
          displaySmall: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.w700,
            letterSpacing: -1,
            height: 1.1,
          ),
          headlineMedium: TextStyle(
            fontSize: 27,
            fontWeight: FontWeight.w700,
            height: 1.15,
          ),
          titleLarge: TextStyle(fontSize: 21, fontWeight: FontWeight.w700),
          titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          bodyLarge: TextStyle(
            fontSize: 16,
            height: 1.55,
            color: Color(0xFFD7DCEC),
          ),
          bodyMedium: TextStyle(
            fontSize: 14,
            height: 1.5,
            color: Color(0xFFBBC4D9),
          ),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
