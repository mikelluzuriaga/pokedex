import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const ProviderScope(child: MyApp()));

    // Verify that our app starts with the Pokedex page.
    expect(find.text('Pokedex'), findsOneWidget);

    // TODO: Add more specific tests for your Pokedex app functionality
  });
}
