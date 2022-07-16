import 'package:learn_flutter/core/api/dio_client.dart';
import 'package:learn_flutter/core/api/utils.dart';
import 'package:learn_flutter/models/login/login_model.dart';

abstract class LoginRemoteDataSource {
  Future login(LoginParams params);
}

class LoginRemoteDataSourceImpl implements LoginRemoteDataSource {
  final DioClient dioClient;

  LoginRemoteDataSourceImpl(this.dioClient);

  @override
  Future login(LoginParams params) async {
    return dioClient.dio.post(ApiPaths.login, data: params.toJson());
  }
}
