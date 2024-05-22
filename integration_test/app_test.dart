import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:maids_task/features/auth/presentation/screens/login_screen.dart';
import 'package:maids_task/features/auth/presentation/screens/splash_screen.dart';
import 'package:maids_task/features/task/presentation/screens/home_screen.dart';

import 'package:maids_task/main.dart' as app;

main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end to end testing', () {
    testWidgets('verify login screen with correct username and password',
        (tester) async {
      app.main();
      await tester.pumpAndSettle();
      expect(find.byType(SplashScreen), findsOneWidget);
      await Future.delayed(const Duration(seconds: 5));
      await tester.pumpAndSettle();
      await Future.delayed(const Duration(seconds: 2));
      expect(find.byType(LoginScreen), findsOneWidget);

      await Future.delayed(const Duration(seconds: 2));
      final userNameTextField = find.byKey(const Key("username"));
      final passwordTextField = find.byKey(const Key("password"));
      final loginButton = find.byKey(const Key("loginButton"));

      expect(userNameTextField, findsOneWidget);
      expect(passwordTextField, findsOneWidget);
      expect(loginButton, findsOneWidget);

      await tester.enterText(userNameTextField, 'atuny0');
      await Future.delayed(const Duration(seconds: 2));
      await tester.enterText(passwordTextField, '9uQFF1Lh');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();
      await Future.delayed(const Duration(seconds: 2));
      await tester.tap(loginButton);
      await tester.pumpAndSettle();

      await Future.delayed(const Duration(seconds: 10));
      expect(find.byType(HomeScreen), findsOneWidget);
      await Future.delayed(const Duration(seconds: 2));
      await tester.pumpAndSettle();
    });
  });
}
