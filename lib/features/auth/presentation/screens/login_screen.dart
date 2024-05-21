import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maids_task/core/common/common_package_assets.dart';
import 'package:maids_task/core/common/common_widgets/error_indicator.dart';
import 'package:maids_task/core/common/common_widgets/forms/bp_password_field.dart';
import 'package:maids_task/core/common/common_widgets/forms/bp_primary_button.dart';
import 'package:maids_task/core/common/common_widgets/forms/bp_text_button.dart';
import 'package:maids_task/core/common/common_widgets/forms/bp_text_field.dart';
import 'package:maids_task/core/di.dart';
import 'package:maids_task/features/auth/presentation/screens/user_list_screen.dart';
import 'package:maids_task/features/user/preentation/blocs/user_cubit/user_cubit.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController userNamelController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final userCubit = injector<UserCubit>();

  @override
  void dispose() {
    userNamelController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: userCubit..getAllUsers(),
      child: Scaffold(
        body: BlocConsumer<UserCubit, UserState>(
          listener: (context, state) {
            if (state is UserError) {
              showAboutDialog(
                context: context,
                children: [
                  ErrorIndicator(failure: state.failure),
                ],
              );
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 100,
                    width: 100,
                    child: Image.asset(CommonPackageAssets.logo),
                  ),
                  const Text(
                    'Login',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  BlueprintTextField(
                    controller: userNamelController,
                    label: 'User Name',
                  ),
                  const SizedBox(height: 15),
                  BlueprintPasswordField(
                    controller: passwordController,
                    label: 'Password',
                  ),
                  const SizedBox(height: 30),
                  BlueprintPrimaryButton(
                      title: 'Login',
                      onPressed: () {
                        userCubit.getAllUsers();
                      }),
                  const SizedBox(height: 20),
                  BlueprintTextButton(
                    title: 'See Available Credentials',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const UserListScreen(),
                        ),
                      );
                    },
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
