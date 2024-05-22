import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:maids_task/core/common/common_widgets/error_indicator.dart';
import 'package:maids_task/core/common/common_widgets/loading_indicator.dart';
import 'package:maids_task/core/data/database.dart';
import 'package:maids_task/core/data/secure_storage.dart';
import 'package:maids_task/core/di.dart';
import 'package:maids_task/features/auth/presentation/screens/login_screen.dart';
import 'package:maids_task/features/task/presentation/blocs/task_cubit/task_cubit.dart';
import 'package:maids_task/features/task/presentation/blocs/task_modify_cubit/task_modify_cubit.dart';
import 'package:maids_task/features/task/presentation/widgets/dialog_box.dart';
import 'package:maids_task/features/task/presentation/widgets/task_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int? _userId;
  // reference the hive box
  final taskBox = Hive.box('taskbox');
  TaskDataBase db = TaskDataBase();

  TextEditingController controller = TextEditingController();

  final taskCubut = injector<TaskCubit>();
  final taskModifyCubit = injector<TaskModifyCubit>();

  loadTaskData() {
    // load data for first time
    if (taskBox.get("TASKLIST") == null) {
      taskCubut.getTasks(userId: _userId ?? 0);
    } else {
      //there already exists data
      db.loadData();
    }
  }

  // checkbox was tapped
  void checkBoxChanged(bool? value, int index, int? id) {
    setState(() {
      db.taskList[index][1] = !db.taskList[index][1];
    });
    db.updateDataBase();
    // Call Update Api
    taskModifyCubit.updateTaskUseCase(value: value ?? false, id: id ?? 0);
  }

// create a new task
  void createNewTask() {
    showDialog(
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

  // save new task
  void saveNewTask() {
    setState(() {
      db.taskList.add([
        controller.text,
        false,
        _userId ?? 0,
        0,
      ]);
      controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDataBase();
    // Call API to dummy Json
    taskModifyCubit.addNewTask(
      task: controller.text,
      completed: false,
      userId: _userId ?? 0,
    );
  }

  // delete task
  void deleteTask(int index, int? id) {
    setState(() {
      db.taskList.removeAt(index);
    });
    db.updateDataBase();
    // Call API to dummy Json
    taskModifyCubit.deleteTask(id: id ?? 0);
  }

  saveUserId() async {
    String userIdFromStorage = await SecureStorage().getUserId();
    int userId = int.parse(userIdFromStorage);
    setState(() {
      _userId = userId;
    });
  }

  @override
  void initState() {
    saveUserId();
    loadTaskData();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: taskCubut),
        BlocProvider.value(value: taskModifyCubit),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Task Manager'),
          centerTitle: true,
          actions: [
            TextButton(
              onPressed: () {
                SecureStorage().removeToken();
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (conext) => const LoginScreen()),
                    (route) => false);
              },
              child: const Text('Log Out'),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: createNewTask,
          child: const Icon(Icons.add),
        ),
        body: BlocConsumer<TaskCubit, TaskState>(
          listener: (context, state) {
            if (state is TaskSuccess) {
              var taskList = state.tasks.todos
                  .map((item) => [
                        item.todo,
                        item.completed,
                        item.userId,
                        item.id,
                      ])
                  .toList();
              db.taskList.addAll(taskList);
              db.updateDataBase();
            }
          },
          builder: (context, state) {
            if (state is TaskLoading) {
              return const Center(child: LoadingIndicator());
            } else if (state is TaskError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ErrorIndicator(
                    failure: state.failure,
                  ),
                ),
              );
            } else {
              return db.taskList.isEmpty
                  ? const Center(
                      child: Text('No Item Found'),
                    )
                  : ListView.builder(
                      controller: taskCubut.scrollController,
                      itemCount: db.taskList.length,
                      itemBuilder: (context, index) {
                        // show loading indicator if more posts are loading
                        if (state is TaskMoreLoading) {
                          if ((index == db.taskList.length - 1) &&
                              db.taskList.length <
                                  taskCubut.taskListEntity.total) {
                            return Center(
                              child: Container(
                                  padding: const EdgeInsets.all(20),
                                  height: 75,
                                  width: 75,
                                  child: const LoadingIndicator()),
                            );
                          }
                        }
                        return TaskTile(
                          taskName: db.taskList[index][0],
                          taskCompleted: db.taskList[index][1],
                          onChanged: (value) => checkBoxChanged(
                            value,
                            index,
                            db.taskList[index][2],
                          ),
                          deleteFunction: (value) => deleteTask(
                            index,
                            db.taskList[index][2],
                          ),
                        );
                      },
                    );
            }
          },
        ),
      ),
    );
  }
}
