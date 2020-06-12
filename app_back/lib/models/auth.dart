import 'package:appback_sdk/models/endpoint.dart';
import 'package:appback_sdk/models/token.dart';

class Auth {
  Token _token;
  Endpoint _endpoint;

  Auth(this._token, this._endpoint);

  Token get token => _token;

  Endpoint get endpoint => _endpoint;
}
