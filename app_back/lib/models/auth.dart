import 'package:app_back/models/endpoint.dart';
import 'package:app_back/models/token.dart';

class Auth {
    Token _token;
    Endpoint _endpoint;
    
    Auth(this._token, this._endpoint);
    
    Token get token => _token;
    Endpoint get endpoint => _endpoint;
}