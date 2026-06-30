import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../models/opportunity_model.dart';

final opportunityProvider = StreamProvider<List<Opportunity>>((ref) {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) return Stream.value(demoOpportunities);

  return FirebaseFirestore.instance
      .collection('users')
      .doc(user.uid)
      .get()
      .asStream()
      .asyncExpand((userDoc) async* {
        final role = userDoc.data()?['role'] ?? "student";

        if (role == "startup") {
          yield* FirebaseFirestore.instance
              .collection('opportunities')
              .where('startupId', isEqualTo: user.uid)
              .snapshots()
              .map((snapshot) {
                return snapshot.docs.map((doc) {
                  final data = doc.data();
                  return Opportunity(
                    id: doc.id,
                    startupId: data['startupId'] ?? '',
                    startup: data['startup'] ?? '',
                    title: data['title'] ?? '',
                    category: data['category'] ?? '',
                    duration: data['duration'] ?? '',
                    location: data['location'] ?? '',
                    description: data['description'] ?? '',
                  );
                }).toList();
              });
        } else {
          yield* FirebaseFirestore.instance
              .collection('opportunities')
              .snapshots()
              .map((snapshot) {
                final firestoreOpps = snapshot.docs.map((doc) {
                  final data = doc.data();
                  return Opportunity(
                    id: doc.id,
                    startupId: data['startupId'] ?? '',
                    startup: data['startup'] ?? '',
                    title: data['title'] ?? '',
                    category: data['category'] ?? '',
                    duration: data['duration'] ?? '',
                    location: data['location'] ?? '',
                    description: data['description'] ?? '',
                  );
                }).toList();

                return [...demoOpportunities, ...firestoreOpps];
              });
        }
      });
});

final List<Opportunity> demoOpportunities = [
  Opportunity(
    id: "1",
    startupId: "startup_1",
    title: "Flutter Developer",
    startup: "EduBridge",
    category: "Software",
    duration: "8 Weeks",
    location: "Remote",
    description: "Build mobile applications using Flutter and Firebase.",
  ),
  Opportunity(
    id: "2",
    startupId: "startup_1",
    title: "UI/UX Research Volunteer",
    startup: "EduBridge",
    category: "Design",
    duration: "6 Weeks",
    location: "Hybrid",
    description: "Conduct user interviews and improve onboarding experiences.",
  ),
  Opportunity(
    id: "3",
    startupId: "startup_2",
    title: "Social Media Assistant",
    startup: "PanTree",
    category: "Marketing",
    duration: "4 Weeks",
    location: "Remote",
    description: "Create content and manage startup social media channels.",
  ),
];