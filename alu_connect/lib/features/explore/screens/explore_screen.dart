import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../opportunities/providers/opportunity_provider.dart';

class ExploreScreen extends ConsumerWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final opportunities = ref.watch(opportunityProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Explore"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: "Search opportunities...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: opportunities.length,
                itemBuilder: (context, index) {
                  final opportunity = opportunities[index];

                  return Card(
                    child: ListTile(
                      title: Text(opportunity.title),
                      subtitle: Text(
                        "${opportunity.startup} • ${opportunity.location}",
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}