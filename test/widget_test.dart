import 'package:flutter_test/flutter_test.dart';
import 'package:fitkarma/app.dart';

void main() {
  testWidgets('FitKarmaApp renders without crashing', (WidgetTester tester) async {
    await tester.pumpWidget(const FitKarmaApp());
    expect(find.text('Namaste FitKarma 🙏'), findsOneWidget);
  });
}
