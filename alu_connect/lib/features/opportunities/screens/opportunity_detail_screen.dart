import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../../../models/opportunity_model.dart';
import '../../applications/providers/application_provider.dart';

class OpportunityDetailScreen extends ConsumerWidget {
  final Opportunity opportunity;

  const OpportunityDetailScreen({
    super.key,
    required this.opportunity,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(opportunity.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.royalBlue,
                    AppColors.red,
                  ],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    opportunity.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    opportunity.startup,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    spacing: 8,
                    children: [
                      Chip(
                        label: Text(opportunity.category),
                      ),
                      Chip(
                        label: Text(opportunity.duration),
                      ),
                      Chip(
                        label: Text(opportunity.location),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  const Text(
                    "Description",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    opportunity.description,
                    style: const TextStyle(
                      fontSize: 16,
                      height: 1.5,
                    ),
                  ),

                  const SizedBox(height: 24),

                  const Text(
                    "Responsibilities",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  const ListTile(
                    leading: Icon(Icons.check_circle),
                    title: Text("Collaborate with startup team"),
                  ),

                  const ListTile(
                    leading: Icon(Icons.check_circle),
                    title: Text("Attend weekly meetings"),
                  ),

                  const ListTile(
                    leading: Icon(Icons.check_circle),
                    title: Text("Submit progress updates"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          onPressed: () {
            ref
                .read(applicationProvider.notifier)
                .apply(opportunity.id);

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  "Application Submitted Successfully",
                ),
              ),
            );
          },
          child: const Text("Apply Now"),
        ),
      ),
    );
  }
}