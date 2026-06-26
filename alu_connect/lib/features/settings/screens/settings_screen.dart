import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/providers/user_provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../auth/screens/login_screen.dart';
import '../../profile/screens/edit_profile_screen.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(currentUserProvider);
    final user = userAsync.value;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: AppColors.textPrimary,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: AppColors.royalBlue.withValues(alpha: 0.1),
                    child: const Icon(Icons.person, size: 40, color: AppColors.royalBlue),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user?.displayName ?? "Student",
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          user?.email ?? "",
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const EditProfileScreen()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),

          
          _buildSectionHeader("General"),
          Card(
            child: Column(
              children: [
                _buildSettingsTile(
                  icon: Icons.notifications_outlined,
                  title: "Notifications",
                  subtitle: "Manage push notifications",
                  trailing: const Switch(value: true, onChanged: null),
                ),
                const Divider(height: 1),
                _buildSettingsTile(
                  icon: Icons.dark_mode_outlined,
                  title: "Dark Mode",
                  subtitle: "Coming soon",
                  trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                ),
                const Divider(height: 1),
                _buildSettingsTile(
                  icon: Icons.language,
                  title: "Language",
                  subtitle: "English",
                  trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          
          _buildSectionHeader("Support & About"),
          Card(
            child: Column(
              children: [
                _buildSettingsTile(
                  icon: Icons.help_outline,
                  title: "Help & Support",
                  subtitle: "FAQs and contact",
                  onTap: () {},
                ),
                const Divider(height: 1),
                _buildSettingsTile(
                  icon: Icons.info_outline,
                  title: "About ALU Connect",
                  subtitle: "Version 1.0.0",
                  onTap: () {},
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),

          
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                if (context.mounted) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginScreen()),
                    (route) => false,
                  );
                }
              },
              icon: const Icon(Icons.logout),
              label: const Text("Logout"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red[400],
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: AppColors.royalBlue,
        ),
      ),
    );
  }

  Widget _buildSettingsTile({
    required IconData icon,
    required String title,
    String? subtitle,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppColors.royalBlue),
      title: Text(title),
      subtitle: subtitle != null ? Text(subtitle) : null,
      trailing: trailing,
      onTap: onTap,
    );
  }
}