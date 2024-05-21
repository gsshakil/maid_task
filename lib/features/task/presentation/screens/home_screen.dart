import 'package:flutter/material.dart';
import 'package:maids_task/features/task/presentation/widgets/dialog_box.dart';
import 'package:maids_task/features/task/presentation/widgets/task_tile.dart';

class HomeSCreen extends StatefulWidget {
  const HomeSCreen({super.key});

  @override
  State<HomeSCreen> createState() => _HomeSCreenState();
}

class _HomeSCreenState extends State<HomeSCreen> {

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
                //TODO: logout
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

  void saveNewTask() {
  }
}
