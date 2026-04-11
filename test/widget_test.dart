import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitkarma/app.dart';

void main() {
  testWidgets('FitKarmaApp smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: const FitKarmaApp(),
      ),
    );
    await tester.pump();
    expect(find.byType(FitKarmaApp), findsOneWidget);
  });
}
