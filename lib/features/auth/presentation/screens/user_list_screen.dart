import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maids_task/core/common/common_widgets/error_indicator.dart';
import 'package:maids_task/core/common/common_widgets/loading_indicator.dart';
import 'package:maids_task/core/di.dart';
import 'package:maids_task/features/auth/presentation/widgets/user_cedential_card.dart';
import 'package:maids_task/features/user/preentation/blocs/user_cubit/user_cubit.dart';

class UserListScreen extends StatelessWidget {
  const UserListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userCubit = injector<UserCubit>();

    return BlocProvider.value(
        value: userCubit,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Avaiable User Credentials'),
            centerTitle: true,
          ),
          body: BlocConsumer<UserCubit, UserState>(
            listener: (context, state) {
              if (state is UserError) {
                showAboutDialog(context: context, children: [
                  Text(
                    state.failure.toString(),
                  )
                ]);
              }
            },
            builder: (context, state) {
              if (state is UserLoading) {
                return const Center(child: LoadingIndicator());
              } else if (state is UserError) {
                return Center(
                  child: ErrorIndicator(
                    failure: state.failure,
                  ),
                );
              } else if (state is UserSuccess) {
                return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: state.users.users.length,
                    itemBuilder: (context, index) {
                      return UserCredentialCard(user: state.users.users[index]);
                    });
              } else {
                return const Center(child: LoadingIndicator());
              }
            },
          ),
        ));
  }
}

