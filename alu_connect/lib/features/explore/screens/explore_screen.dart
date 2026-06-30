import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/providers/user_provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../opportunities/providers/opportunity_provider.dart';
import '../../opportunities/widgets/opportunity_card.dart';
import '../../opportunities/screens/opportunity_detail_screen.dart';

class ExploreScreen extends ConsumerWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final roleAsync = ref.watch(userRoleProvider);
    final opportunitiesAsync = ref.watch(opportunityProvider);

    final isStartup = roleAsync.value == "startup";

    return Scaffold(
      appBar: AppBar(
        title: Text(isStartup ? "My Opportunities" : "Explore Opportunities"),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: AppColors.textPrimary,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search opportunities...",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) {},
            ),
          ),

          SizedBox(
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: const [
                _FilterChip(label: "All", isSelected: true),
                _FilterChip(label: "Design"),
                _FilterChip(label: "Engineering"),
                _FilterChip(label: "Marketing"),
                _FilterChip(label: "Data"),
                _FilterChip(label: "Remote"),
              ],
            ),
          ),

          const SizedBox(height: 8),

          Expanded(
            child: opportunitiesAsync.when(
              data: (opportunities) {
                return opportunities.isEmpty
                    ? const Center(child: Text("No opportunities found"))
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: opportunities.length,
                        itemBuilder: (context, index) {
                          final opp = opportunities[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => OpportunityDetailScreen(opportunity: opp),
                                ),
                              );
                            },
                            child: OpportunityCard(opportunity: opp),
                          );
                        },
                      );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(child: Text("Error: $error")),
            ),
          ),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;

  const _FilterChip({
    required this.label,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (bool value) {},
        backgroundColor: Colors.grey[200],
        selectedColor: AppColors.royalBlue.withValues(alpha: 0.2),
        labelStyle: TextStyle(
          color: isSelected ? AppColors.royalBlue : Colors.black87,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}