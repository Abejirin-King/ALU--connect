import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/providers/user_provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../opportunities/providers/opportunity_provider.dart';
import '../../opportunities/widgets/opportunity_card.dart';
import '../../startup/screens/post_opportunity_screen.dart'; 

class StartupHomeScreen extends ConsumerWidget {
  const StartupHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(currentUserProvider);
    final opportunitiesAsync = ref.watch(opportunityProvider);

    final displayName = userAsync.value?.displayName?.split(' ').first ?? "Startup";

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Opportunities"),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: AppColors.textPrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const PostOpportunityScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hello, $displayName 👋",
                    style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "Manage your opportunities.",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search your opportunities...",
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),

            const SizedBox(height: 28),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Your Posted Opportunities",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 12),

            opportunitiesAsync.when(
              data: (opportunities) => Column(
                children: opportunities.map((opportunity) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  child: OpportunityCard(opportunity: opportunity),
                )).toList(),
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(child: Text("Error: $error")),
            ),
          ],
        ),
      ),
    );
  }
}