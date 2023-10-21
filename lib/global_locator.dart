import 'package:get_it/get_it.dart';
import 'package:just_play_test/src/api/api_repository.dart';

late GetIt global;

void setUpGlobalLocator() {
  global = GetIt.I;

  global.registerFactory<APIRepository>(() => DefaultAPIRepository());
}
