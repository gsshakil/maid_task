import 'package:maids_task/features/user/data/models/user_model.dart';

abstract class IAuthDataSource{
  Future<UserModel> login({required String username, required String password});
}