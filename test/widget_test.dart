import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:prototipo/main.dart';
import 'package:prototipo/providers/curae_provider.dart';

void main() {
  testWidgets('CuraeApp smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => CuraeProvider(),
        child: const CuraeApp(),
      ),
    );

    expect(find.text('curae'), findsOneWidget);
  });
}
