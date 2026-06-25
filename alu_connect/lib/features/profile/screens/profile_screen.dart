import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              child: Icon(
                Icons.person,
                size: 50,
              ),
            ),

            const SizedBox(height: 16),

            const Text(
              "Amina Hassan",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const Text(
              "Flutter Developer",
            ),

            const SizedBox(height: 24),

            Card(
              child: ListTile(
                leading: const Icon(Icons.code),
                title: const Text("Skills"),
                subtitle: const Text(
                  "Flutter, Firebase, Git, UI Design",
                ),
              ),
            ),

            Card(
              child: ListTile(
                leading: const Icon(Icons.bookmark),
                title: const Text("Saved Opportunities"),
                trailing: const Text("8"),
              ),
            ),

            Card(
              child: ListTile(
                leading: const Icon(Icons.assignment),
                title: const Text("Applications"),
                trailing: const Text("12"),
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.logout),
              label: const Text("Logout"),
            ),
          ],
        ),
      ),
    );
  }
}