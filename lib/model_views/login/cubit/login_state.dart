part of 'login_cubit.dart';

@freezed
class LoginState with _$LoginState {
  const factory LoginState.initial() = LoginStateInitial;
  const factory LoginState.loading() = LoginStateLoading;
  const factory LoginState.loaded(LoginEntity loginEntity) = LoginStateLoaded;
  const factory LoginState.error(Failure failure) = LoginStateError;
  const factory LoginState.validationError(List<ValidationField> validations) =
      LoginStateValidationError;
  const factory LoginState.changeParams(LoginParams params) =
      LoginStateChangeParams;
}
