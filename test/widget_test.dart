import 'package:flutter_test/flutter_test.dart';

import 'package:fitkarma/main.dart';

void main() {
  testWidgets('App renders without errors', (WidgetTester tester) async {
    await tester.pumpWidget(const FitkarmaApp());

    expect(find.text('Fitkarma'), findsOneWidget);
  });
}
