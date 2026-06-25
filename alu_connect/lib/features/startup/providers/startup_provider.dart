import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/startup_model.dart';

final startupProvider =
    StateNotifierProvider<StartupNotifier, List<Startup>>(
  (ref) => StartupNotifier(),
);

class StartupNotifier extends StateNotifier<List<Startup>> {
  StartupNotifier()
      : super([
          Startup(
            id: "1",
            name: "EduBridge",
            founder: "Amina",
            description:
                "Connecting students with mentors.",
            verified: true,
          ),
        ]);

  void addStartup(Startup startup) {
    state = [...state, startup];
  }
}