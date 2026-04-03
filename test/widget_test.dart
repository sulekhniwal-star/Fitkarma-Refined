import 'package:flutter_test/flutter_test.dart';

import 'package:fitkarma/app.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const FitKarmaApp());
    expect(find.text('FitKarma'), findsOneWidget);
  });
}
