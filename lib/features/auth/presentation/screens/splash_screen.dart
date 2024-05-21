import 'package:flutter/material.dart';
import 'package:maids_task/core/common/common_package_assets.dart';
import 'package:maids_task/core/data/secure_storage.dart';
import 'package:maids_task/features/auth/presentation/screens/login_screen.dart';
import 'package:maids_task/features/task/presentation/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String token = '';
  @override
  void initState() {
    checkForToken();
    super.initState();
  }

  checkForToken() async {
    String tokenFromSs = await SecureStorage().getToken();
    setState(() {
      token = tokenFromSs;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(const Duration(milliseconds: 3000)),
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Splash();
        } else {
          if (token.isNotEmpty) {
            return const HomeScreen();
          } else {
            return const LoginScreen();
          }
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
