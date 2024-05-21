import 'package:flutter/material.dart';
import 'package:maids_task/core/common/common_package_assets.dart';
import 'package:maids_task/features/auth/presentation/screens/login_screen.dart';
import 'package:maids_task/features/task/presentation/screens/home_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(const Duration(milliseconds: 1000)),
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // TODO: check for user authentication Creedential
          // TODO: load the todos from api and store on hive if hive box is empty
          return const Splash();
        } else {
          return const LoginScreen();
        }
      }),
    );
  }
}

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
            height: 100,
            width: 100,
            child: Image.asset(CommonPackageAssets.logo)),
      ),
    );
  }
}
