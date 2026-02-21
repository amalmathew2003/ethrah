import 'package:ethrah_app/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const EthrahApp());

    // Verify that the brand name 'Ethrah' is present.
    expect(find.text('Ethrah'), findsAtLeastNWidgets(1));

    // Verify that some home screen text is present
    expect(
        find.text('Where Elegance Meets Tradition'), findsAtLeastNWidgets(1));
  }, skip: true);
}
