import 'package:app_back/exceptions/app_back_exception.dart';

abstract class ITokenRepository {
    
    /// Gets the authentication token related to the [secretKey] and
    /// returns true, throws [AppBackException] by the following reasons:
    /// 400 There was a 'Bad request',
    /// 404 The resource was not found, this happens e.g when the api router identifier doesn't exist.
    /// or returns false if there was an internal error.
    Future<bool> getToken(String secretKey);
}