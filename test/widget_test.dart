import 'package:flutter_test/flutter_test.dart';
import 'package:mashhad/main.dart';

void main() {
  testWidgets('shows Arabic app title', (tester) async {
    await tester.pumpWidget(const MashhadApp());
    expect(find.text('مشهد'), findsWidgets);
  });
}
