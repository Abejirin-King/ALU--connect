import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../applications/providers/application_provider.dart';
import '../../../models/opportunity_model.dart';   

class OpportunityDetailScreen extends ConsumerWidget {
  final Opportunity opportunity;

  const OpportunityDetailScreen({
    super.key, 
    required this.opportunity,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final applicationNotifier = ref.read(applicationProvider.notifier);
    final isApplied = ref.watch(applicationProvider)
        .any((app) => app.opportunityId == opportunity.id);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Opportunity Details"),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            Container(
              width: double.infinity,
              height: 220,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.royalBlue, AppColors.red],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: const Center(
                child: Icon(Icons.work_outline, size: 110, color: Colors.white),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    opportunity.title,
                    style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    opportunity.startup,
                    style: const TextStyle(fontSize: 18, color: Colors.grey),
                  ),

                  const SizedBox(height: 20),

                  Row(
                    children: [
                      _buildInfoChip(Icons.access_time, opportunity.duration),
                      const SizedBox(width: 12),
                      _buildInfoChip(Icons.location_on, opportunity.location),
                    ],
                  ),

                  const SizedBox(height: 32),

                  const Text("About", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  Text(
                    opportunity.description,
                    style: const TextStyle(fontSize: 16, height: 1.6),
                  ),

                  const SizedBox(height: 32),

                  const Text("Skills required", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: const ["Flutter", "Dart", "Problem Solving"]
                        .map((skill) => _buildSkillChip(skill))
                        .toList(),
                  ),

                  const SizedBox(height: 40),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: isApplied
                          ? null
                          : () {
                              applicationNotifier.apply(opportunity.id);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("✅ Application submitted successfully!"),
                                  backgroundColor: Colors.green,
                                ),
                              );
                              Navigator.pop(context);
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.royalBlue,
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                      child: Text(
                        isApplied ? "Already Applied" : "Apply Now",
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 20, color: AppColors.royalBlue),
          const SizedBox(width: 8),
          Text(label),
        ],
      ),
    );
  }

  Widget _buildSkillChip(String skill) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.royalBlue.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        skill,
        style: const TextStyle(color: AppColors.royalBlue, fontWeight: FontWeight.w500),
      ),
    );
  }
}