import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../models/application_model.dart';

final applicationProvider = StateNotifierProvider<ApplicationNotifier, List<ApplicationModel>>(
  (ref) => ApplicationNotifier(),
);

class ApplicationNotifier extends StateNotifier<List<ApplicationModel>> {
  ApplicationNotifier() : super([]);

  void apply(String opportunityId) {
    
    if (state.any((app) => app.opportunityId == opportunityId)) {
      return;
    }

    state = [
      ...state,
      ApplicationModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        opportunityId: opportunityId,
        studentId: "demo_student",
        status: "Applied",
      ),
    ];
  }

  
  void updateStatus(String applicationId, String newStatus) {
    state = state.map((app) {
      if (app.id == applicationId) {
        return ApplicationModel(
          id: app.id,
          opportunityId: app.opportunityId,
          studentId: app.studentId,
          status: newStatus,
        );
      }
      return app;
    }).toList();
  }
}