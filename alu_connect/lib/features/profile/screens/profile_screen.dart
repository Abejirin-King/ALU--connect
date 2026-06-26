import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../core/providers/user_provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../applications/providers/application_provider.dart';
import '../../settings/screens/settings_screen.dart';
import '../../help/screens/help_support_screen.dart';
import '../../auth/screens/login_screen.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(currentUserProvider);
    final user = userAsync.value;
    final applications = ref.watch(applicationProvider);

    final totalApplied = applications.length;
    final shortlisted = applications.where((a) => a.status.toLowerCase().contains("review")).length;
    final accepted = applications.where((a) => a.status.toLowerCase() == "accepted").length;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsScreen())),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Center(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: AppColors.royalBlue.withValues(alpha: 0.1),
                  child: const Icon(Icons.person, size: 60, color: AppColors.royalBlue),
                ),
                const SizedBox(height: 16),
                Text(
                  user?.displayName ?? "Student",
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Text(
                  user?.email ?? "",
                  style: const TextStyle(color: Colors.grey, fontSize: 16),
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStat(totalApplied.toString(), "Applications"),
              _buildStat(shortlisted.toString(), "Shortlisted"),
              _buildStat(accepted.toString(), "Accepted"),
            ],
          ),

          const SizedBox(height: 32),

          _buildMenuItem(Icons.person_outline, "My Profile", () {}),
          _buildMenuItem(Icons.interests, "Skills & Interests", () {}),
          _buildMenuItem(Icons.bookmark_border, "Saved Opportunities", () {}),
          _buildMenuItem(Icons.notifications_outlined, "Notifications", () {}),
          _buildMenuItem(Icons.help_outline, "Help & Support", () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const HelpSupportScreen()));
          }),
          _buildMenuItem(Icons.logout, "Logout", () async {
            await FirebaseAuth.instance.signOut();
            if (context.mounted) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const LoginScreen()),
                (route) => false,
              );
            }
          }, color: Colors.red),
        ],
      ),
    );
  }

  Widget _buildStat(String count, String label) {
    return Column(
      children: [
        Text(count, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.royalBlue)),
        Text(label, style: const TextStyle(color: Colors.grey)),
      ],
    );
  }

  Widget _buildMenuItem(IconData icon, String title, VoidCallback onTap, {Color? color}) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(icon, color: color ?? AppColors.royalBlue),
        title: Text(title, style: TextStyle(color: color)),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}