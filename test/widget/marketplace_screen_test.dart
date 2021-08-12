import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../mocks/widget/mocked_marketplace_screen.dart';
import 'build_test_main.dart';

void main() async {
  setUp(() {});
  group('MarketPlaceScreen()', () {
    testWidgets('appbar displays app title', (WidgetTester tester) async {
      const widget = MockedMarketPlaceScreen();

      await tester.pumpWidget(buildTestMain(widget));

      expect(find.text('moostamil'), findsOneWidget);
      expect(find.byKey(const Key('floating_action_button')), findsOneWidget);
    });

    testWidgets('widget renders floatingActionButton()',
        (WidgetTester tester) async {
      const widget = MockedMarketPlaceScreen();

      await tester.pumpWidget(buildTestMain(widget));

      expect(find.byKey(const Key('floating_action_button')), findsOneWidget);
    });
  });
}
