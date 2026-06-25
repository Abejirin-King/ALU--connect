import 'package:flutter/material.dart';

class StartupDashboardScreen extends StatelessWidget {
  const StartupDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Startup Dashboard"),
      ),
      body: GridView.count(
        padding: const EdgeInsets.all(16),
        crossAxisCount: 2,
        children: const [
          DashboardCard(
            title: "Active Roles",
            value: "4",
            icon: Icons.work,
          ),
          DashboardCard(
            title: "Applications",
            value: "24",
            icon: Icons.people,
          ),
          DashboardCard(
            title: "Interviews",
            value: "7",
            icon: Icons.video_call,
          ),
          DashboardCard(
            title: "Accepted",
            value: "3",
            icon: Icons.check_circle,
          ),
        ],
      ),
    );
  }
}

class DashboardCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const DashboardCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40),
            const SizedBox(height: 10),
            Text(
              value,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(title),
          ],
        ),
      ),
    );
  }
}