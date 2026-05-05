import 'package:flutter/material.dart';
import 'splash_screen.dart'; // 🔥 tambahkan ini

void main() {
  runApp(const CafeShopApp());
}

class CafeShopApp extends StatelessWidget {
  const CafeShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CafeShop - Anjel Dina',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF3C2218),
          primary: const Color(0xFF3C2218),
        ),
        fontFamily: 'Serif',
      ),

      // 🔥 MULAI DARI SPLASH
      home: const SplashScreen(),
    );
  }
}