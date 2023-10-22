import 'package:just_play_test/src/api/endpoint.dart';
import 'package:just_play_test/src/services/local_storage.dart';

class GetTokenEndpoint extends Endpoint {
  GetTokenEndpoint();

  @override
  Method get method => Method.get;

  @override
  Map<String, String> get headers => {
        'api-token': const String.fromEnvironment('api-token'),
        'user-email': const String.fromEnvironment('user-email'),
      };

  @override
  String get path => 'api/getaccesstoken';
}

class GetCitiesEndpoint extends Endpoint {
  GetCitiesEndpoint();
  final token = LocalStorage().apiToken;

  @override
  Method get method => Method.get;

  @override
  Map<String, String> get headers => {
        'Authorization': 'Bearer $token',
      };

  @override
  String get path => 'api/states/Germany';
}
