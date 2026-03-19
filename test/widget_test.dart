import 'package:flutter_test/flutter_test.dart';
import 'package:fitkarma/main.dart';

void main() {
  testWidgets('FitKarma smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that our app displays "FitKarma".
    expect(find.text('FitKarma'), findsOneWidget);
  });
}
