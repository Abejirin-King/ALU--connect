import 'package:flutter/material.dart';

class StartupDashboardScreen extends StatelessWidget {
  const StartupDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Startup Dashboard"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          children: const [
            DashboardCard(title: "Active Roles", value: "4", icon: Icons.work, color: Colors.blue),
            DashboardCard(title: "Total Applications", value: "24", icon: Icons.people, color: Colors.orange),
            DashboardCard(title: "Shortlisted", value: "7", icon: Icons.star, color: Colors.purple),
            DashboardCard(title: "Accepted", value: "3", icon: Icons.check_circle, color: Colors.green),
          ],
        ),
      ),
    );
  }
}

class DashboardCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const DashboardCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: color),
            const SizedBox(height: 12),
            Text(value, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            Text(title, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}