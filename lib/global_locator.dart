import 'package:get_it/get_it.dart';
import 'package:just_play_test/src/api/api_repository.dart';
import 'package:just_play_test/src/bloc/auth/auth_bloc.dart';
import 'package:just_play_test/src/bloc/cities/cities_bloc.dart';
import 'package:just_play_test/src/repository/cities/cities_repository.dart';

late GetIt global;

void setUpGlobalLocator() {
  global = GetIt.I;

  global.registerFactory<APIRepository>(() => DefaultAPIRepository());
  global.registerFactory<CitiesRepository>(() => CitiesDefault());

  global.registerLazySingleton<AuthBloc>(() => AuthBloc());
  global.registerLazySingleton<CitiesBloc>(() => CitiesBloc());
}
