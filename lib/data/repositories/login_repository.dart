import 'package:dartz/dartz.dart';
import 'package:learn_flutter/core/error/failures.dart';
import 'package:learn_flutter/data/datasources/remote_datasource/login_remote_datasource.dart';
import 'package:learn_flutter/models/login/login_model.dart';

abstract class LoginRepository {
  Future<Either<Failure, LoginEntity>> login(LoginParams params);
}

class LoginRepositoryImpl implements LoginRepository {
  final LoginRemoteDataSource remoteDataSource;

  LoginRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, LoginEntity>> login(LoginParams params) async {
    try {
      final response = await remoteDataSource.login(params);
      final loginEntity = LoginEntity.fromJson(response.data);
      return Right(loginEntity);
    } catch (error) {
      return Left(ServerFailure());
    }
  }
}
