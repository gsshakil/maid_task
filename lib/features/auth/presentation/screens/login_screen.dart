import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maids_task/core/common/common_package_assets.dart';
import 'package:maids_task/core/common/common_widgets/forms/bp_password_field.dart';
import 'package:maids_task/core/common/common_widgets/forms/bp_primary_button.dart';
import 'package:maids_task/core/common/common_widgets/forms/bp_text_button.dart';
import 'package:maids_task/core/common/common_widgets/forms/bp_text_field.dart';
import 'package:maids_task/core/di.dart';
import 'package:maids_task/features/auth/presentation/blocs/auth_cubit/auth_cubit.dart';
import 'package:maids_task/features/auth/presentation/screens/user_list_screen.dart';
import 'package:maids_task/features/task/presentation/screens/home_screen.dart';
import 'package:maids_task/features/user/preentation/blocs/user_cubit/user_cubit.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController userNamelController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  final userCubit = injector<UserCubit>();
  final authCubit = injector<AuthCubit>();

  @override
  void dispose() {
    userNamelController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: userCubit..getAllUsers()),
        BlocProvider.value(value: authCubit),
      ],
      child: Scaffold(
        body: BlocConsumer<UserCubit, UserState>(
          listener: (context, userState) {
            if (userState is UserError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(userState.failure.toString())),
              );
            } else if (userState is UserSuccess) {}
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
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
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    _loginForm(),
                    const SizedBox(height: 20),
                    BlueprintTextButton(
                      title: 'See Available Credentials',
                      isLoading: state is AuthLoading,
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
              ),
            );
          },
        ),
      ),
    );
  }

  BlocConsumer<AuthCubit, AuthState> _loginForm() {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, authState) {
        if (authState is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(authState.failure.toString())),
          );
        } else if (authState is AuthSuccess) {
          if (authState.user.message.isNotEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(authState.user.message)),
            );
          } else {
            // forward to home screen
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (conext) => const HomeScreen()),
              (route) => false,
            );
          }
        }
      },
      builder: (context, authState) {
        return Form(
          key: formKey,
          child: Column(
            children: [
              BlueprintTextField(
                key: const Key("username"),
                controller: userNamelController,
                label: 'User Name',
                inputAction: TextInputAction.newline,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This value can\'t be empty';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              BlueprintPasswordField(
                key: const Key("password"),
                controller: passwordController,
                label: 'Password',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This value can\'t be empty';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
              BlueprintPrimaryButton(
                  key: const Key("loginButton"),
                  title: 'Login',
                  isLoading: authState is AuthLoading,
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      authCubit.login(
                        username: userNamelController.text.trim(),
                        password: passwordController.text.trim(),
                      );
                    }
                  }),
            ],
          ),
        );
      },
    );
  }
}
