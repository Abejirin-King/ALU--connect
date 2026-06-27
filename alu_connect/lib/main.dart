import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'firebase_options.dart';
import 'core/theme/app_theme.dart';
import 'core/providers/user_provider.dart';
import 'features/auth/screens/login_screen.dart';
import 'features/navigation/screens/main_navigation_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(currentUserProvider);

    return MaterialApp(
      title: 'ALU Connect',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: userAsync.when(
        data: (user) => user != null 
            ? const MainNavigationScreen() 
            : const LoginScreen(),
        loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
        error: (_, __) => const LoginScreen(),
      ),
    );
  }
}