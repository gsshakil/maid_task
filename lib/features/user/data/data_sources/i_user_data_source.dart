 import 'package:maids_task/features/user/data/models/user_list_model.dart';

abstract class IUserDataSource{
  Future<UserListModel> getAllUsers();
}