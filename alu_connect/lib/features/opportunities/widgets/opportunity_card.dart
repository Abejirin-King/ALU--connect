import 'package:flutter/material.dart';

import '../../../models/opportunity_model.dart';
import '../screens/opportunity_detail_screen.dart';

class OpportunityCard extends StatelessWidget {
  final Opportunity opportunity;

  const OpportunityCard({
    super.key,
    required this.opportunity,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        title: Text(
          opportunity.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          "${opportunity.startup} • ${opportunity.location}",
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 16,
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  OpportunityDetailScreen(
                opportunity: opportunity,
              ),
            ),
          );
        },
      ),
    );
  }
}