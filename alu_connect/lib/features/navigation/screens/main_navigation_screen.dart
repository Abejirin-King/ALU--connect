import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/providers/user_provider.dart';
import '../../home/screens/home_screen.dart';
import '../../explore/screens/explore_screen.dart';
import '../../applications/screens/applications_screen.dart';
import '../../profile/screens/profile_screen.dart';
import '../../startup/screens/startup_home_screen.dart';

class MainNavigationScreen extends ConsumerStatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  ConsumerState<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends ConsumerState<MainNavigationScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final roleAsync = ref.watch(userRoleProvider);
    final isStartup = roleAsync.value == "startup";

    final pages = [
      isStartup ? const StartupHomeScreen() : const HomeScreen(),
      const ExploreScreen(),
      const ApplicationsScreen(),
      isStartup ? const ProfileScreen() : const ProfileScreen(), 
    ];

    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: (index) {
          setState(() => currentIndex = index);
        },
        destinations: [
          const NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: "Home"),
          const NavigationDestination(icon: Icon(Icons.explore_outlined), selectedIcon: Icon(Icons.explore), label: "Explore"),
          const NavigationDestination(icon: Icon(Icons.assignment_outlined), selectedIcon: Icon(Icons.assignment), label: "Applications"),
          NavigationDestination(
            icon: Icon(isStartup ? Icons.business : Icons.person_outline),
            selectedIcon: Icon(isStartup ? Icons.business : Icons.person),
            label: isStartup ? "Profile" : "Profile",
          ),
        ],
      ),
    );
  }
}