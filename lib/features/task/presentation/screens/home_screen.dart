import 'package:flutter/material.dart';
import 'package:maids_task/core/data/secure_storage.dart';
import 'package:maids_task/features/auth/presentation/screens/login_screen.dart';
import 'package:maids_task/features/task/presentation/widgets/dialog_box.dart';
import 'package:maids_task/features/task/presentation/widgets/task_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Manager'),
        centerTitle: true,
        actions: [
          TextButton(
              onPressed: () {
                SecureStorage().removeToken();
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (conext) => const LoginScreen()),
                  (route) => false,
                );
              },
              child: const Text('Log Out'))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          createNewTask(context);
        },
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: 4,
        itemBuilder: (context, index) {
          return TaskTile(
            taskName: 'Abc',
            taskCompleted: false,
            onChanged: (value) {},
            deleteFunction: (value) {},
          );
        },
      ),
    );
  }

  Future<dynamic> createNewTask(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: controller,
          onSave: saveNewTask,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  void saveNewTask() {}
}
