import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:maids_task/core/api/failure.dart';
import 'package:maids_task/core/data/secure_storage.dart';
import 'package:maids_task/features/auth/domain/use_cases/login_usecase.dart';
import 'package:maids_task/features/user/data/models/user_model.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginUseCase loginUseCase;

  AuthCubit({required this.loginUseCase}) : super(AuthInitial());

  void login({
    required String username,
    required String password,
  }) async {
    emit(AuthLoading());
    Either<Failure, UserModel> user = await loginUseCase(
      username: username,
      password: password,
    );
    user.fold((l) => emit(AuthError(failure: l)), (r) {
      // Save token in  storage
      SecureStorage().saveToken(r.token);
      // save user id is storage
      SecureStorage().saveUserId(r.id);

      emit(AuthSuccess(user: r));
    });
  }
}
