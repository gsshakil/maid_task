import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:maids_task/core/di.dart';
import 'package:maids_task/features/auth/presentation/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await injectDependencies();
  // init the hive
  await Hive.initFlutter();
  // open a box
  var box = await Hive.openBox('taskbox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Maids Task',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
