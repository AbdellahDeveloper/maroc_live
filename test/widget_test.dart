import 'package:flutter_test/flutter_test.dart';
import 'package:maroc_live/main.dart';

void main() {
  testWidgets('App renders home screen', (WidgetTester tester) async {
    await tester.pumpWidget(const MarocLiveApp());

    // Verify the title is displayed
    expect(find.text('Maroc Live'), findsOneWidget);
  });
}
