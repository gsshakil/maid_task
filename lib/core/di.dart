import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:maids_task/core/api/i_network_client.dart';
import 'package:maids_task/core/api/network_client.dart';
import 'package:maids_task/features/auth/data/data_sources/auth_data_source.dart';
import 'package:maids_task/features/auth/data/data_sources/i_auth_data_source.dart';
import 'package:maids_task/features/auth/data/repository/auth_repository.dart';
import 'package:maids_task/features/auth/domain/repository/i_auth_repository.dart';
import 'package:maids_task/features/auth/domain/use_cases/login_usecase.dart';
import 'package:maids_task/features/auth/presentation/blocs/auth_cubit/auth_cubit.dart';
import 'package:maids_task/features/user/data/data_sources/i_user_data_source.dart';
import 'package:maids_task/features/user/data/data_sources/user_data_source.dart';
import 'package:maids_task/features/user/data/repository/user_repository.dart';
import 'package:maids_task/features/user/domain/repository/i_user_repository.dart';
import 'package:maids_task/features/user/domain/use_cases/get_all_users_use_case.dart';
import 'package:maids_task/features/user/preentation/blocs/user_cubit/user_cubit.dart';

final injector = GetIt.instance;

Future<void> injectDependencies() async {
  injector.registerLazySingleton<Dio>(() => Dio());

  injector.registerLazySingleton<INetworkClient>(
      () => NetworkClient(dio: injector()));

  injector.registerLazySingleton<IUserDataSource>(
      () => UserDataSource(networkClient: injector()));

  injector.registerLazySingleton<IAuthDataSource>(
      () => AuthDataSource(networkClient: injector()));

  injector.registerLazySingleton<IUserRepository>(
      () => UserRepository(userDataSource: injector()));

  injector.registerLazySingleton<IAuthRepository>(
      () => AuthRepository(authDataSource: injector()));

  injector.registerLazySingleton<GetAllUsersUseCase>(
      () => GetAllUsersUseCase(userRepository: injector()));

  injector.registerLazySingleton<LoginUseCase>(
      () => LoginUseCase(authRepository: injector()));

  injector.registerLazySingleton<UserCubit>(
    () => UserCubit(getAllUsersUseCase: injector()),
  );

  injector.registerLazySingleton<AuthCubit>(
    () => AuthCubit(loginUseCase: injector()),
  );
}
