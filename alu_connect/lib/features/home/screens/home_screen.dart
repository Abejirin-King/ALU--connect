import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/providers/user_provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../opportunities/providers/opportunity_provider.dart';
import '../../opportunities/widgets/opportunity_card.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(currentUserProvider);
    final opportunities = ref.watch(opportunityProvider);

    final displayName = userAsync.value?.displayName?.split(' ').first ?? "Student";

    return Scaffold(
      appBar: AppBar(
        title: const Text("ALU Connect"),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: AppColors.textPrimary,
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
                    "Find meaningful ways to contribute.",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search opportunities...",
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

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  gradient: const LinearGradient(
                    colors: [AppColors.royalBlue, Color(0xFF9C27B0), AppColors.red],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.royalBlue.withValues(alpha: 0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.25),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: const Icon(Icons.design_services, color: Colors.white, size: 32),
                        ),
                        const Spacer(),
                        const Icon(Icons.bookmark_border, color: Colors.white, size: 28),
                      ],
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      "UX Research Volunteer",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      "EduBridge",
                      style: TextStyle(color: Colors.white70, fontSize: 16),
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 8,
                      children: [
                        _buildTag("UX Design"),
                        _buildTag("Research"),
                        _buildTag("Remote"),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        const Text(
                          "4-6 hrs/week",
                          style: TextStyle(color: Colors.white70),
                        ),
                        const Spacer(),
                        const Text(
                          "Posted 2d ago",
                          style: TextStyle(color: Colors.white70),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 32),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Browse by category",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 16),
            _buildCategoryBrowse(),

            const SizedBox(height: 32),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Recent opportunities",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 12),

           opportunities.when(
              data: (list) => Column(
                children: list.map((opportunity) => Padding(
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

  Widget _buildTag(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.25),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: const TextStyle(color: Colors.white, fontSize: 13),
      ),
    );
  }

  Widget _buildCategoryBrowse() {
    final categories = [
      {"name": "Design", "icon": Icons.design_services},
      {"name": "Engineering", "icon": Icons.engineering},
      {"name": "Marketing", "icon": Icons.campaign},
      {"name": "Data", "icon": Icons.analytics},
      {"name": "Other", "icon": Icons.more_horiz},
    ];

    return SizedBox(
      height: 115,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final cat = categories[index];
          return Padding(
            padding: const EdgeInsets.only(right: 20),
            child: GestureDetector(
              onTap: () {},
              child: Column(
                children: [
                  Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [AppColors.royalBlue, AppColors.red],
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.royalBlue.withValues(alpha: 0.3),
                          blurRadius: 12,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Icon(
                      cat["icon"] as IconData,
                      color: Colors.white,
                      size: 34,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    cat["name"] as String,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}