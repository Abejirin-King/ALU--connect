import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Help & Support")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            "How can we help you today?",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),

          _buildHelpCard(context, Icons.question_answer, "FAQs", "Frequently asked questions"),
          _buildHelpCard(context, Icons.contact_support, "Contact Us", "Get in touch with support"),
          _buildHelpCard(context, Icons.report_problem, "Report an Issue", "Found a bug or problem?"),
          _buildHelpCard(context, Icons.school, "ALU Resources", "Student support & guidelines"),
        ],
      ),
    );
  }

  Widget _buildHelpCard(
    BuildContext context,
    IconData icon,
    String title,
    String subtitle,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(icon, color: AppColors.royalBlue, size: 32),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Opening $title...")),
          );
          
        },
      ),
    );
  }
}