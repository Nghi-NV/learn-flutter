import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:learn_flutter/core/error/failures.dart';
import 'package:learn_flutter/data/repositories/login_repository.dart';
import 'package:learn_flutter/models/login/login_model.dart';

part 'login_state.dart';
part 'login_cubit.freezed.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginRepository loginRepository;

  LoginCubit(this.loginRepository) : super(const LoginState.initial());

  void login(LoginParams params) async {
    emit(const LoginState.loading());
    final response = await loginRepository.login(params);

    response.fold((error) {
      emit(LoginState.error(error));
    }, (data) {
      emit(LoginState.loaded(data));
    });
  }
}
