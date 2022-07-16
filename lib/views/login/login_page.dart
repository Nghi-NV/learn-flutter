import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_flutter/core/app_config/cubit/language_cubit.dart';
import 'package:learn_flutter/core/error/validation_field.dart';
import 'package:learn_flutter/core/generated/l10n.dart';
import 'package:learn_flutter/model_views/login/cubit/login_cubit.dart';
import 'package:learn_flutter/models/login/login_model.dart';
import 'package:learn_flutter/views/login/widgets/check_validation.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();

    _emailController.addListener(() {
      BlocProvider.of<LoginCubit>(context).onChangeParams(
        LoginParams(
          email: _emailController.text,
          password: _passwordController.text,
        ),
      );
    });

    _passwordController.addListener(() {
      BlocProvider.of<LoginCubit>(context).onChangeParams(
        LoginParams(
          email: _emailController.text,
          password: _passwordController.text,
        ),
      );
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(builder: (context, state) {
      final languageCubit = context.watch<LanguageCubit>();

      print("state: $state");
      return Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).login),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (state is LoginStateLoading) ...[
                const Center(child: CircularProgressIndicator()),
                const SizedBox(height: 16.0),
              ],
              Text("Current language: ${languageCubit.state.language}"),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  context.read<LanguageCubit>().changeLanguage('en');
                },
                child: const Text("Change Languages to English"),
              ),
              ElevatedButton(
                onPressed: () {
                  BlocProvider.of<LanguageCubit>(context).changeLanguage('vi');
                },
                child: const Text("Change Languages to Vietnamese"),
              ),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: "Email",
                ),
              ),
              const SizedBox(height: 4.0),
              validationEmail(),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: "Password",
                ),
              ),
              const SizedBox(height: 4.0),
              validationPassword(),
              ElevatedButton(
                onPressed: () {
                  final loginCubit = context.read<LoginCubit>();
                  loginCubit.login(LoginParams(
                    email: "eve.holt@reqres.in",
                    password: "cityslicka",
                  ));
                },
                child: const Text("Login"),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget validationEmail() {
    return BlocBuilder<LoginCubit, LoginState>(builder: (context, state) {
      if (state is LoginStateValidationError) {
        final List<ValidationField> errors = state.validations;
        final errorEmail = errors.where((error) => error.field == 'email');
        if (errorEmail.isNotEmpty) {
          return Text(
            errorEmail.first.message,
            style: const TextStyle(color: Colors.red),
          );
        }
      }
      return Container();
    });
  }

  Widget validationPassword() {
    return BlocBuilder<LoginCubit, LoginState>(builder: (context, state) {
      if (state is LoginStateValidationError) {
        final List<ValidationField> errors = state.validations;
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CheckValidation(
              title: "Password is required",
              isValid:
                  errors.where((error) => error.field == 'password').isEmpty,
            ),
            CheckValidation(
              title: "Password must be at least 6 characters",
              isValid: errors
                  .where((error) => error.field == 'passwordLength')
                  .isEmpty,
            ),
            CheckValidation(
              title: "Password must contain at least one uppercase letter",
              isValid: errors
                  .where((error) => error.field == 'passwordUpperCase')
                  .isEmpty,
            ),
            CheckValidation(
              title: "Password must contain at least one lowercase letter",
              isValid: errors
                  .where((error) => error.field == 'passwordLowerCase')
                  .isEmpty,
            ),
            CheckValidation(
              title: "Password must contain at least one number",
              isValid: errors
                  .where((error) => error.field == 'passwordNumber')
                  .isEmpty,
            ),
            CheckValidation(
              title: "Password must contain at least one special character",
              isValid: errors
                  .where((error) => error.field == 'passwordSpecial')
                  .isEmpty,
            ),
          ],
        );
      }
      return Container();
    });
  }
}
