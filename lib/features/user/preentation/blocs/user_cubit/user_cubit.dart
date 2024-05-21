import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:maids_task/core/api/failure.dart';
import 'package:maids_task/features/user/data/models/user_list_model.dart';
import 'package:maids_task/features/user/domain/use_cases/get_all_users_use_case.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final GetAllUsersUseCase getAllUsersUseCase;
  UserCubit({
    required this.getAllUsersUseCase,
  }) : super(UserInitial());

  void getAllUsers()async {
    emit(UserLoading());
    Either<Failure, UserListModel> userList = await getAllUsersUseCase();
    userList.fold((l) => emit(UserError(failure: l)), (r) {
      emit(UserSuccess(users: r));
    });
  }
}
