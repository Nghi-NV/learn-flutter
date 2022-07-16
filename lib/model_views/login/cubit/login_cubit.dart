import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:learn_flutter/core/error/failures.dart';
import 'package:learn_flutter/core/error/validation_field.dart';
import 'package:learn_flutter/data/repositories/login_repository.dart';
import 'package:learn_flutter/models/login/login_model.dart';

part 'login_state.dart';
part 'login_cubit.freezed.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginRepository loginRepository;

  LoginCubit(this.loginRepository) : super(const LoginState.initial());

  void onChangeParams(LoginParams params) {
    final errors = validationParams(params);

    emit(LoginState.validationError(errors));
  }

  void login(LoginParams params) async {
    emit(const LoginState.loading());
    final response = await loginRepository.login(params);

    response.fold((error) {
      emit(LoginState.error(error));
    }, (data) {
      emit(LoginState.loaded(data));
    });
  }

  List<ValidationField> validationParams(LoginParams params) {
    final validations = <ValidationField>[];

    if (params.email.isEmpty) {
      validations.add(ValidationField('email', 'Email is required'));
    }
    if (params.password.isEmpty) {
      validations.add(ValidationField('password', 'Password is required'));
    }

    if (params.password.length < 6) {
      validations.add(ValidationField(
          'passwordLength', 'Password must be at least 6 characters'));
    }

    if (!params.password.contains(RegExp(r'[A-Z]'))) {
      validations.add(ValidationField('passwordUpperCase',
          'Password must contain at least one uppercase letter'));
    }

    if (!params.password.contains(RegExp(r'[0-9]'))) {
      validations.add(ValidationField(
          'passwordNumber', 'Password must contain at least one number'));
    }

    if (!params.password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      validations.add(ValidationField('passwordSpecial',
          'Password must contain at least one special character'));
    }

    if (!params.password.contains(RegExp(r'[a-z]'))) {
      validations.add(ValidationField('passwordLowerCase',
          'Password must contain at least one lowercase letter'));
    }

    return validations;
  }
}
