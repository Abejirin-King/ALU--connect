import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class ApplicantsScreen extends StatelessWidget {
  final String opportunityId;

  const ApplicantsScreen({super.key, required this.opportunityId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Applicants")),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          _buildApplicantCard("John Doe", "Flutter Developer", "Applied"),
          _buildApplicantCard("Sarah Lee", "UI/UX Designer", "Shortlisted"),
        ],
      ),
    );
  }

  Widget _buildApplicantCard(String name, String role, String status) {
    Color statusColor = status == "Shortlisted" ? Colors.orange : Colors.grey;

    return Card(
      margin: const EdgeInsets.all(12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text(role, style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    child: const Text("Accept"),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    child: const Text("Reject"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}