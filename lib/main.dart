import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/storage/drift_service.dart';
import 'core/di/providers.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Local Database with encryption
  await DriftService.init();

  runApp(
    ProviderScope(
      overrides: [
        driftDbProvider.overrideWithValue(DriftService.db),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FitKarma',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.deepPurple,
      ),
      home: const Scaffold(
        body: Center(
          child: Text('FitKarma - Clean Start'),
        ),
      ),
    );
  }
}
