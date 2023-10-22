import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:logger/logger.dart';

import '../utils/lang/type_safety.dart';
import 'endpoint.dart';

enum Protocol { http, https }

abstract class APIRepository {
  Future<Map<String, dynamic>> request({required Endpoint endpoint});
}

class DefaultAPIRepository implements APIRepository {
  final _logger = Logger();

  @override
  Future<Map<String, dynamic>> request({required Endpoint endpoint}) async {
    _logger.d('Request endpoint: ${endpoint.body}');
    Uri url;
    try {
      if (const String.fromEnvironment('protocol') == Protocol.https.name) {
        url = Uri.https(
          const String.fromEnvironment('apiUrl'),
          endpoint.path,
          endpoint.queryParameters,
        );
      } else {
        url = Uri.http(
          const String.fromEnvironment('apiUrl'),
          endpoint.path,
          endpoint.queryParameters,
        );
      }
    } catch (e) {
      _logger.e('APIRepository - Error parse uri$e ');
      Exception('Error parse uri $e');
      return {};
    }

    var headers = {
      HttpHeaders.acceptHeader: '*/*',
      HttpHeaders.contentTypeHeader: 'application/json',
    };
    headers.addAll(endpoint.headers);
    try {
      final result = await requestDistributor(endpoint, url, headers);
      return _handleResponse(result);
    } catch (e) {
      return _handlerError(e);
    }
  }

  Future<Response> requestDistributor(
    Endpoint endpoint,
    Uri url,
    Map<String, String> headers,
  ) async {
    switch (endpoint.method) {
      case Method.get:
        return _get(url, headers);
    }
  }

  Future<Response> _get(Uri url, Map<String, String> headers) {
    _logger.d('get() with url ($url) - headers ($headers)');
    return http.get(url, headers: headers);
  }

  Map<String, dynamic> _handleResponse(Response response) {
    _logger.d('Response - statusCode: ${response.statusCode}');
    final decodedBody = json.decode(response.body);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (decodedBody is List) {
        List<Map<String, dynamic>> modifiedList = [];

        for (var item in decodedBody) {
          if (item is Map<String, dynamic>) {
            item.addAll({'statusCode': response.statusCode});
            modifiedList.add(item);
          }
        }

        _logger.wtf('Response - body list: $modifiedList');
        return {'data': modifiedList, 'statusCode': response.statusCode};
      }
    }

    _logger.d('Response error ${response.body}');
    var map = cast<Map<String, dynamic>>(decodedBody);
    if (map != null) {
      map.addAll({'statusCode': response.statusCode});
      _logger.wtf('Response - body map: $map');
      return map;
    }
    return {'statusCode': response.statusCode};
  }

  Map<String, dynamic> _handlerError(Object e) {
    _logger.e('APIRepository - Error post $e ');
    return {
      'status': false,
      'message': 'Error post $e',
      'statusCode': '500',
    };
  }
}
