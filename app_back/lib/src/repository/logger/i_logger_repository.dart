import 'package:app_back/exceptions/app_back_exception.dart';

abstract class ILoggerRepository {
    void logEvent(String endpoint, String token, Map<String, dynamic> parameters, Function onSuccess, Function(AppBackException) onFailure);
}