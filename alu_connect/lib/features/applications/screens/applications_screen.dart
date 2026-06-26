import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../models/application_model.dart';
import '../../applications/providers/application_provider.dart';
import '../../opportunities/providers/opportunity_provider.dart';
import 'package:alu_connect/models/opportunity_model.dart';

class ApplicationsScreen extends ConsumerWidget {
  const ApplicationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final applications = ref.watch(applicationProvider);
    final allOpportunities = ref.watch(opportunityProvider);

    
    Opportunity? getOpportunity(String id) {
      return allOpportunities.firstWhere((opp) => opp.id == id, orElse: () => allOpportunities.first);
    }

    final applied = applications.where((app) => app.status == "Applied").toList();
    final underReview = applications.where((app) => app.status == "Review").toList();
    final accepted = applications.where((app) => app.status == "Accepted").toList();
    final rejected = applications.where((app) => app.status == "Rejected").toList();

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("My Applications"),
          elevation: 0,
          backgroundColor: Colors.white,
          foregroundColor: AppColors.textPrimary,
        ),
        body: Column(
          children: [
            const TabBar(
              labelColor: AppColors.royalBlue,
              unselectedLabelColor: Colors.grey,
              indicatorColor: AppColors.red,
              tabs: [
                Tab(text: "Applied"),
                Tab(text: "Review"),
                Tab(text: "Accepted"),
                Tab(text: "Rejected"),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _buildApplicationsList(applied, getOpportunity, "Applied"),
                  _buildApplicationsList(underReview, getOpportunity, "Under Review"),
                  _buildApplicationsList(accepted, getOpportunity, "Accepted"),
                  _buildApplicationsList(rejected, getOpportunity, "Rejected"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildApplicationsList(
    List<ApplicationModel> apps,
    Opportunity? Function(String) getOpp,
    String emptyStatus,
  ) {
    if (apps.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.work_off_outlined, size: 80, color: Colors.grey[300]),
            const SizedBox(height: 16),
            Text(
              "No $emptyStatus applications yet",
              style: const TextStyle(fontSize: 18, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            const Text(
              "Your applications will appear here",
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: apps.length,
      itemBuilder: (context, index) {
        final app = apps[index];
        final opportunity = getOpp(app.opportunityId);

        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: ListTile(
            contentPadding: const EdgeInsets.all(16),
            leading: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.royalBlue, AppColors.red],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.work, color: Colors.white),
            ),
            title: Text(
              opportunity?.title ?? "Opportunity",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(opportunity?.startup ?? ""),
                Text(
                  "${opportunity?.duration} • ${opportunity?.location}",
                  style: TextStyle(color: Colors.grey[600], fontSize: 13),
                ),
              ],
            ),
            trailing: _buildStatusBadge(app.status),
            onTap: () {
              
            },
          ),
        );
      },
    );
  }

  Widget _buildStatusBadge(String status) {
    Color color;
    switch (status.toLowerCase()) {
      case "accepted":
        color = Colors.green;
        break;
      case "review":
        color = Colors.orange;
        break;
      case "rejected":
        color = Colors.red;
        break;
      default:
        color = AppColors.royalBlue;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 12),
      ),
    );
  }
}