import 'package:flutter_test/flutter_test.dart';

import 'package:mecanosaurus_app/main.dart';

void main() {
  testWidgets('Control panel renders key widgets', (WidgetTester tester) async {
    await tester.pumpWidget(const MecanosaurusApp());

    expect(find.text('Mecanosaurus - Control Panel'), findsOneWidget);
    expect(find.text('Joystick area'), findsOneWidget);
    expect(find.text('Connect'), findsOneWidget);
  });
}
