import 'package:just_play_test/global_locator.dart';
import 'package:just_play_test/src/api/api_repository.dart';
import 'package:just_play_test/src/repository/cities/endpoint/cities.dart';

abstract class CitiesRepository {
  Future<Map<String, dynamic>> getToken();
  Future<Map<String, dynamic>> getCities();
}

class CitiesDefault extends CitiesRepository {
  final _api = global<APIRepository>();

  @override
  Future<Map<String, dynamic>> getCities() async {
    var endpoint = GetCitiesEndpoint();
    final response = await _api.request(endpoint: endpoint);
    return response;
  }

  @override
  Future<Map<String, dynamic>> getToken() async {
    var endpoint = GetTokenEndpoint();
    final response = await _api.request(endpoint: endpoint);
    return response;
  }
}
