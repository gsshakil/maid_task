import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:maids_task/core/api/i_network_client.dart';
import 'package:maids_task/core/api/network_client.dart';
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

  injector.registerLazySingleton<IUserRepository>(
      () => UserRepository(userDataSource: injector()));

  injector.registerLazySingleton<GetAllUsersUseCase>(
      () => GetAllUsersUseCase(userRepository: injector()));

  injector.registerLazySingleton<UserCubit>(
    () => UserCubit(
      getAllUsersUseCase: injector(),
    ),
  );
}
