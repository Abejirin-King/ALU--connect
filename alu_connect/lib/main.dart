import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/theme/app_theme.dart';
import 'features/navigation/screens/main_navigation_screen.dart';

void main() {
  runApp(
    const ProviderScope(
      child: AluConnectApp(),
    ),
  );
}

class AluConnectApp extends StatelessWidget {
  const AluConnectApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ALU Connect',
      theme: AppTheme.lightTheme,
      home: const MainNavigationScreen(),
    );
  }
}