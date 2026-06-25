import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/opportunity_model.dart';

final opportunityProvider = Provider<List<Opportunity>>(
  (ref) => demoOpportunities,
);

final List<Opportunity> demoOpportunities = [
  Opportunity(
    id: "1",
    startupId: "startup_1",
    title: "Flutter Developer",
    startup: "EduBridge",
    category: "Software",
    duration: "8 Weeks",
    location: "Remote",
    description:
        "Build mobile applications using Flutter and Firebase.",
  ),
  Opportunity(
    id: "2",
    startupId: "startup_1",
    title: "UI/UX Research Volunteer",
    startup: "EduBridge",
    category: "Design",
    duration: "6 Weeks",
    location: "Hybrid",
    description:
        "Conduct user interviews and improve onboarding experiences.",
  ),
  Opportunity(
    id: "3",
    startupId: "startup_2",
    title: "Social Media Assistant",
    startup: "PanTree",
    category: "Marketing",
    duration: "4 Weeks",
    location: "Remote",
    description:
        "Create content and manage startup social media channels.",
  ),
];