import 'package:hive_flutter/hive_flutter.dart';

class TaskDataBase {
  List taskList = [];

  // reference our box
  final _taskBox = Hive.box('taskbox');

  // load the data from database
  void loadData() {
    var taskListFromHive = _taskBox.get("TASKLIST");
    if (taskListFromHive != null) {
      taskList = taskListFromHive;
    } else {
      taskList = [];
    }
  }

  // update the database
  void updateDataBase() {
    _taskBox.put("TASKLIST", taskList);
  }
}
