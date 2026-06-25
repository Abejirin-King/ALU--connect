import 'package:flutter/material.dart';

class ApplicationsScreen extends StatelessWidget {
  const ApplicationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("My Applications"),
          bottom: const TabBar(
            tabs: [
              Tab(text: "Applied"),
              Tab(text: "Review"),
              Tab(text: "Accepted"),
              Tab(text: "Rejected"),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            Center(child: Text("Applied Applications")),
            Center(child: Text("Under Review")),
            Center(child: Text("Accepted")),
            Center(child: Text("Rejected")),
          ],
        ),
      ),
    );
  }
}