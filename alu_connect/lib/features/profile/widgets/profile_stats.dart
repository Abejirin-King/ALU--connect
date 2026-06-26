import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class ProfileStatsRow extends StatelessWidget {
  final int applied;
  final int shortlisted;
  final int accepted;

  const ProfileStatsRow({
    super.key,
    required this.applied,
    required this.shortlisted,
    required this.accepted,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildStat(applied.toString(), "Applications"),
        _buildStat(shortlisted.toString(), "Shortlisted"),
        _buildStat(accepted.toString(), "Accepted"),
      ],
    );
  }

  Widget _buildStat(String count, String label) {
    return Column(
      children: [
        Text(
          count,
          style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.royalBlue),
        ),
        Text(
          label,
          style: const TextStyle(color: Colors.grey, fontSize: 14),
        ),
      ],
    );
  }
}