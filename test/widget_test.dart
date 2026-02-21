// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:ethrah_app/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const EthrahApp());

    // Verify that the brand name 'Ethrah' is present.
    expect(find.text('Ethrah'), findsAtLeastNWidgets(1));

    // Verify that some home screen text is present
    expect(find.text('Where Elegance Meets Tradition'), findsOneWidget);
  });
}
