enum Method { get }

abstract class Endpoint {
  String get path;

  Method get method;

  Map<String, dynamic> queryParameters = {};

  Map<String, String> headers = {};

  Map<String, dynamic> body = {};

  Endpoint();
}
