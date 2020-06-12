import 'package:appback_sdk/exceptions/app_back_exception.dart';
import 'package:appback_sdk/models/toggle.dart';

abstract class IToggleRepository {
  void getToggles(String endpoint, String token, String router,
      Function(List<Toggle>) onSuccess, Function(AppBackException) onFailure);
}
