import 'package:app_back/exceptions/app_back_exception.dart';
import 'package:app_back/models/token.dart';

abstract class ITokenRepository {
    
    /// Gets the authentication token related to the [secretKey] and
    /// returns the token, throws [AppBackException] for the following reasons:
    /// 400 There was a 'Bad request',
    /// 404 The resource was not found, this happens e.g when the api router identifier doesn't exist.
    Future<Token> getToken(String secretKey);
}