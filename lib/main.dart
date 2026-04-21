import 'package:flutter/material.dart';
import 'login_page.dart';

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
        // Tema warna utama: Cokelat Tua #3C2218
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF3C2218),
          primary: const Color(0xFF3C2218),
        ),
        fontFamily: 'Serif',
      ),
      home: const LoginPage(),
    );
  }
}