import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:maids_task/core/common/common_widgets/error_indicator.dart';
import 'package:maids_task/core/common/common_widgets/loading_indicator.dart';
import 'package:maids_task/core/data/database.dart';
import 'package:maids_task/core/data/secure_storage.dart';
import 'package:maids_task/core/di.dart';
import 'package:maids_task/features/auth/presentation/blocs/auth_cubit/auth_cubit.dart';
import 'package:maids_task/features/auth/presentation/screens/login_screen.dart';
import 'package:maids_task/features/task/presentation/blocs/task_cubit/task_cubit.dart';
import 'package:maids_task/features/task/presentation/widgets/dialog_box.dart';
import 'package:maids_task/features/task/presentation/widgets/task_tile.dart';
import 'package:maids_task/features/user/preentation/blocs/user_cubit/user_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // reference the hive box
  final taskBox = Hive.box('taskbox');
  TaskDataBase db = TaskDataBase();

  TextEditingController controller = TextEditingController();

  final authCubit = injector<AuthCubit>();
  final taskCubut = injector<TaskCubit>();
  final userCubit = injector<UserCubit>();

  // checkbox was tapped
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.taskList[index][1] = !db.taskList[index][1];
    });
    db.updateDataBase();
  }

  // save new task
  void saveNewTask() {
    setState(() {
      db.taskList.add([controller.text, false]);
      controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDataBase();
    // Call API to dummy Json
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

  // delete task
  void deleteTask(int index) {
    setState(() {
      db.taskList.removeAt(index);
    });
    db.updateDataBase();
    // Call API to dummy Json
  }

  @override
  void initState() {
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
        BlocProvider.value(value: authCubit),
        BlocProvider.value(value: taskCubut),
        BlocProvider.value(value: userCubit..getCurrentUser()),
      ],
      child: BlocListener<UserCubit, UserState>(
        listener: (context, state) {
          if (state is CurrentUserSuccess) {
            if (taskBox.get("TASKLIST") == null) {
              int? userId = state.user.id;
              taskCubut.getTasks(userId: userId);
            } else {
              // there already exists data
              db.loadData();
            }
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Task Manager'),
            centerTitle: true,
            actions: [
              TextButton(
                  onPressed: () {
                    SecureStorage().removeToken();
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (conext) => const LoginScreen()),
                      (route) => false,
                    );
                  },
                  child: const Text('Log Out'))
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: createNewTask,
            child: const Icon(Icons.add),
          ),
          body: BlocConsumer<TaskCubit, TaskState>(
            listener: (context, state) {
              if (state is TaskSuccess) {
                db.taskList.addAll(state.tasks.todos);
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
                return taskCubut.items.isEmpty
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
                            taskName: db.taskList[index].todo,
                            taskCompleted: db.taskList[index].completed,
                            onChanged: (value) {},
                            deleteFunction: (value) {},
                          );
                        },
                      );
              }
            },
          ),
        ),
      ),
    );
  }
}
