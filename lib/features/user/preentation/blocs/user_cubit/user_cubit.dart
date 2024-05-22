import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:maids_task/core/api/failure.dart';
import 'package:maids_task/features/user/data/models/user_list_model.dart';
import 'package:maids_task/features/user/data/models/user_model.dart';
import 'package:maids_task/features/user/domain/use_cases/get_all_users_use_case.dart';
import 'package:maids_task/features/user/domain/use_cases/get_current_user_usecase.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final GetAllUsersUseCase getAllUsersUseCase;
  final GetCurrentUserUseCase getCurrentUserUseCase;
  UserCubit({
    required this.getAllUsersUseCase,
    required this.getCurrentUserUseCase,
  }) : super(UserInitial());

  int? currentUserId;

  void getAllUsers() async {
    emit(UserLoading());
    Either<Failure, UserListModel> userList = await getAllUsersUseCase();
    userList.fold((l) => emit(UserError(failure: l)), (r) {
      emit(UserSuccess(users: r));
    });
  }

  void getCurrentUser() async {
    emit(UserLoading());
    Either<Failure, UserModel> userList = await getCurrentUserUseCase();
    userList.fold((l) => emit(UserError(failure: l)), (r) {
      currentUserId = r.id;
      emit(CurrentUserSuccess(user: r));
    });
  }
}
