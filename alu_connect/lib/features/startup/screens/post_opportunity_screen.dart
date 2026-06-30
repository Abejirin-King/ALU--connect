import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class PostOpportunityScreen extends StatefulWidget {
  const PostOpportunityScreen({super.key});

  @override
  State<PostOpportunityScreen> createState() => _PostOpportunityScreenState();
}

class _PostOpportunityScreenState extends State<PostOpportunityScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _durationController = TextEditingController();
  final _locationController = TextEditingController();
  bool _isLoading = false;

  Future<void> _postOpportunity() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final user = FirebaseAuth.instance.currentUser;

      await FirebaseFirestore.instance.collection('opportunities').add({
        'title': _titleController.text.trim(),
        'description': _descriptionController.text.trim(),
        'duration': _durationController.text.trim(),
        'location': _locationController.text.trim(),
        'startup': user?.displayName ?? "Unknown Startup",
        'startupId': user?.uid,
        'createdAt': FieldValue.serverTimestamp(),
        'category': "General",
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("✅ Opportunity posted successfully!")),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: $e")),
        );
      }
    }

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Post New Opportunity")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: "Role Title"),
                validator: (value) => value!.isEmpty ? "Required" : null,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _descriptionController,
                maxLines: 5,
                decoration: const InputDecoration(labelText: "Description"),
                validator: (value) => value!.isEmpty ? "Required" : null,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _durationController,
                decoration: const InputDecoration(labelText: "Duration (e.g. 8 weeks)"),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _locationController,
                decoration: const InputDecoration(labelText: "Location"),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _postOpportunity,
                  style: ElevatedButton.styleFrom(backgroundColor: AppColors.royalBlue),
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text("Publish Opportunity"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}