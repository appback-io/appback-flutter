import 'dart:convert';

import 'package:appback_sdk/exceptions/app_back_exception.dart';
import 'package:appback_sdk/src/constants/constants.dart';
import 'package:appback_sdk/src/repository/logger/i_logger_repository.dart';
import 'package:http/http.dart' as http;

class LoggerRepository implements ILoggerRepository {
  final _client = http.Client();

  @override
  void logEvent(String endpoint, String token, Map<String, dynamic> parameters,
      Function onSuccess, Function(AppBackException) onFailure) {
    _client
        .post("$endpoint$kEVENT_LOG_URL",
            headers: {
              kAUTHORIZATION: kBEARER + token,
              "Content-Type": "application/json"
            },
            body: jsonEncode(parameters))
        .then((response) {
      print(response.body);
      if (response.statusCode == 201) {
        onSuccess();
      } else if (response.statusCode == 400) {
        onFailure(AppBackException("Bad request"));
      } else if (response.statusCode == 404) {
        onFailure(AppBackException("Resource Not Found"));
      }
    }).catchError((error) => AppBackException(error.toString()));
  }
}
