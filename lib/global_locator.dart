import 'package:get_it/get_it.dart';

import 'package:logger/logger.dart';
import 'package:nucleo_ods/src/api/api_repository.dart';
import 'package:nucleo_ods/src/bloc/auth/auth_bloc.dart';
import 'package:nucleo_ods/src/bloc/checks/checks_bloc.dart';
import 'package:nucleo_ods/src/bloc/metrics/metrics_bloc.dart';
import 'package:nucleo_ods/src/repository/checks/check_repository.dart';
import 'package:nucleo_ods/src/repository/daily/daily_repository.dart';
import 'package:nucleo_ods/src/repository/login/auth_repository.dart';
import 'package:nucleo_ods/src/repository/upload_file/upload_file.dart';

import 'src/repository/metrics/metrics_endpoint.dart';

late GetIt global;

void setUpGlobalLocator() {
  global = GetIt.I;

  global.registerLazySingleton(() => Logger());
  global.registerFactory<APIRepository>(() => DefaultAPIRepository());
  global.registerFactory<AuthRepository>(() => AuthDefault());
  global.registerLazySingleton<AuthBloc>(() => AuthBloc());
  global.registerLazySingleton<ChecksBloc>(() => ChecksBloc());
  global.registerLazySingleton<MetricsBloc>(() => MetricsBloc());
  global.registerFactory<DailyRepository>(() => DailyDefault());
  global.registerFactory<MetricsRepository>(() => MetricsRepositoryDefault());
  global.registerFactory<UploadFileRepository>(
      () => UploadFileRepositoryDefault());
  global.registerFactory<CheckRepository>(() => CheckDefault());
}
