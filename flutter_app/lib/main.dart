import 'package:flutter/material.dart';

import 'screens/home_screen.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const PixelVaultApp());
}

class PixelVaultApp extends StatelessWidget {
  const PixelVaultApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pixel Vault',
      theme: AppTheme.darkTheme,
      home: const HomeScreen(),
    );
  }
}
