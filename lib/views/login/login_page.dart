import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_flutter/core/api/dio_client.dart';
import 'package:learn_flutter/core/app_config/cubit/language_cubit.dart';
import 'package:learn_flutter/core/generated/l10n.dart';
import 'package:learn_flutter/data/datasources/remote_datasource/login_remote_datasource.dart';
import 'package:learn_flutter/di/inject_container.dart';
import 'package:learn_flutter/model_views/login/cubit/login_cubit.dart';
import 'package:learn_flutter/models/login/login_model.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

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
}
