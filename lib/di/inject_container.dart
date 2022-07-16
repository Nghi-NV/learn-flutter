import 'package:get_it/get_it.dart';
import 'package:learn_flutter/core/api/dio_client.dart';
import 'package:learn_flutter/core/app_config/cubit/language_cubit.dart';
import 'package:learn_flutter/data/datasources/remote_datasource/login_remote_datasource.dart';
import 'package:learn_flutter/data/repositories/login_repository.dart';
import 'package:learn_flutter/model_views/login/cubit/login_cubit.dart';

GetIt sl = GetIt.instance;

class InjectContainer {
  Future init() async {
    sl.registerFactory<LanguageCubit>(() => LanguageCubit());

    sl.registerLazySingleton<LoginRemoteDataSource>(
        () => LoginRemoteDataSourceImpl(sl()));
    sl.registerLazySingleton<LoginRepository>(() => LoginRepositoryImpl(sl()));

    sl.registerFactory(() => LoginCubit(sl()));

    sl.registerLazySingleton(() => DioClient());
  }
}
